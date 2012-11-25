%Tejas Kulkarni
%tejask@mit.edu

function im = Photomerge( i1,i2 )
        
    im1=rgb2gray(i1);
    im2=rgb2gray(i2);
    
    %im1=i1;
    %im2=i2;
    
    im1=im1-min(im1(:)) ;
    im1=im1/max(im1(:)) ;
    im2=im2-min(im2(:)) ;
    im2=im2/max(im2(:)) ;

    [frames1,descr1,gss1,dogss1] = sift( im1, 'Verbosity', 1 ) ;
    [frames2,descr2,gss2,dogss2] = sift( im2, 'Verbosity', 1 ) ;

    descr1=uint8(512*descr1) ;
    descr2=uint8(512*descr2) ;
    matches=siftmatch( descr1, descr2 ) ;
    
	x1 = [frames1(1,matches(1,:))' frames1(2,matches(1,:))'];
	x2 = [frames2(1,matches(2,:))' frames2(2,matches(2,:))'];
    T=TransformRANSAC( x1,x2 );
    
    im=MakePanorama(i1,i2,T);
    
end

