clear all;
clf;
clc;
close all;

I=imread('im2.jpg'); 
I=imresize(I,0.2);         %resizing
I1 = rgb2gray(I);          %grayscale image
I1=double(I1)/255;         %kanonikopoihsh
figure(1)
imshow(I1)
hold on;

%calling myDetectHarrisFeatures to extract the corner points
corner_points=myDetectHarrisFeatures(I1);
[rows,cols]=find(corner_points);   
plot(cols,rows,'.','color','r'); %plotting the corner points on im2
hold on;

%5x5 squares around the corners
width = 5; 
height = 5; 
for i=1:size(cols)
x1=rows(i)-5/2;
x2=rows(i)+5/2;
y1=cols(i)-5/2;
y2=cols(i)+5/2;
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(y, x, 'r-', 'LineWidth', 1);
hold on;
end