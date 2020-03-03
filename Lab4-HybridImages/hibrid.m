%Imagenes Hibridas
gfrente=imread('gfrente.jpg'); %cargo la imagen del gato
gokuf1=imread('gokuf1.jpeg'); %cargo la imagen del perro
ker=fspecial('gaussian',25,40); %creo el kernel gaussiano para usarlo como filtro pasabajas
l1=gokuf1; %renombro la imagen del perro
g1=gfrente; %renombro la imagen del gato
l1=l1(290:end-120,70:end-70,:); %recortamos el fondo de la imagen del perro para que quede con la misma alineacion que el gato
figure();
subplot(1,2,1);imshow(l1);
title('Imagen del perro tras corte');
subplot(1,2,2);imshow(g1);
title('Imagen original del gato');
lf1=imfilter(l1,ker); %filtro la imagen del perro con un pasabajas
lhf=mat2gray(l1-lf1); %resto la imagen del perro filtrada a la original para dejar solo frecuencias altas y reescalarlas entre 0 y 1
gf1=imfilter(g1,ker); %ahora filtro la imagen del gato con un pasabajas
lhf=imresize(lhf,[size(gf1,1) size(gf1,2)]); %reescalo la imagen del perro al tamaño de la del gato
gf1=mat2gray(gf1); %reescalo los valores de intensidad del gato a valores entre 0 y 1
if1=gf1+lhf; %sumo el perro y el gato después de filtrarlos
if1=mat2gray(if1); %reescalo el resultado a valores de 0 a 1
%reescalo la imagen a escalas mas pequenas para ver las bajas frecuencias, como si la viera lejos
ipq1=imresize(if1,0.5);
ipq2=imresize(if1,0.25);
ipq3=imresize(if1,0.125);
ipq4=imresize(if1,0.07); 
figure();
imshow(if1,[0 1]); %muestro la imagen resultante en el tamano grande
%completo las imagenes con unos para poderlas plotear juntas
u1=ones(size(if1,1),size(ipq1,2),3);
u1(1:size(ipq1,1),1:size(ipq1,2),:)=ipq1;
u2=ones(size(if1,1),size(ipq2,2),3);
u2(1:size(ipq2,1),1:size(ipq2,2),:)=ipq2;
u3=ones(size(if1,1),size(ipq3,2),3);
u3(1:size(ipq3,1),1:size(ipq3,2),:)=ipq3;
u4=ones(size(if1,1),size(ipq4,2),3);
u4(1:size(ipq4,1),1:size(ipq4,2),:)=ipq4;
pqfinal=[if1 u1 u2 u3 u4];
figure();
imshow(pqfinal,[0 1]); %mostrar imagen mas pequena

