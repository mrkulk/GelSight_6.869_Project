%  distGMES computes the dissimilarity between training samples and test
%  samples by Exhaustive Searching Scheme of Global Matching
%  DM = distGMES(trains, tests) returns the distance matrix between training samples and test samples. 
%  The input "train" is a n*d matrix, and each row of it represents one
%  training sample. The "test" is a m*d matrix.   

%  Examples
%  --------
%       I1=imread('rice1.png');
%       I2=imread('rice2.png');
%       I3=imread('rice3.png');
%       I4=imread('rice4.png');
%       mapping=getmapping(8,'u2'); 
%       M(1,:)=LBPV(I1,1,8,mapping); % LBPV histogram in (8,1) neighborhood using uniform patterns
%       M(2,:)=LBPV(I2,1,8,mapping); 
%       S(1,:)=LBPV(I3,1,8,mapping); 
%       S(2,:)=LBPV(I4,1,8,mapping); 
%       M = ConvertU2LBP(M,8); % convert u2 LBP or LBPV to meet the requirement of global matching scheme
%       S = ConvertU2LBP(S,8);
%       DM = distGMES(M,S,8);

function DM = distGMES(trains, tests,P)
% Version 1.0
% Authors: Zhenhua Guo, Lei Zhang and David Zhang
% Copyright @ Biometrics Research Centre, the Hong Kong Polytechnic University

if nargin<3
    disp('Not enough input parameter')
    return
end

% Get a group of permutation index for reorganizing the histogram to
% simulate the rotation effect
for i=1:P 
    OrderIndex{i} = [(i-1)*(P-1)+1:P*(P-1)];
    OrderIndex{i} = [OrderIndex{i},1:(i-1)*(P-1),P*(P-1)+1:P*(P-1)+3];
end

trainNum = size(trains,1);
testNum = size(tests,1);
DistMat = zeros(P,trainNum);
DM = zeros(testNum,trainNum);
for i=1:testNum;
    test = tests(i,:);    
    for k=1:P
        DistMat(k,:) = distMATChiSquare(trains,test(OrderIndex{k}))';
    end
    DM(i,:) = min(DistMat);
end