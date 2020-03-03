%% Test SVM
clear all, clc
%run('~/JeanneretMadrid/lab8/VLFEATROOT/toolbox/vl_setup')
tic
load('trainedSVM3.mat')

%testDir = fullfile('~','lab9Detection','TestImages');
testDir = fullfile('lab9Detection','WIDER_val','images');
resultDir = 'result';
if ~exist(resultDir,'dir')
    mkdir(resultDir)
end

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
    % hogC = cell(1,length(fileName));
    fprintf(['Processing category: ' categories{i} '\n'])
    if ~exist(fullfile(resultDir,categories{i}),'dir')
        mkdir(fullfile(resultDir,categories{i}))
    end
    
    parfor j = 1:length(fileName)
        im = imread(fullfile(testDir,categories{i},fileName{j}));
        % im = im2single(rgb2gray(imread(fullfile(testDir,categories{i},fileName{j}))));
        %[~]=labelsIm(im,w,b,cellSize,fileName{j},fullfile(resultDir,categories{i}),1);
        labelIm2(w,b,im,fileName{j},fullfile(resultDir,categories{i}))
    end
end
toc
