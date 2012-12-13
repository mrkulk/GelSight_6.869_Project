function BW = filterDepthMap(img)
    global globalvar
% 
%     sg = 20;%this number can be changed to see different effects
%     gf = fspecial('gaussian', (2*3*sg+1)*[1 1], sg);
%     filtered = imfilter(img, gf);
%     img = img - filtered;
% 
%    %img(img(:)< 0) = 0;
% 
%    %img=abs(img);
    BW=im2bw(img, 0.02); %0.02 without all upper crap
end

