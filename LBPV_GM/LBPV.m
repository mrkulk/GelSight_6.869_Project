% LBPV returns LBPV histogram of an image.
%  J = LBPV(I,R,N,MAPPING) returns the local binary pattern variance
%  histogram of an intensity image I. The LBP codes are computed using P sampling 
%  points on a circle of radius R and using mapping table defined by MAPPING. 
%  The VAR values are computed for the P sampling points. Instead of
%  computing the joint histogram of LBP and VAR globally, the LBPV computes the 
%  VAR from a local region and accumulates it into the LBP bin. This can be regarded 
%  as the integral projection along the VAR coordinate. 

%  Examples
%  --------
%       I=imread('rice.png');
%       mapping=getmapping(8,'u2'); 
%       H1=LBPV(I,1,8,mapping); %LBPV histogram in (8,1) neighborhood using uniform patterns


function result = LBPV(I,R,P,MAPPING)
% Version 1.0
% Authors: Zhenhua Guo, Lei Zhang and David Zhang
% Copyright @ Biometrics Research Centre, the Hong Kong Polytechnic University

if nargin<1
    disp('No input image')
    return
end
if nargin<2
    R = 1;
end
if nargin<3
    P = 8;
end   
if nargin<4
    MAPPING = getmapping(P,'riu2'); 
end

% Get LBP value for each pixel of the input image
LBPMap = lbp_new(I,R,P,MAPPING,'x');  

% Get VAR value for each pixel of the input image
spoints=zeros(P,2);

% Angle step.
a = 2*pi/P;

for i = 1:P
    spoints(i,1) = -R*sin((i-1)*a);
    spoints(i,2) = R*cos((i-1)*a);
end

[ysize xsize] = size(I);

miny=min(spoints(:,1));
maxy=max(spoints(:,1));
minx=min(spoints(:,2));
maxx=max(spoints(:,2));

% Block size, each VAR value is computed within a block of size bsizey*bsizex
bsizey=ceil(max(maxy,0))-floor(min(miny,0))+1;
bsizex=ceil(max(maxx,0))-floor(min(minx,0))+1;

% Coordinates of origin (0,0) in the block
origy=1-floor(min(miny,0));
origx=1-floor(min(minx,0));

% Minimum allowed size for the input image depends
% on the radius of the used VAR operator.
if(xsize < bsizex || ysize < bsizey)
  error('Too small input image. Should be at least (2*radius+1) x (2*radius+1)');
end

% Calculate dx and dy;
dx = xsize - bsizex;
dy = ysize - bsizey;

% convert the input image to "double" type.
d_image = double(I);

% Reorganize the image to compute VAR value
for i = 1:P
  y = spoints(i,1)+origy;
  x = spoints(i,2)+origx;
  % Calculate floors, ceils and rounds for the x and y.
  fy = floor(y); cy = ceil(y); ry = round(y);
  fx = floor(x); cx = ceil(x); rx = round(x);
  % Check if interpolation is needed.
  if (abs(x - rx) < 1e-6) && (abs(y - ry) < 1e-6)
    % Interpolation is not needed, use original datatypes
    T = d_image(ry:ry+dy,rx:rx+dx);
    
    % convert the matrix to a column vector
    NArray(:,i) = reshape(T,prod(size(T)),1); 
  else
    % Interpolation needed, use double type images 
    ty = y - fy;
    tx = x - fx;

    % Calculate the interpolation weights.
    w1 = (1 - tx) * (1 - ty);
    w2 =      tx  * (1 - ty);
    w3 = (1 - tx) *      ty ;
    w4 =      tx  *      ty ;
    % Compute interpolated pixel values
    T = w1*d_image(fy:fy+dy,fx:fx+dx) + w2*d_image(fy:fy+dy,cx:cx+dx) + ...
        w3*d_image(cy:cy+dy,fx:fx+dx) + w4*d_image(cy:cy+dy,cx:cx+dx);
    
    % convert the matrix to a column vector
    NArray(:,i) = reshape(T,prod(size(T)),1);
  end  
end

% after get all neighborhood for each pixel, compute variance for the image
VAR = var(NArray,1,2);
VAR = reshape(VAR,size(T));

MapNum = max(MAPPING(:));

% Initialize the result matrix with zeros.
result=zeros(1,MapNum+1);
for k=0:MapNum;
    index = find(LBPMap==k);
    result(k+1) = sum(VAR(index));
end