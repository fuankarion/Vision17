names = {'24063','25098','26031','27059','48055','54005','55067','55075'};
methods = {'k-means', 'gmm', 'hierarchical','watershed'};
colorSpace = {'rgb','hsv','lab','+xy'};
segm = cell{numel(names),numel(methods),numel(colorSpace),5};
for i = 1:numel(names)
    
    load([names{i} '.mat'])
    im = imread([names{i} '.jpg']);
    for j=1:numel(groundTruth)
        
    end
    
end
