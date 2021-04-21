function [H, L, res] = myHoughTransform(img_binary, Drho, Dtheta, n)

[N2,N1]=size(img_binary);          %size of the binary image
res=N1*N2;                         %intializing res
rho_max=round(sqrt(N1^2+N2^2));    %max possible distance from origin
thetas=-90:Dtheta*180/pi:89;       %range of theta (degrees)
t=(thetas.*pi)./180;               %angles in radians
rhos=-rho_max:Drho:rho_max;        %range of rho values

%initializing H, 0 votes 
H=zeros(length(rhos),length(thetas));

%Scanning the image for a white pixel(=possible point of a line)
for n1=1:N1
 for n2=1:N2
    if(img_binary(n2,n1)~=0)
        for theta=1:length(thetas)
            r=n1*cos(t(theta))+n2*sin(t(theta));  %Distance given the angle
            [d,rho]=min(abs(rhos-r));             %Find the value closest to this
            
            if d<=1  %if the value is closer than the step, it belongs between [r(i),r(i+1)]
                H(rho,theta)=H(rho,theta)+1;  %Filling the H with votes
            end
        end
    end
 end
end
RegMaxBW=imregionalmax(H);                 %Local Maxima
for i=1:length(rhos)
    for j=1:length(thetas)
        RegMax(i,j)=RegMaxBW(i,j)*H(i,j);  
    end
end

%Initializing variables
done = false;
htemp = RegMax;
peaks = [];
L=[];
count=0;

while ~done                       %Find the n peaks
  [maxValue]= max(htemp(:));
  count=count+maxValue;
  [row col] = find(htemp == maxValue); 
  row = row(1); 
  col = col(1);
  peaks = [peaks; [row col]];     %Add the peak to the list
  htemp(row,col)=0;
    if size(peaks,1) == n
      done = true;
    end
end
for k=1:size(peaks,1)
    L(k,:)=[rhos(peaks(k,1)) t(peaks(k,2))];    %L matrix with rho and thetas of the lines
end
res=res-count;                     
end
