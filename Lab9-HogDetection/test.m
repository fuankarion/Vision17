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
        labByHog=labelsIm(im,w,b,cellSize,fileName{j});
        labByHog=labByHog==1;
        hogC{j}=labByHog;
        save(fullfile(resultDir,[fileName{j}(1:(end-4)) '.mat']),'labByHog')
    end
    class{1,i} = hogC;
end
toc
save('classification.mat','class')

%% change to real size
mkdir(fullfile(testDir,'logical')) 
testDir = fullfile('lab9Detection','TestImages');
for i = 1:length(categories) 
    for j = 1:length(fileName)
        load(fullfile(resultDir,[fileName{j}(1:(end-4)) '.mat']))
        im = im2single(rgb2gray(imread(fullfile(testDir,categories{i},fileName{j}))));
        [s1, s2]= size(im);
        [l1, l2] = size(labByHog);
        manto = zeros(s1,s2);
        
        [row,col]=find(labByHog);
        %Reescalo la posición de los 1's
        row = round(s1*row/l1);
        col = round(s1*col/l1);
        
        manto(row,col)=true;
        
        % Cada 1 rpresenta la posición izquierda superior del recuadro.
        % Cada cuadrito tiene dimensión 125x100
        
        save(fullfile(testDir,'logical',[fileName{j}(1:(end-4)) '.mat']),'manto')
        
    end
end

