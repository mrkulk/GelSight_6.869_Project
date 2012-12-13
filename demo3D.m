
clear all;close all;

% addpath('calib');

%read image

%\media\dataset\tk_dataset\fabrics\cloth3
%\media\dataset\tk_dataset\foliage\l2
%\media\dataset\tk_dataset\stone\s14
%\media\dataset\tk_dataset\wood\w1

[img,scale]=read_pfm('\media\dataset\tk_dataset\foliage\l6\surface.pfm',0);

%high-pass filtering
% sg = 20;%this number can be changed to see different effects
% gf = fspecial('gaussian', (2*3*sg+1)*[1 1], sg);
% filtered = imfilter(img, gf);
% img = img - filtered;
%img(img(:) < 0 ) = 0;

figure;imshow(img,[]);title('full image');

figure;mesh(img);title('3D view of cropped image');


figure;
surf(img);%,double(imread('circle.png')/256));
colormap('gray');
axis('equal');
set(gca,'visible','off');
shading flat
light('Position',[0 0 10],'Style','infinite');
light('Position',[10 0  0],'Style','infinite');
light('Position',[0 10  0],'Style','infinite');
 