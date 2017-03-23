addpath('bench_fast/benchmarks');

imgDir = 'BSDS500/data/images/train';
gtDir = 'BSDS500/data/groundTruth/train';
inDir = 'BSDS500/data/kmeansSeg';
mkdir(inDir);
outDir = 'BSDS500/outDir';
mkdir(outDir);
nthresh = 99;

cd ..
load Segmentation_cell_train.mat
directory ='./BSR/BSDS500/data/images/train/*.jpg';
Files = dir(directory);
cd BSR



for i=1:length(Files)
    nombreArchivo = Files(i).name;
    segs = cell(1,3);
    for j = 1:3
        segs{j}=segmentations{i,j,1};
    end
    save([inDir '/' nombreArchivo(1:end-5) '.mat'],'segs')
end

tic;
allBench_fast(imgDir, gtDir, inDir, outDir, nthresh);
toc;
save workspace.mat
