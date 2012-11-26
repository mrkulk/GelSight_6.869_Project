
%% example: im=double(imread('test.png'));  l=lbp_multicore(im);

function [L] = lbp_multicore( I, varargin )
    L = LBP_MEX( I, varargin{:} );
