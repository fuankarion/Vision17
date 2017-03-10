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

% im = imread('3c.jpg');
% im = imresize(im, 0.1);
% ab = double(im(:,:,));
% nrows = size(im(:,:,1));
% ncols = size(im(:,:,2));
% nplanes = size(im(:,:,3));
% im_reshape = reshape(im,nrows*ncols*nplanes,3);
%
% % repeat the clustering 3 times to avoid local minima
% [cluster_idx, cluster_center] = kmeans(im_reshape,numberOfClusters)
% % pixel_labels = reshape(cluster_idx,nrows,ncols,nplanes);
% imshow(pixel_labels,[]), title('image labeled by cluster index');
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
if strcmp(clusteringMethod,'hierarchical')
        % Superpixels are created using watersheds
    I = rgb2gray(rgbImage);
    hy = fspecial('sobel');
    grad = sqrt(imfilter(double(I), hy', 'replicate').^2 + imfilter(double(I), hy, 'replicate').^2);
    h=20;
    marker = imextendedmin(grad, h);
    new_grad = imimposemin(grad, marker);
    ws = watershed(new_grad);
    
    % We take the each region of the watershed and compact it to make a
    % super pixel catacterized by the mean vector.
    vectors = zeros(max(ws(:)),n(3));
    temp = zeros(1,n(3));
    for i = 1:max(ws(:))
        [row,col]=find(ws==i);
        for j=1:numel(row)
            temp2=im(row(j),col(j));
            temp=temp+temp2(:)';
        end
        vectors(i,:)=temp/numel(row);
    end
    
    Dists = pdist(vectors);
    Dists = squareform(Dists);
    Z = linkage(Dists,'centroid','euclidean','savememory', 'on');
    T = cluster(Z, 'maxclust', numberOfClusters);
    segmentation = reshape(T, n(1), n(2)); 
end
if strcmp(clusteringMethod,'watershed')
    % Not finished yet
    im = rgb2gray(rgbImage);
    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(im), hy, 'replicate');
    Ix = imfilter(double(im), hx, 'replicate');
    grad = Iy.^2+Ix.^2;
    segmentation= watershed(grad);
    A = max(segmentation(:));
    marker = imextendedmin(grad, A-numberOfClusters);
    new_grad = imimposemin(grad, marker);
    segmentation= watershed(new_grad);
    
    
    %%%% Just a start
        % Not finished yet
    im = rgb2gray(rgbImage);
    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(im), hy, 'replicate');
    Ix = imfilter(double(im), hx, 'replicate');
    grad = Iy.^2+Ix.^2;
    
    for h = 10:10:50
        marker = imextendedmin(grad, h);
        new_grad = imimposemin(grad, marker);
        ws = watershed(new_grad);
        figure; 
        subplot(1,2,1); 
        imshow(im);
        subplot(1,2,2);
        imshow(ws==0);
        title(h);
    
        segmentation= watershed(grad);
        A = max(segmentation(:));
        marker = imextendedmin(grad, A-numberOfClusters);
        new_grad = imimposemin(grad, marker);
        segmentation= watershed(new_grad);
    end
end
end


