%read_pfm
%
%	
%
% -Usage-
%	[ img, scale ] = read_pfm(fname, flip)
%
% -Inputs-
%	fname
%	flip
%
% -Outputs-
%	img
%	scale
%
% Last Modified: 10/12/2009
function [ img, scale ] = read_pfm(fname, flip)

if nargin < 2
    flip = false; 

end

fid = fopen(fname, 'rb');
if fid < 0
    error(sprintf('couldn''t open `%s'' for reading', fname));
end

str = fgetl(fid);
if strcmp(str, 'PF')
    num_channels = 3;
elseif strcmp(str, 'Pf')
    num_channels = 1;
else
    num_channels = 0;
end

if num_channels > 0
    [ extent, count ] = fscanf(fid, '%d ', 2);
    if count == 2
        %  PROBLEM: the following fscanf consumes the first data byte if it's
        %  a carriage return. Hence I read binary data up to the first new
        %  line and use sscanf to parse it:
        %[ scale, count ] = fscanf(fid, '%f\n', 1);
        str = '';
        while true
            [ c, count ] = fread(fid, 1, 'char');
            if count == 0; error('unexpected end of file'); end
            if c == 10; break; end
            str = [ str, c ];
        end
        [ scale, count ] = sscanf(str, '%f', 1);
        if count == 1
            if scale < 0
                format = 'ieee-le';
                scale = -scale;
            else
                format = 'ieee-be';
            end
            
            n = prod(extent)*num_channels;
            [ img, count ] = fread(fid, n, 'float', 0, format);
            
            if count == n
                if num_channels == 1
                    img = reshape(img,extent')';
                    if flip
                        img = flipud(img);
                    end
                else
                    img = permute(reshape(img, [ 3 extent' ]), [3 2 1]);
                    if flip
                        img(:,:,1) = flipud(img(:,:,1));
                        img(:,:,2) = flipud(img(:,:,2));
                        img(:,:,3) = flipud(img(:,:,3));
                    end
                end
                fclose(fid);
                return;
            end
        end
    end
end

fclose(fid);
error(sprintf('file `%s'' is no PFM file', fname));
scale = 0;
img = [];

% $Id: read_pfm.m,v 1.1 2008/12/29 19:03:14 fcole Exp $
%
% copyright (c) 2003--2004, Tim Weyrich
% Computer Graphics Lab, ETH Zurich
%
% $Log: read_pfm.m,v $
% Revision 1.1  2008/12/29 19:03:14  fcole
% First check in of grid maker.
%
% Revision 1.1.1.1  2004/08/09 13:01:00  weyrich
% initial check-in of all .m files
%
%

