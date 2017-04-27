%% lab9;
%clear all, clc, close all

root = pwd;

%path2images = '/datos1/vision/lab9Detection/TrainCrops/';
path2images = 'lab9Detection\TrainCrops\';

% cd C:\Users\usuario\Dropbox\Universidad\Maestria2\Vision\Textures

cd(path2images);

files = dir
directoryNames = {files([files.isdir]).name}
directoryNames = directoryNames(~ismember(directoryNames,{'.','..'}))

images = cell(0, 4);
%% Read Images

fprintf('Reading images\n')

for i=1:length(directoryNames)
    folder = directoryNames{i};
    cd(folder)
    ims = dir('*.jpg');
    
    for j=1:length(ims)
        images{end + 1, 1} = imread(ims(j).name);
    end
    
    cd ..
end



%% get image resizes

fprintf('Resizeing images\n')

[lengthimages, size2] = size(images);

for i=1:lengthimages
    
    images{i,2} =  imresize(images{i,1}, [125 100]);
    images{i,3} =  imresize(images{i,1}, [100 80]);
    images{i,4} =  imresize(images{i,1}, [80 80]);
    
end


%% get Hogs

fprintf('Getting hogs from faces\n')

hogs = cell([lengthimages size2-1]);
cellSize=8;
for i = 1:lengthimages
    for j = 1:size2-1
        hogs{i,j}=vl_hog(im2single(images{i,j+1}),cellSize);
    end
end


%% transform hogs to vectors

fprintf('Transforming hogs to vectors\n')

cellHogVec = cell(size2-1,1);
for i = 1:size2-1
    vec = zeros(numel(hogs{1,i}),lengthimages);
    for j = 1:lengthimages
        vec(:,j)=hogs{j,i}(:);
    end
    cellHogVec{i}=vec;
end
save('cellHogVec.mat','cellHogVec')

%% Get negatives

fprintf('getting negatives\n')

cd(root)
negFol = fullfile('lab9Detection','TrainImages');
cropFol = fullfile('lab9Detection','TrainCrops');
cellHogVecNeg = cell(0,3);
if ~exist('randomPatches.mat')
    tic
    for i = 1:length(directoryNames)
        
        fileList = dir(fullfile(negFol,directoryNames{i},'*.jpg'));
        fileList = {fileList.name};
        
        faceDir = dir(fullfile(cropFol,directoryNames{i},'*.jpg'));
        faceDir = {faceDir.name};
        
        for j = 1:length(faceDir)
            
            storage = cell(1,3);
            
            im = im2single(imread(fullfile(negFol,directoryNames{i},fileList{mod(j,length(fileList))+1})));
            
            % negatives for [125 100]
            
            row = ceil((size(im,1)-125-1)*rand);
            col = ceil((size(im,2)-100-1)*rand);
            imCell = im(row:(row+125-1),col:(col+100-1));
            storage{1} = vl_hog(imCell,cellSize);
            
            
            
            % negatives for [100 80]
            
            row = ceil((size(im,1)-100-1)*rand);
            col = ceil((size(im,2)-80-1)*rand);
            imCell = im(row:(row+100-1),col:(col+80-1));
            storage{2} = vl_hog(imCell,cellSize);
            
            
            
            % negatives for [80 80]
            
            row = ceil((size(im,1)-80-1)*rand);
            col = ceil((size(im,2)-80-1)*rand);
            imCell = im(row:(row+80-1),col:(col+80-1));
            storage{3} = vl_hog(imCell,cellSize);
            
            cellHogVecNeg = cat(1,cellHogVecNeg,storage);
            
        end
        
        
        
    end
    toc
    
    save('randomPatches.mat','cellHogVecNeg')
else
    load('randomPatches.mat');
end
%% Get hog vectors from negatives

fprintf('Getting vectorial form of hogs in negative patches\n')

hogs = cellHogVecNeg;

cellHogVecNeg = cell(size2-1,1);
for i = 1:size2-1
    vec = zeros(numel(hogs{1,i}),lengthimages);
    for j = 1:lengthimages
        vec(:,j)=hogs{j,i}(:);
    end
    cellHogVecNeg{i}=vec;
end

save('cellHogVecNeg.mat','cellHogVecNeg')

% Anotation vector

positives = ones(1,size(cellHogVec{1},2));
negatives = -ones(1,size(cellHogVecNeg{1},2));
labels = [positives, negatives];

cellVectors = cell(size2-1,1);
for i = 1:size2-1
    cellVectors{i} = [cellHogVec{i},cellHogVecNeg{i}];
end

% Train SVM
% Defie confidence parameter
C = 10 ;
lambda = 1 / (C * (length(positives) + length(negatives))) ;

% Learn SVM
w = cell(1,size2-1);
b = w;
for i = 1:size2-1
    [w{i},b{i}] = vl_svmtrain(cellVectors{i},labels,lambda,'epsilon',0.01,'verbose');
end

save('trainedSVM3.mat','w','b')