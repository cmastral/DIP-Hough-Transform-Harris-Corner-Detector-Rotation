clear all;
clf;
clc;
close all;

%Initializing BW binary image, Dtheta and Drho and n
I=imread('im2.jpg');
I=imresize(I,0.2); %downsampling
I1 = rgb2gray(I);
figure(1)
imshow(I);
hold on;
I1= imgaussfilt(I1,4);    %smoothing filter
BW=edge(I1,'sobel');      %edge detector
[N2,N1]=size(BW);

Drho=1;
Dtheta=1*pi/180;
n=10;  
rho_max=round(sqrt(N1^2+N2^2));   %max possible distance from origin
thetas=-90:Dtheta*180/pi:89;      %range of theta values in moires
t=(thetas.*pi)./180;              %angle in radians
rhos=-rho_max:Drho:rho_max;       %range of rho values

[H,L,res]=myHoughTransform(BW, Drho, Dtheta, n); %Calling my Hough Transform 

%Plotting the lines
x = 1:1:N1;
for k=1:size(L,1)
   if L(k,2)==0
      plot([L(k,1) L(k,1)], [1 N2],'color','red');
      hold on;
   else
        y(k,:) = (L(k,1) - x* cos(L(k,2)) )/ sin(L(k,2));
        plot(x(:),y(k,:),'color','red');
        hold on;
   end
end

%Plotting Hough 
figure(2)
imshow(imadjust(rescale(H)),'XData',t,'YData',rhos,...
      'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);
hold on;
for k=1:size(L,1)
    plot(L(k,2),L(k,1),'s','color','white');
    hold on;
end