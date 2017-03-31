disp('Validando');
% Agregar carpeta con archivos al workspace actual
addpath('lib')
addpath('test')
% Carcar textones
load('textones.mat');
load('Models.mat');
% Cargar anotaciones
fil=fopen('names.txt','r');
% Generar banco de filtros
fb=fbCreate;
% Cantidad de textones a tomar max.25
numTextoni=1;
numTexton=25;
% Cantidad de imagenes de entrenamiento por texton max.30
cantTest=10;
% Numero de clusters
k=size(textons,1);
% Matriz de entrenamiento
TestMat=zeros(cantTest*numTexton,k);
% Celda con anotaciones
Anot=cell(cantTest*numTexton,1);
% Posición de asignación
pos=1;
% Recorrido de textones
for i=numTextoni:numTexton
    % Obtener anotación
    line=fgetl(fil);
    % Generar valores aleatorios para imagenes
    r=randsample(31:40,cantTest);
    % Recorrido de imagenes
    for j=1:cantTest
        % Nombre de la imagen generada aleatoriamente
        strIm=sprintf('T%02i_%02i.jpg',i,r(j));
        % Cargar la imagen
        Im=double(imread(strIm))./255;
        % Representacion de textones
        tmap=assignTextons(fbRun(fb,Im),textons');
        % Obtener vector de histograma
        histo=histc(tmap(:),1:k);
        % Asignar a matriz de entrenamiento
        TestMat(pos,:)=histo;
        % Asignar anotacion
        Anot{pos}=line(5:end);
        % Iterar posicion de asignacion
        pos=pos+1;
    end
end
fclose(fil);
%% Validacion
validacion=KNNModel.predict(TestMat);
% Entrenar Arboles
validacion2=TREEModel.predict(TestMat);
%% Matrices de confusion
CKNNModel = confusionmat(Anot,validacion);
CTREEModel = confusionmat(Anot,validacion2);
save('MatConf.mat','CKNNModel','CTREEModel');
