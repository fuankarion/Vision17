function segmentation = segmentByClustering(rgbImage,featureSpace,...
    clusteringMethod,numberOfClusters)

% Verificar que la imagen posea 3 canales
if size(rgbImage,3)==1
    rgbImage=repmat(rgbImage,1,1,3);
end

numberOfClusters=max(2,numberOfClusters);

Precision=8; % bit
rgbImageN=double(rgbImage)./(2^Precision-1);
switch featureSpace(1:3)
    case 'rgb'
        Im=rgbImageN;
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
        error('Undefined featureSpace');
end
if strcmp(featureSpace(end-2:end),'+xy')
    [X,Y]=meshgrid((0:size(rgbImage,2)-1)./(size(rgbImage,2)-1),...
        (0:size(rgbImage,1)-1)./(size(rgbImage,1)-1));
    Im=cat(3,Im,X,Y);
end

switch clusteringMethod
    case 'k-means'
        ImMat=reshape(Im,[],size(Im,3));
        Idx=kmeans(ImMat,numberOfClusters);
        segmentation=reshape(Idx,size(Im,1),size(Im,2));
    case 'gmm'
        ImMat=reshape(Im,[],size(Im,3));
        GMMModel=fitgmdist(ImMat,numberOfClusters);
        Idx=cluster(GMMModel,ImMat);
        segmentation=reshape(Idx,size(Im,1),size(Im,2));
    case 'hierarchical'
        ImMat=reshape(Im,[],size(Im,3));
        Dist=linkage(ImMat,'ward','euclidean','savememory','on');
        Idx=cluster(Dist,'maxclust',numberOfClusters);
        segmentation=reshape(Idx,size(Im,1),size(Im,2));
    case 'watershed'
        ImMat=mean(Im,3);
%         hy=fspecial('sobel');
%         hx=hy';
%         ImY=imfilter(ImMat,hy,'replicate');
%         ImX=imfilter(ImMat,hx,'replicate');
%         Grad=sqrt(ImX.^2+ImY.^2);
%         Edge=im2bw(Grad,graythresh(Grad));
        Edge=edge(ImMat,'Canny');
        Edge=imdilate(Edge,strel('diamond',1));
        Label=bwlabel(~Edge);
        MaxLabel=max(Label(:));
        Hist=zeros(MaxLabel,1);
        for i=1:MaxLabel
            Hist(i)=nnz(Label(:)==i);
        end
        [~,IdxS]=sort(Hist,'descend');
        Marker=zeros(size(Label));
        for i=1:numberOfClusters
            Marker=or(Marker,Label==IdxS(i));
        end
        ImMin=imimposemin(ImMat,Marker);
        segmentation=watershed(ImMin);
    otherwise
        error('Undefined clusteringMethod');
end
end