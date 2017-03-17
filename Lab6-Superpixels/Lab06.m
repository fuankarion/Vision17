clear all, close all, clc
addpath('Lab5Images');
Name='24063';
rgbImage=imread([Name,'.jpg']);
load([Name,'.mat']);
GroundTruth=groundTruth{2}.Segmentation;
numberOfClusters=6;
featureSpaces={'rgb','rgb+xy','hsv','hsv+xy','lab','lab+xy'};
clusteringMethods={'k-means','gmm','hierarchical','watershed'};
GTVec=[2,3,4,5];
figure(1);
for clusteringMethod=clusteringMethods
% for featureSpace=featureSpaces
    tic
    Segmentation=segmentByClustering(rgbImage,featureSpaces{3},...
        clusteringMethod{1},numberOfClusters);
    toc
    image(Segmentation), colormap colorcube
    SegVec=input('Vector de etiquetas: ');
    Jacc=EvulateSegmentation(Segmentation,GroundTruth,SegVec,GTVec);
    fprintf('Indice de Jaccard de %s es %f\n ',clusteringMethod{1},Jacc);
end