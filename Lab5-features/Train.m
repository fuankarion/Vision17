disp('Entrenando');
% Agregar carpeta con archivos al workspace actual
addpath('lib')
addpath('train')
% Carcar textones
load('textones.mat');
% Cargar anotaciones
fil=fopen('names.txt','r');
% Generar banco de filtros
fb=fbCreate;
% Cantidad de textones a tomar max.25
numTextoni=1;
numTexton=25;
% Cantidad de imagenes de entrenamiento por texton max.30
cantTrain=4;
% Numero de clusters
k=size(textons,1);
% Matriz de entrenamiento
TrainMat=zeros(cantTrain*numTexton,k);
% Celda con anotaciones
Anot=cell(cantTrain*numTexton,1);
% Posición de asignación
pos=1;
% Recorrido de textones
for i=numTextoni:numTexton
    % Obtener anotación
    line=fgetl(fil);
    % Generar valores aleatorios para imagenes
    r=randsample(1:30,cantTrain);
    % Recorrido de imagenes
    for j=1:cantTrain
        % Nombre de la imagen generada aleatoriamente
        strIm=sprintf('T%02i_%02i.jpg',i,r(j));
        % Cargar la imagen
        Im=double(imread(strIm))./255;
        % Representacion de textones
        tmap=assignTextons(fbRun(fb,Im),textons');
        % Obtener vector de histograma
        histo=histc(tmap(:),1:k);
        % Asignar a matriz de entrenamiento
        TrainMat(pos,:)=histo;
        % Asignar anotacion
        Anot{pos}=line(5:end);
        % Iterar posicion de asignacion
        pos=pos+1;
    end
end
% Cerrar archivo
fclose(fil);
% Entrenar KNN
KNNModel=fitcknn(TrainMat,Anot);
% Cantidad de arboles para entrenar
CantTree=7;
% Entrenar Arboles
TREEModel=TreeBagger(CantTree,TrainMat,Anot,'Method','Classification');
% Guardar Modelos
save('Models.mat','KNNModel','TREEModel');
disp('DONE');
