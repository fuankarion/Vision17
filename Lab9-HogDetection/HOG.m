clear all; clc

% run('VLFEATROOT/toolbox/vl_setup')

% path2images = '/datos1/vision/lab9Detection/TrainCrops/';

cd C:\Users\usuario\Dropbox\Universidad\Maestria2\Vision\Textures

files = dir
directoryNames = {files([files.isdir]).name}
directoryNames = directoryNames(~ismember(directoryNames,{'.','..'}))

images = cell(0, 4);

for i=1:length(directoryNames)
  folder = directoryNames{i};
  cd(folder)
  ims = dir('*.jpg');
  
    for j=1:length(ims)
    images{end + 1, 1} = imread(ims(j).name);
    end
    
 cd ..
end

%% MULTISCALE %%
% Database images (or crops) do not come in a fixed size. Average size for
% crops is 100x125 pixels. We rescale them to three other fixed sizes

[lengthimages size2] = size(images);

for i=1:lengthimages
    
    images{i,2} =  imresize(images{i,1}, [100 125]);
    images{i,3} =  imresize(images{i,1}, [70 88]);
    images{i,4} =  imresize(images{i,1}, [50 62]);
    
end

%% HOG %%
% Apply HOG to each scale in the image cell

imageHogs = cell(lengthimages, size2);

for i=1:lengthimages
    for j=1:size2
            
        im = images{i,j};    
        im = im2single(im);

        cellSize = 8;
        hog = vl_hog(im, cellSize) ;
        %imhog = vl_hog('render', hog, 'verbose') ;
        %clf ; imagesc(imhog) ; colormap gray ;
        imageHogs{i,j} = hog;
    end
end

%% NEGATIVES FOR THE SVM
% To produce negatives for the SVM, we extract random patches from images
% in the complete train set and we compute their HOG. It is very unlikely
% that these patches correspond to positives.

cd train

files = dir
directoryNames = {files([files.isdir]).name}
directoryNames = directoryNames(~ismember(directoryNames,{'.','..'}))

negs = cell(0, 1);

for i=1:length(directoryNames)
  folder = directoryNames{i};
  cd(folder)
  ims = dir('*.jpg');
  
    for j=1:length(ims)
    ima = imread(ims(j).name);
    ima = im2single(ima);
    [size1 size2] = size(ima);
    
    xo = round(rand()*(size1 - 100));
    xf = xo + 100;
    yo = round(rand()*(size2 - 125));
    yf = yo + 125;
    
    cellSize = 8;
    hogneg = vl_hog(ima(xo:xf, yo:yf), cellSize);
    negs{end + 1, 1} = hogneg;
    end
    
 cd ..
end

%% TRAIN THE SVM %%
% Use previosuly acquired positives and negatives to train the SVM.

positives = imageHogs(:,2); numPos = length(positives);
numNeg = length(negs);

pos = zeros(13*16*31, numPos);
neg = zeros(13*16*31, numNeg);

for i=1:numPos
    pos(:,i) = reshape(positives{i}, 13*16*31, 1);
end

for i=1:numNeg
    neg(:,i) = reshape(negs{i}, 13*16*31, 1);
end

annotationsPos = ones(1, size(pos, 2));
annotationsNeg = -ones(1, size(neg, 2));

Annotations = vertcat(annotationsPos, annotationsNeg);

X = horzcat(pos, neg);

% Defie confidence parameter
C = 10 ;
lambda = 1 / (C * (numPos + numNeg)) ;

% Learn the SVM using an SVM solver
w = vl_svmtrain(X,Annotations,lambda,'epsilon',0.01,'verbose') ;





