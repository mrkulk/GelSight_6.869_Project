im=double(imread('test.png')); 

tic;
l_multi=lbp_multicore(im);
multicorelbp=toc;

tic;
l_mat=lbp_new(im,1,8,getmapping(8,'u2'),'x');  
matlablbp=toc;

