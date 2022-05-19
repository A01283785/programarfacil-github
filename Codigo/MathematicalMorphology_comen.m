%% Mathematical Morphology
% Carlos Enrique López Jimenez A01283855
% Genaro Gallardo Bórquez A01382459
% Claudia Esmeralda González Castillo A01411506
% Jesus Eduardo Martinez Herrera A01283785
% Juan Diego García Manrique A00829257
%Mario Veccio Castro Berrones A00826824

% Se aumento en valor de 3 todos los tamanos de los discos

% Se lee la imagen
f=imread('radiograph1.jpg');
f=double(f(:,:,1));
f=f/max(max(f));
% Se escala el tamano de la imagen
f=imresize(f,0.25);
% Se muestra la primera figura
figure(1)
imshow(f,[]), title('Imagen base')

%% Dilatation

% Crea una superficie con forma de disco
se = strel('disk',8);

% Dilata la figura utilizando la estructura SE
BW2 = imdilate(f,se);
figure(2)
imshow(BW2), title('Dilated')
% Use different disk size
%% Erosion

se = strel('disk',8);
% Erosiona la figura utilizando la estructura SE
BW3 = imerode(f,se);
imshow(BW3), title('Eroded')
% Use different disk size
figure(3)
imshowpair(BW2,BW3,'montage')
title('Comparacion entre dilated y eroded')
%% Opening

se = strel('disk',10);
% Apertura morfologica, primero se dilata y despues se erosiona usando la
% misma estructura
BW2 = imopen(f,se);
figure(4)
imshow(BW2), title('Opening')
% Use different disk size
%% Closing

se = strel('disk',10);
% Primero se erosiona y despues se dilata usando la estructura SE
BW2 = imclose(f,se);
figure(5)
imshow(BW2), title('Closing')
% Use different disk size
%% Gradient

se = strel('disk',4);
BW1 = imdilate(f,se) - imerode(f,se);
figure(6)
imshow(BW1), title('Gradient')
% Use different disk size

%% Preprocess the Image The Rice Matlab Example
% Read an image into the workspace.

I = imread('rice.png');
figure(7)
imshow(I), title('Imagen Base')
%% 
% The background illumination is brighter in the center of the image than at 
% the bottom. Preprocess the image to make the background illumination more uniform.
% 
% As a first step, remove all of the foreground (rice grains) using morphological 
% opening. The opening operation removes small objects that cannot completely 
% contain the structuring element. Define a disk-shaped structuring element with 
% a radius of 15, which fits entirely inside a single grain of rice.

se = strel('disk',18);
%% 
% To perform the morphological opening, use |imopen| with the structuring element.

% Apertura morfologica, primero se dilata y despues se erosiona usando la
% misma estructura
background = imopen(I,se);
figure(8)
imshow(background), title('Fondo de la imagen')
%% 
% Subtract the background approximation image, |background|, from the original 
% image, |I|, and view the resulting image. After subtracting the adjusted background 
% image from the original image, the resulting image has a uniform background 
% but is now a bit dark for analysis.

I2 = I - background;
figure(9)
imshow(I2), title('Imagen con tono oscuro')
%% 
% Use |imadjust| to increase the contrast of the processed image |I2| by saturating 
% 1% of the data at both low and high intensities and by stretching the intensity 
% values to fill the |uint8| dynamic range.

I3 = imadjust(I2);
figure(10)
imshow(I3), title('Contraste incrementado')
%% 
% Note that the prior two steps could be replaced by a single step using |imtophat| 
% which first calculates the morphological opening and then subtracts it from 
% the original image.
% 
% |I2 = imtophat(I,strel('disk',15));|
%% 
% Create a binary version of the processed image so you can use toolbox functions 
% for analysis. Use the |imbinarize| function to convert the grayscale image into 
% a binary image. Remove background noise from the image with the |bwareaopen| 
% function.

bw = imbinarize(I3);
bw = bwareaopen(bw,50);
figure(11)
imshow(bw), title('Imagen binaria, solo blanco y negro')

% Use different size of the structural element

%% Skeletonize 2-D Grayscale Image
% Read a 2-D grayscale image into the workspace. Display the image. Objects 
% of interest are dark threads against a light background.

I = imread('threads.png');
figure(12)
imshow(I), title('Imagen base')
%% 
% Skeletonization requires a binary image in which foreground pixels are |1| 
% (white) and the background is |0| (black). To make the original image suitable 
% for skeletonization, take the complement of the image so that the objects are 
% light and the background is dark. Then, binarize the result.

Icomplement = imcomplement(I);
BW = imbinarize(Icomplement);
figure(13)
imshow(BW), title('Binarizacion')
%% 
% Perform skeletonization of the binary image using |bwskel|.

out = bwskel(BW);
%% 
% Display the skeleton over the original image by using the |labeloverlay| function. 
% The skeleton appears as a 1-pixel wide blue line over the dark threads.

figure(14)
imshow(labeloverlay(I,out,'Transparency',0)), title('Esqueletizacion')
%% 
% Prune small spurs that appear on the skeleton and view the result. One short 
% branch is pruned from a thread near the center of the image.

out2 = bwskel(BW,'MinBranchLength',15);
figure(15)
imshow(labeloverlay(I,out2,'Transparency',0)), title('Esqueletizacion con branch')
%Play with the size of Min Branch Lenght

%% The alternative method with bwmorph

BW3 = bwmorph(BW,'skel',Inf);
figure(16)
imshow(BW3), title('Esqueletizacion con bwmorph')
%% Lets play with the x-ray

se = strel('disk',10);
BW3 = f-imopen(f,se);
figure(17)
imshow(BW3,[]), title('Imagen con opening')
bw = imbinarize(BW3);
figure(18)
imshow(bw,[]), title('Imagen binarizada')
bw = imopen(bw,strel('disk',4));
bw = imclose(bw,strel('disk',7));
figure(19)
imshow(bw,[]), title('Post opening y closing')
bw = bwareaopen(bw,50);
figure(20)
imshow(bw,[]), title('Binarizacion con bwareaopen')
BW3 = bwmorph(bw,'skel',Inf);
figure(21)
imshow(BW3), title('Imagen esqueletizada con bwmorph')
figure(22)
imshow(labeloverlay(f,BW3,'Transparency',0)), title('Transparencia de la esqueletizacion')

% Do the same with your own image