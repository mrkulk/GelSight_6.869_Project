%Tejas Kulkarni
%tejask@mit.edu

function im = MakePanorama( i1,i2, T )
    
    im = imtransform(i1, T);
	[x y] = tformfwd(T,0,0);
	x = abs(round(x));
	y = abs(round(y));

	im(y:y+size(i2,1)-1,x:x+size(i2,2)-1,:) = i2(:,:,:);
end

