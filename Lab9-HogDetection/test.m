%% Test SVM
clear all, clc
%run('~/JeanneretMadrid/lab8/VLFEATROOT/toolbox/vl_setup')
tic
load('trainedSVM2.mat')

%testDir = fullfile('~','lab9Detection','TestImages');
testDir = fullfile('lab9Detection','TestImages');
resultDir = 'result';
mkdir(resultDir)

% Compute hog from the faces
categories = dir(testDir);
categories = categories([categories.isdir]);
categories = {categories(3:end).name};

% Cell where everything is stored
class = cell(1,length(categories));
cellSize=8;
for i = 1:length(categories) 
    fileName = fullfile(testDir,categories{i},'*.jpg');
    fileName = dir(fileName);
    fileName = fileName(~[fileName.isdir]);
    fileName = {fileName.name};
    hogC = cell(1,length(fileName));
    fprintf(['Processing category: ' categories{i} '\n'])
    for j = 1:length(fileName)
        fprintf(['    Processing picture: ' fileName{j} '\n'])
        im = im2single(rgb2gray(imread(fullfile(testDir,categories{i},fileName{j}))));
        labByHog=labelsIm(im,w,b,cellSize);
        hogC{j}=labByHog;
        save(fullfile(resultDir,[fileName{j}(1:(end-4)) '.mat']),'labByHog')
    end
    class{1,i} = hogC;
end
toc
save('classification.mat','class')
