%{
Funci�n para Lab04: Visi�n por computador
Integrantes: Jos� Campo y Mariana Franky
%}
function HybridImages
%% Imagen 1: Pasa-bajas
% Carga de la imagen 1
Im1=imread('bobo.jpg');
% Creaci�n de filtro peque�o, desviacion proporcionalmente grande
Filt1=fspecial('gaussian',10,3);
% Filtrado de altas frecuencias con umbral bajo
Im1F=imfilter(Im1,Filt1);
%% Imagen 2: Pasa-altas
% Carga de la imagen 2
Im2=imread('pensador.jpg');
% Acomodar tama�o de la imagen 2 al tama�o de la imagen 1
Im2=imresize(Im2,[size(Im1,1),size(Im1,2)]);
% Craci�n de filtro grande, desviaci�n proporcionalmente peque�a
Filt2=fspecial('gaussian',50,10);
% Filtrado de altas frecuencias con umbral alto
Im2F=imfilter(Im2,Filt2);
% Obtenci�n de imagen de alta frecuencia con umbral alto
Im2FS=imsubtract(Im2,Im2F);
%% Imagen h�brida
% Suma de imagen de baja y alta frecuencia
ImR=imadd(Im1F,Im2FS);
%% Piramide
% Niveles de piramide - 1
cantPiram=4;
% Celda con imagenes resultantes de piramide
ImRP=cell(cantPiram+1,1);
% Asignacion de imagen hibrida original a primera celda
ImRP{1}=ImR;
% Matriz de ceros con tama�os de imagenes de piramide
Sizes=zeros(cantPiram,length(size(ImR)));
% Asignacion de tama�o de imagen hibrida original
Sizes(1,:)=size(ImR);
% Recorrido para creacion de imagenes de piramide
for i=2:cantPiram+1
    % Reducci�n de piramide segun nivel de iteracion
    ImRP{i}=impyramid(ImRP{i-1},'reduce');
    % Asignaci�n de tama�o nuevo de imagen piramide
    Sizes(i,:)=size(ImRP{i});
end
% Creaci�n de imagen piramide de muestra final con todos sus niveles
ImRPFinal=padarray(ImR,[0,sum(Sizes(2:end,2))],0,'post');
% Recorrido de imagenes piramide para muestra final
for i=2:cantPiram+1
    % Asignaci�n de niveles de piramide de muestra final
    ImRPFinal(Sizes(1,1)-Sizes(i,1)+1:Sizes(1,1),...
        sum(Sizes(1:i-1,2))+1:sum(Sizes(1:i-1,2))+Sizes(i,2),:)...
        =ImRP{i};
end
%% Analisis de Fourier
% Carga de imagen de muestra
FIm=imread('pensador.jpg');
% Filtro para pasa-baja
Filt1=fspecial('gaussian',10,3);
% Filtro para pasa-alta
Filt2=fspecial('gaussian',50,10);
% Filtrado de imagen con cada filtro
FIm1=imfilter(FIm,Filt1);
FIm2=imfilter(FIm,Filt2);
% Transformaci�n de Fourier a imagen original, pasa-baja
FFTO=fft2(FIm);
FFT1=fft2(FIm1);
FFT2=fft2(FIm2);
% Valor absoluto y cambio de ejes de coordenadas de la transformaci�n
FFTOS=abs(fftshift(FFTO));
FFT1S=abs(fftshift(FFT1));
FFT2S=abs(fftshift(FFT2));
%% Ploteo
% Ploteo de im�genes originales
figure(1);
set(gcf,'Color','White');
imshow(cat(2,Im1,Im2));
title('Im�genes originales');
% Ploteo de im�genes filtradas e imagen hibrida
figure(2);
set(gcf,'Color','White');
imshow(cat(2,Im1F,Im2FS,ImR))
title('Im�genes filtradas e imagen h�brida');
% Ploteo de muestra final
figure(3);
set(gcf,'Color','White');
imshow(ImRPFinal);
title('Muestra pir�mide');
% Ploteo de imagen 1 (bobo) en transformada de Fourier
figure(4);
set(gcf,'Color','White');
subplot(1,3,1);
imagesc(FFTOS.*(255/max(FFTOS(:))));
title('Original')
subplot(1,3,2);
imagesc(FFT1S.*(255/max(FFT1S(:))));
title('Filtro. Media: 10. Desvest: 3');
subplot(1,3,3);
imagesc(FFT2S.*(255/max(FFT2S(:))));
title('Filtro. Media: 50. Desvest: 10');
end