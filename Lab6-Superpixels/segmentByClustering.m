function segmentation = segmentByClustering(rgbImage,featureSpace,clusteringMethod,numberOfClusters)
switch featureSpace
    case 'rgb'
    case 'lab'
    case 'hsv'
    case 'rgb+xy'
    case 'lab+xy'
    case 'hsv+xy'
    otherwise
end
switch clusteringMethod
    case 'k-means'
    case 'gmm'
    case 'hierarchical'
    case 'watershed'
    otherwise
end
numberOfClusters=max(2,numberOfClusters);
end