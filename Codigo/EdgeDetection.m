% Carlos Enrique López Jimenez A01283855
% Genaro Gallardo Bórquez A01382459
% Claudia Esmeralda González Castillo A01411506
% Jesus Eduardo Martinez Herrera A01283785
% Juan Diego García Manrique A00829257
%Mario Veccio Castro
%cargar imagen
f=imread('radiograph1.jpg');
f=imresize(f,0.25);
f=double(f(:,:,1));
imshow(f,[])
edgex=[1,-1];
g1=conv2(f,edgex,'same');
imshow(g1,[-10,10]);
1
title('derivada en x')
edgey=[-1 -2 -1;0,0,0;1,2,1]/8;
g2=conv2(f,edgey,'same');
imshow(g2,[-10,10])
2
figure(2)
subplot(1,2,1)
imshow(g1,[-10,10])
title('dx')
subplot(1,2,2)
imshow(g2,[-10,10])
title('dy')
3
figure(3)
subplot(1,1,1);
4
edgex=[1,0,-1;2,0,-2;1,0,-1]/8;
gx=conv2(f,edgex,'same');
gy=conv2(f,edgey,'same');
mag=abs(gx)+abs(gy);
imshow(mag,[]);
title('gradient magnitude ')
5
%estimar nivel de ruido
noisemask = [-1, 0 1];
noiseimage = conv2(f,noisemask,'same');
noisevariance = mean2(noiseimage.^2);
noisestd = sqrt(noisevariance/2);
edgedetection1 = mag > noisestd;
edgedetection2 = mag > 2*noisestd;
subplot(1,2,1)
imshow(edgedetection1,[]);
title ('edge detection at sigma')
subplot(1,2,2)
imshow(edgedetection2,[]);
title('edge detection at 2 sigma')
6
figure(4)
subplot(1,1,1)
angle=atan2(gy,gx);
imshow(angle,[]);
title('gradient orientation')
colormap('autumn')
7
edgcany=edge(f,'Canny');
imshow(edgcany,[]);
title('canny edge')
8
9