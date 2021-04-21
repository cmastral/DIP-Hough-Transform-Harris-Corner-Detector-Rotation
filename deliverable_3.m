clc;
clf;
close all;
clear all;
img=imread('im2.jpg'); 
img=imresize(img,0.5);
%img=rgb2gray(img);   %for the grayscale image
img=double(img);

% 1. Rotation angle=54*pi/180
angle1=54*pi/180;
C1=myImgRotation(img,angle1);
figure(1)
imshow(C1);

% 2. Rotation angle=213*pi/180
angle2=213*pi/180;
C2=myImgRotation(img,angle2);
figure(2)
imshow(C2);