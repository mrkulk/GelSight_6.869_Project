%  ConvertU2LBP converts the uniform LBP(LBPV) histogram sequence to meet the requirement for Global Matching.
%  LBPOut = ConvertU2LBP(LBPIn,P) returns the new histogram. The sequence of new
%  histogram meets the requirement for Global Matching scheme. The
%  input LBPIn is gotten by lbp_new or LBPV using uniform mappings by
%  GETMAPPING.

%  Examples
%  --------
%       I=imread('rice.png');
%       mapping=getmapping(8,'u2'); 
%       H1=LBPV(I,1,8,mapping); %LBPV histogram in (8,1) neighborhood using uniform patterns
%       H2 = ConvertU2LBP(H1,8);

function LBPOut = ConvertU2LBP(LBPIn,P)
% Version 1.0
% Authors: Zhenhua Guo, Lei Zhang and David Zhang
% Copyright @ Biometrics Research Centre, the Hong Kong Polytechnic University

if nargin<2
    disp('Not enough input parameter')
    return
end
LBPOut = zeros(size(LBPIn));
LBPOut(:,P*(P-1)+1) = LBPIn(:,1);
LBPOut(:,P*(P-1)+2:P*(P-1)+3) = LBPIn(:,P*(P-1)+2:P*(P-1)+3);
patternNew = Getmapping(P,'u2');
patternOld = ones(P*(P-1),1);
for i=0:P-1
    for j=1:P-1
        Temp = 2^i;
        for k=1:j-1
            Temp = Temp+2^(mod(i+k,P));
        end
        patternOld(i*(P-1)+j) = Temp+1;
    end
end
LBPOut(:,1:P*(P-1)) = LBPIn(:,patternNew(patternOld)+1);