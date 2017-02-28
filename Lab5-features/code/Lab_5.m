%We create the filter bank
tic
[fb] = fbCreate;

%I load the images
numIm = [6 12 18 24 30];
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
        vt1 = assignTextons(fbRun(fb,imread(['T' n1 '_' n2 '.jpg'])),textons');
        histos = [histos histc(vt1(:),1:k)/numel(vt1)];
    end
end


%% TEST

