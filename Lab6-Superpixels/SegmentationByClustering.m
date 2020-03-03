function segmentation = segmentByClustering( rgbImage, featureSpace, clusteringMethod, numberOfClusters)

if nargin~=4
    error('The number of output should be 4');
end

if ~length(featureSpace)==3 || ~length(featureSpace)==6
    error('featureSpace sould be length 3 or 6')
end

if numberOfClusters<2 || mod(numberOfClusters,1)~=0
    error('Check the numberOfCluster entry')
end

if ~strcmp(clusteringMethod,'k-means') && ~strcmp(clusteringMethod,'gmm') && ~strcmp(clusteringMethod,'hierarchical') && ~strcmp(clusteringMethod,'watershed')
    error('cluesteringMethod is not defined')
end
if strcmp(featureSpace(1:3),'rgb')
    im = rgbImage;
elseif strcmp(featureSpace(1:3),'hsv')
    im = rgb2hsv(rgbImage);
elseif strcmp(featureSpace(1:3),'lab')
    im = rgb2lab(rgbImage);
else
    error('The featureSpace only accepts rgb, hsv or lab as entry')
end



if length(featureSpace)==6
    if strcmp(featureSpace(4:6),'+xy')
        mesh1 = meshgrid(1:size(im,2),1:size(im,1));
        mesh2 = meshgrid(1:size(im,1),1:size(im,2))';
        mesh1 = cat(3,mesh1,mesh2);
        im = cat(3,im,mesh1);
    end
end

n = size(im);
vectors = zeros([n(1)*n(2) n(3)]);
% transform the image into
for j = 1:n(2)
    for i = 1:n(1)
        vectors((j-1)*n(1)+i,:)=reshape(im(i,j,:),1,[]);
    end
end
if strcmp(clusteringMethod,'k-means')
    % each vector is organized into a new matrix where each row is the
    % vector
    [idx,~]=kmeans(vectors,numberOfClusters);
    segmentation=T;
end
if strcmp(clusteringMethod,'gmm')
    % Not finished yet
    GMM = fitgmdist(vectors,numberOfClusters,'RegularizationValue',0.1);
    % Classification normalizing (valor-mu)/desv
    dists = zeros(size(vectors,1),numberOfClusters);
    mu = GMM.mu;
    sig = GMM.Sigma;
    for i =1:numberOfClusters
        for j = 1:size(vectors,1)
%             size(mu(:,i))
%             size(vectors(:,j))
            dists(j,i) = norm(mu(i,:)-vectors(j,:))./sig(i,i);
        end
    end
    [~,A]=max(dists,[],2);
    segmentation = {reshape(A,n(1),n(2)),GMM};
end
% HIERARCHICAL CLUSTERING
if strcmp(clusteringMethod,'hierarchical')
    % The resolution of the image is lowered to 100x100
    % im = imresize(im, [100 100]);
    im = imresize(im, [50 50]);
    m=size(im);
    vectors = zeros([m(1)*m(2) m(3)]);
    % transform the image into representation space
    for j = 1:m(2)
        for i = 1:m(1)
            vectors((j-1)*m(1)+i,:)=reshape(im(i,j,:),1,[]);
        end
    end
    % hierarchical segementation
    Dists = pdist(vectors);
    Dists = squareform(Dists);
    Z = linkage(Dists,'centroid','euclidean','savememory', 'on');
    T = cluster(Z, 'maxclust', numberOfClusters);
    T = reshape(T,100,100);
    segmentation = imresize(T,[n(1) n(2)],'nearest');
end
if strcmp(clusteringMethod,'watershed')
    % This code cannot guarantee a segmentation in a number of regions. It depends on the contrast difference for minima.
    % This parameter, h, has a very important effect on the results of the segmentation, but varies strongly from one
    % image to another.
    im = rgb2gray(rgbImage);
    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(im), hy, 'replicate');
    Ix = imfilter(double(im), hx, 'replicate');
    grad = Iy.^2+Ix.^2;
    
    h = 500; % Contrast difference to be considered a minimum. 
    ucm = zeros(size(grad));
    marker = imextendedmin(grad, h);
    new_grad = imimposemin(grad, marker);
    ws = watershed(new_grad);
    ucm = max(ucm,h*(ws==0));
    
    segmentation= ucm;
    end
end
end


