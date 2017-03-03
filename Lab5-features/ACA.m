close all, clear all, clc
load('MatConf.mat');
% Normalización de matriz de confusión
norm1=sum(CKNNModel,1);
norm2=sum(CTREEModel,1);
CKNNModelN=CKNNModel./repmat(norm1,size(CKNNModel,1),1);
CTREEModelN=CTREEModel./repmat(norm1,size(CTREEModel,1),1);
% ACA
ACA1=sum(diag(CKNNModelN))./numel(diag(CKNNModel));
fprintf('ACA Modelo K-Nearest Neighbour = %f%%\n',ACA1*100);
ACA2=sum(diag(CTREEModelN))./numel(diag(CTREEModel));
fprintf('ACA Modelo Random Forest = %f%%\n',ACA2*100);
% Ploteo
figure(1);
imagesc(CKNNModelN);
title('Modelo K-Nearest Neighbour');
figure(2);
imagesc(CTREEModelN);
title('Modelo Random Forest');
