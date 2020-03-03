function segmentation = segmentByClustering( rgbImage, featureSpace, clusteringMethod, numberOfClusters)

if featureSpace = 'RGB'
    im = rgbImage
elseif featureSpace = 'HSV'
    im = rgb2hsv(rgbImage)
elseif feautureSpace = 'Lab'
    im = rgb2Lab(rgbimage)
elseif f
end
   
numberOfClusters = 2;

im = imread('3c.jpg');
im = imresize(im, 0.1);
%ab = double(im(:,:,));
nrows = size(im(:,:,1));
ncols = size(im(:,:,2));
nplanes = size(im(:,:,3));
im_reshape = reshape(im,nrows*ncols*nplanes,3);

% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(im_reshape,numberOfClusters)
pixel_labels = reshape(cluster_idx,nrows,ncols,nplanes);
imshow(pixel_labels,[]), title('image labeled by cluster index');
   