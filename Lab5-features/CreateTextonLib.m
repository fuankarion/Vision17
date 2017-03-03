% Agregar carpeta con archivos al workspace actual
addpath('lib')
addpath('train')
% Generar banco de filtros
fb=fbCreate;
% Cantidad de textones a tomar max.25
numTextoni=1;
numTexton=25;
% Cantidad de imagenes de entrenamiento por texton max.30
cantTrain=2;
% Numero de clusters
k=2^5;
% Matriz con imagenes concatenadas horizontalmente
ImHorz=[];
disp('Creando diccionario de textones\n');
% Recorrido de textones
tic;
for i=numTextoni:numTexton
    % Generar valores aleatorios para imagenes
    r=randsample(1:30,cantTrain);
    % Recorrido de imagenes
    for j=1:cantTrain
        % Nombre de la imagen generada aleatoriamente
        strIm=sprintf('T%02i_%02i.jpg',i,r(j));
        % Cargar la imagen
        Im=double(imread(strIm))./255;
        % Concatenar horizontalmente
        ImHorz=horzcat(ImHorz,Im);
    end
end
% Obtener respuestas de filtros
filterResponses=fbRun(fb,ImHorz);
% Mapa de textones de toda la imagen
[map,textons]=computeTextons(filterResponses,k);
% Guardar textones
save('textones.mat','textons');
disp('DONE\n');
toc
