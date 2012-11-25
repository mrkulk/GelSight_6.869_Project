
clear all;close all;

% addpath('calib');

%read image
[img,scale]=read_pfm('surface.pfm',0);

% %high-pass filtering
% sg = 15;%this number can be changed to see different effects
% gf = fspecial('gaussian', (2*3*sg+1)*[1 1], sg);
% filtered = imfilter(img, gf);
% img = img - filtered;

figure;imshow(img,[]);title('full image');

figure;mesh(img);title('3D view of cropped image');