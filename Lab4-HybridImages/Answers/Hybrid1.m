%%
clear all, close all, clc
%% Load images
close all
f1 = imread('IMG_8667.jpg');
f2 = imread('IMG_8647.jpg');

%% Create Hybrid images frecA = Chanel, frecB = Baylis
close all
%I choose the region of interest of the image 2
f2_2 = f2(689:2104,2463:3848,:);
%I rotate the image because it ins't in the position
f2_2p = imrotate(f2_2,90);
f2_2 = f2_2p;
% I crop the region of interest of the image 1
f1_2 = f1((634:1696),(1389:2470)-20,:);
n=size(f1_2); 
% Resize the image 2 so it can fit
f2_2 = imresize(f2_2, [n(1) n(2)]);
f2_2p=f1_2; f1_2=f2_2;f2_2 = f2_2p;
% Choose a sigma for the filtering
sigma = 8;
%I filter the images and make the low and high frecuencie images
frecB = 1*imgaussfilt(f2_2,sigma); 
frecA = uint8(3*(double(f1_2)-double(imgaussfilt(f1_2,sigma))));
%I generate the hybrid image
hybridIm = frecB+frecA;

%% Making the piramid 

a1 = impyramid(hybridIm,'reduce');
for i = 2:5
    s=['a' num2str(i) '=impyramid(a' num2str(i-1) ',''reduce'');'];
    eval(s)
end

figure, imshow(hybridIm)
figure, imshow(a4)

%% Making the chain image
plantilla = hybridIm;
for i = 1:5
    s = ['m=size(a' num2str(i) ');'];
    eval(s);
    plantilla = [plantilla, 255*ones([n(1) m(2) n(3)])];
    s = ['plantilla(1:m(1),(end-m(2)+1):end,:)=a' num2str(i) ';'];
    eval(s)
end


%% Save pyramid
imwrite(hybridIm,'piramide/hybrid.png');
imwrite(plantilla,'piramide/pyramid.png');
for i=1:5
    s = ['imwrite(a' num2str(i) ',''piramide/pyramid' num2str(i) '.png'');'];
    eval(s);
end