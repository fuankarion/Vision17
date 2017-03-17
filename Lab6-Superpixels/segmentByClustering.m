function segmentation = segmentByClustering(rgbImage,featureSpace,...
    clusteringMethod,numberOfClusters)

% Verificar que la imagen posea 3 canales
if size(rgbImage,3)==1
    rgbImage=repmat(rgbImage,1,1,3);
end
% Verificar numero maximo de clusters
numberOfClusters=max(2,numberOfClusters);
% Precision de imagen de entrada
Precision=8; % bit
% Normalizacion de imagen de entrada
rgbImageN=double(rgbImage)./(2^Precision-1);
% Asignacion de imagen segun espacio de color especificado
switch featureSpace(1:3)
    % Caso RGB se usa imagen normalizada por defecto
    case 'rgb'
        Im=rgbImageN;
    % Caso Lab se normaliza el canal L al valor maximo 100, canales a y b
    % se normalizan respecto a sus minimos y maximos: Verde y Rojo,
    % Amarillo y Azul respectivamente
    case 'lab'
        Im=rgb2lab(rgbImageN);
        RLab=rgb2lab(cat(3,1,0,0));
        GLab=rgb2lab(cat(3,0,1,0));
        YLab=rgb2lab(cat(3,1,1,0));
        BLab=rgb2lab(cat(3,0,0,1));
        Im(:,:,1)=Im(:,:,1)./100;
        Im(:,:,2)=(Im(:,:,2)-GLab(2))./(RLab(2)-GLab(2));
        Im(:,:,3)=(Im(:,:,3)-BLab(3))./(YLab(3)-BLab(3));
    % Caso HSV solo se convierte imagen normalizada
    case 'hsv'
        Im=rgb2hsv(rgbImageN);
    % Error en caso de pedir un canal no existente
    otherwise
        error('Undefined featureSpace');
end
% Agregar dimensiones espaciales en la 3D en caso de pedirla
if strcmp(featureSpace(end-2:end),'+xy')
    % Creacion de matriz con valores espaciales
    [X,Y]=meshgrid((0:size(rgbImage,2)-1)./(size(rgbImage,2)-1),...
        (0:size(rgbImage,1)-1)./(size(rgbImage,1)-1));
    % Concatenacion en la 3D
    Im=cat(3,Im,X,Y);
end
% Segmentacion segun metodo de clustering
switch clusteringMethod
    % Caso k-means
    case 'k-means'
        % Se convierte la imagen 3D de MxNxC a 2D de M*NxC
        ImMat=reshape(Im,[],size(Im,3));
        % Obtener los indices de clusterizado en todos los pixeles
        Idx=kmeans(ImMat,numberOfClusters);
        % Convertir el vector 1D de indices M*N a 2D de MxN
        segmentation=reshape(Idx,size(Im,1),size(Im,2));
    case 'gmm'
        % Se convierte la imagen 3D de MxNxC a 2D de M*NxC
        ImMat=reshape(Im,[],size(Im,3));
        % Crear modelo de mezcla de gausianas
        GMMModel=fitgmdist(ImMat,numberOfClusters);
        % Someter imagen a modelo y obtener indicies
        Idx=cluster(GMMModel,ImMat);
        % Convertir el vector 1D de indices M*N a 2D de MxN
        segmentation=reshape(Idx,size(Im,1),size(Im,2));
    case 'hierarchical'
        % Se convierte la imagen 3D de MxNxC a 2D de M*NxC
        ImMat=reshape(Im,[],size(Im,3));
        % Crear dendograma 
        Dist=linkage(ImMat,'centroid','euclidean','savememory','on');
        % Cortar dendograma en numero de clusters pedido
        Idx=cluster(Dist,'maxclust',numberOfClusters);
        % Convertir el vector 1D de indices M*N a 2D de MxN
        segmentation=reshape(Idx,size(Im,1),size(Im,2));
    case 'watershed'
        % Promediar imagen sobre la 3D
        ImMat=mean(Im,3);
        % Obtencion de bordes
        Edge=edge(ImMat,'Canny');
        % Ensanchamiento de bordes
        Edge=imdilate(Edge,strel('diamond',1));
        % Asignar etiquetas a componentes conexos
        Label=bwlabel(~Edge);
        % Cantidad de etiquetas
        MaxLabel=max(Label(:));
        % Histograma de etiquetas
        Hist=zeros(MaxLabel,1);
        % Recorrido de todas las etiquetas
        for i=1:MaxLabel
            % Conteo de etiquetas y asignacion a histograma
            Hist(i)=nnz(Label==i);
        end
        % Ordenar histograma en modo decendente
        [~,IdxS]=sort(Hist,'descend');
        % Matriz de marcadores
        Marker=zeros(size(Label));
        % Recorrido de marcadores hasta obtener el numero de clusters
        % pedido
        for i=1:numberOfClusters
            % Asignar marcadores de componentes conexos de mayor tamaño
            Marker=or(Marker,Label==IdxS(i));
        end
        % Imposicion de marcadores como minimos en la imagen original
        ImMin=imimposemin(ImMat,Marker);
        % Watershed de imagen con minimos impuestos
        segmentation=watershed(ImMin);
    % Error en caso de pedir un metodo de cluster no existente
    otherwise
        error('Undefined clusteringMethod');
end
end