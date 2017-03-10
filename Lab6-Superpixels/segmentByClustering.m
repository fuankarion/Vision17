function segmentation = segmentByClustering(rgbImage,featureSpace,clusteringMethod,numberOfClusters)
numberOfClusters=max(2,numberOfClusters);

Precision=8; % bit
rgbImageN=double(rgbImage)./(2^Precision-1);
switch featureSpace(1:3)
    case 'lab'
        Im=rgb2lab(rgbImageN);
        RLab=rgb2lab(cat(3,1,0,0));
        GLab=rgb2lab(cat(3,0,1,0));
        YLab=rgb2lab(cat(3,1,1,0));
        BLab=rgb2lab(cat(3,0,0,1));
        Im(:,:,1)=Im(:,:,1)./100;
        Im(:,:,2)=(Im(:,:,2)-GLab(2))./(RLab(2)-GLab(2));
        Im(:,:,3)=(Im(:,:,3)-BLab(3))./(YLab(3)-BLab(3));
    case 'hsv'
        Im=rgb2hsv(rgbImageN);
    otherwise
        Im=rgbImageN;
end
if strcmp(featureSpace(end-2:end),'+xy')
    [X,Y]=meshgrid((1:size(rgbImage,1))./size(rgbImage,1),...
        (1:size(rgbImage,2))./size(rgbImage,2));
    Im=cat(3,Im,X,Y);
end

switch clusteringMethod
    case 'k-means'
%         ImMat=[];
%         for i=1:size(Im,3)
%             Chn=Im(:,:,i);
%             ImMat=cat(2,Chn(:));
%         end
        ImMat=reshape(Im,[],size(Im,3));
        Idx=kmeans(ImMat,numberOfClusters);
        segmentation=reshape(Idx,size(Im,1),size(Im,2));
    case 'gmm'
        ImMat=[];
        for i=1:size(Im,3)
            Chn=Im(:,:,i);
            ImMat=cat(2,Chn(:));
        end
        GMMModel=fitgmdist(ImMat,numberOfClusters);
        Idx=cluster(GMMModel,ImMat);
        segmentation=reshape(Idx,size(Im,1),size(Im,2));
    case 'hierarchical'
        ImMat=[];
        for i=1:size(Im,3)
            Chn=Im(:,:,i);
            ImMat=cat(2,Chn(:));
        end
        Dist=linkage(pdist(ImMat));
        Idx=cluster(Dist,'maxclust',numberOfClusters);
        segmentation=reshape(Idx,size(Im,1),size(Im,2));
    case 'watershed'
        ImMat=mean(Im,3);
        for i=0:1e-1:1
            
        end
    otherwise
end
end