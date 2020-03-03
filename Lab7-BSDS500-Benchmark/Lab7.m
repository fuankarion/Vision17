names = {'train' , 'val' , 'test'};
k = [5, 10, 20];
for k2 = 1:3
    directory =[ './BSR/BSDS500/data/images/' names{k2} '/*.jpg'];
    Files = dir(directory);
    segmentations = cell(numel(Files), numel(k), 2);
    for i = 1:length(Files)
        im = imread([directory(1:(end-5)) Files(i).name]);
        for j = 1:numel(k)
            segmentations{i,j,1} = segmentByClustering(im, 'rgb+xy', 'k-means', k(j));
            segmentations{i,j,2} = segmentByClustering(im, 'rgb', 'watershed', k(j));
        end
    end
    save(['Segmentation_cell_' names{k2} '.mat'], 'segmentations');
end
