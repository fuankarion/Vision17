directory = './data/images/*.jpg';


Files = dir(directory);

k = [5, 10, 20];

segmentations = cell(numel(Files), numel(k), 2);

for i = 1:length(Files)
    
    im = imread([directory(1:(end-5)) Files(i).name]);
    
    for j = 1:numel(k)
        segmentatios{i,j,1} = segmentByClustering(im, 'rgb+xy', 'k-means', k(j));
        segmentatios{i,j,2} = segmentByClustering(im, 'rgb', 'watershed', k(j));
        
   
    end

end

save('Segmentation_Cell.mat', 'segmentations'); 
