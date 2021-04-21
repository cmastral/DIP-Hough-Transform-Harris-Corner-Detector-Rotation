function corners = myDetectHarrisFeatures(I)

sigma=6;
threshold=0.003;
ord=4;
order=2*ord+1;
k=0.05;
%the deravative in x and y direction
[dx,dy]=meshgrid(-1:1,-1:1);

Ix=conv2(double(I),dx,'same');
Iy=conv2(double(I),dy,'same');

%Smoothening using Gaussian filters
g=fspecial('gaussian',10,sigma);

%Entries of the M matrix
Ix2=conv2(Ix.*Ix,g,'same');
Iy2=conv2(Iy.*Iy,g,'same');
Ixy=conv2(Ix.*Iy,g,'same');

%M=[Ix2 Ixy;Ixy Iy2]; 

% Computing Harris Measure
R=(Ix2.*Iy2-Ixy.^2)-k*(Ix2+Iy2).^2; %det(M)-k*Trace(M)

%Finding the local Maxima
LocalMax=ordfilt2(R,order.^2,ones(order));

%Thresholding
corners=(R==LocalMax)&(R>threshold);
end

