%We create the filter bank
tic
[fb] = fbCreate;

%I load the images
numIm = [1:3:30];
[images] = loadImages(numIm);
%%
%Clusters
k = 25*numel(numIm) ;

%Apply filterbank to sample image
filterResponses=fbRun(fb,images);
%%
%Computer textons from filter
[map,textons] = computeTextons(filterResponses,k);
toc
save 'matrix2.mat'

%%

% adding the texton representation of an image

% histos is a variable where each row stores a normalized histogram of the
% training images.
addpath('train');
addpath('test');

histos = [];

for j =1:25
    for i = 1:numel(numIm)
        if j<10
            n1 = ['0' num2str(j)];
        else
            n1 = num2str(j);
        end
        
        if numIm(i)<10
            n2 = ['0' num2str(numIm(i))];
        else
            n2 = num2str(numIm(i));
        end
        vt1 = assignTextons(fbRun(fb,imread(['train/T' n1 '_' n2 '.jpg'])),textons');
        histos = [histos histc(vt1(:),1:k)/numel(vt1)];
    end
end


%% Test

confMat = zeros(25);

for i = 1:25
    for j=31:40
        
        if i<10
            n1 = ['0' num2str(i)];
        else
            n1 = num2str(i);
        end
        
        vt1 = assignTextons(fbRun(fb,imread(['test/T' n1 '_' num2str(j) '.jpg'])),textons');
        [~,I] = chiSqDist(histc(vt1(:),1:k)/numel(vt1),histos);
        if I ~= mod(I,numel(numIm))
            I = (I-mod(I,numel(numIm)))/numel(numIm);
        end
        confMat(I,i)=confMat(I,i)+1;
    end
end
confMat = confMat/10;

confianza = sum(diag(confMat))/25;

%% TreeBagger Test

class = ones([length(numIm)*25 1]);
for i=1:25

    class((1+(i-1)*length(numIm)):(i*length(numIm)))=i*ones([length(numIm) 1]);
  
end

nTrees = 50;

dTree = TreeBagger(nTrees,histos',class','Method', 'classification');


%%%%%%% Saves the  workspace and the confidence matrix
save workspace2.mat
save confidence.mat confianza
