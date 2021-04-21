function rotImg = myImgRotation(img, angle)

[ri,ci,z]= size(img); %size of the image (rows,columns and channels)

%Array dimesions so that rotated image fits exactly.

rows=ceil(ri*abs(cos(angle))+ci*abs(sin(angle)));     %rows                 
cols=ceil(ri*abs(sin(angle))+ci*abs(cos(angle)));     %columns                

%Initializing the rotImg array with zeros(=black background)
rotImg=uint8(zeros([rows cols z ]));

%Center of original image
xo=ceil(ri/2);                                                            
yo=ceil(ci/2);

%Center of final image
midx=ceil((size(rotImg,1))/2);
midy=ceil((size(rotImg,2))/2);

%Calculating corresponding coordinates of pixels of the original image
%for each pixel of rotImg
for i=1:size(rotImg,1)
    for j=1:size(rotImg,2)                                                       

         x=(i-midx)*cos(angle)+(j-midy)*sin(angle);                                       
         y=-(i-midx)*sin(angle)+(j-midy)*cos(angle);                             
         x=round(x)+xo;
         y=round(y)+yo;
%Intensity is assigned after checking if it lies in the bound of the original image
         if (x>1 && y>1 && x<size(img,1) && y<size(img,2)) 
              rotImg(i,j,:)=(img(x-1,y,:)+img(x+1,y,:)+img(x,y-1,:)+img(x,y+1,:))/4; %bilinear interpolation
         end

    end
end

end

