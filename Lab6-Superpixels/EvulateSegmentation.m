%{
M�todo para obtener indice de Jaccard
Input:
    Segmentation: Imagen con etiquetas de segmentacion de metodo
    GroundTruth: Imagen con etiquetas de anotaciones
    SegVec: Vector con etiquetas de objeto a unir para Segmentation
    GTVec: Vector con etiquetas de objeto a unir para GroundTruth
%}
function Jacc=EvulateSegmentation(Segmentation,GroundTruth,SegVec,GTVec)
% Matrices binarias cuyos valores positivos seran las etiquetas de los
% vectores
BWSeg=zeros(size(Segmentation));
BWGT=BWSeg;
% Conjunci�n de cada etiqueta en la imagen
for i=SegVec
    BWSeg=or(BWSeg,Segmentation==i);
end
for i=GTVec
    BWGT=or(BWGT,GroundTruth==i);
end
% Magnitud de interseccion entre matrices binarias
Intersec=nnz(and(BWSeg,BWGT));
% Indice de Jaccard: Intersec(A,B)/Union(A,B)
Jacc=Intersec/(nnz(BWSeg)+nnz(BWGT)-Intersec);
end