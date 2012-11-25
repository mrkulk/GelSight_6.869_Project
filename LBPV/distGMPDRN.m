%  distGMPDRN computes the dissimilarity between training samples and test
%  samples by Principal Directions of Global Matching, only RN rows 
%  DM = distGMPDRN(trains, tests, P, PDNum, RN) returns the distance matrix between training samples and test samples. 
%  The input "train" is a n*d matrix, and each row of it represents one
%  training sample. The "test" is a m*d matrix. PDNum is 1 or 2.   

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
%       DM = distGMPDRN(M,S,8,2,3);

function DM = distGMPDRN(trains, tests, P, PDNum, RN)
% Version 1.0
% Authors: Zhenhua Guo, Lei Zhang and David Zhang
% Copyright @ Biometrics Research Centre, the Hong Kong Polytechnic University

if nargin<4
    disp('Not enough input parameter')
    return
end

if nargin<4
    PDNum = 1;
end

if nargin<5
    RN = P/2-1;
end

trainNum = size(trains,1);
testNum = size(tests,1);

% using training samples to find the less important patterns
for j=1:P-1 % by sum of one pattern
    TempLBP(j) = sum(sum(trains(:,j:(P-1):P*(P-1))));
end
[SortLBP,SortIdx] = sort(TempLBP,'ascend');

for j=1:RN
    trainsNew(:,j:RN:P*RN) = trains(:,SortIdx(j):(P-1):P*(P-1));
    testsNew(:,j:RN:P*RN) = tests(:,SortIdx(j):(P-1):P*(P-1));
end
for j=1:(P-1)-RN
    trainsNew(:,RN*P+j) = sum(trains(:,SortIdx(j+RN):(P-1):P*(P-1)),2);
    testsNew(:,RN*P+j) = sum(tests(:,SortIdx(j+RN):(P-1):P*(P-1)),2);
end
TempNum = RN*P+(P-1)-RN;
trainsNew(:,TempNum+1:TempNum+3) = trains(:,end-2:end);
testsNew(:,TempNum+1:TempNum+3) = tests(:,end-2:end);

% cluster some less important rotation variant patterns to rotation
% invariant patterns
trains = trainsNew;
tests = testsNew;

clear trainsNew
clear testsNew

% Get a group of permutation index for reorganizing the histogram to
% simulate the rotation effect
for i=1:P
    OrderIndex{i} = [(i-1)*RN+1:P*RN];
    OrderIndex{i} = [OrderIndex{i},1:(i-1)*RN,P*RN+1:P*RN+3+(P-1)-RN];
end
switch PDNum
    case 1 % retain one principal direction only
        % get one principal orientation for each training sample
        for i=1:size(trains,1)
            for j=1:P
                TempLBP(j) = sum(trains(i,(j-1)*RN+1:j*RN));
            end
            [SortLBP,MaxIdx] = max(TempLBP);
            trainsNew(i,1,:) = trains(i,OrderIndex{MaxIdx});            
        end
        % get one principal orientation for each test sample
        for i=1:size(tests,1)
            for j=1:P
                TempLBP(j) = sum(tests(i,(j-1)*RN+1:j*RN));
            end
            [SortLBP,MaxIdx] = max(TempLBP);
            testsNew(i,1,:) = tests(i,OrderIndex{MaxIdx});
        end
    case 2 % retain two principal directions
        % get two principal orientations for each training sample
        for i=1:size(trains,1)
            for j=1:P
                TempLBP(j) = sum(trains(i,(j-1)*RN+1:j*RN));
            end
            [SortLBP,SortIdx] = sort(TempLBP,'descend');
            trainsNew(i,1,:) = trains(i,OrderIndex{SortIdx(1)}); % first principal direction
            if ((SortIdx(1)+P/2)==SortIdx(2)) || ((SortIdx(1)-P/2)==SortIdx(2)) 
                % because of the symmetry, the difference between the first and second principal orientation should not be 180
                trainsNew(i,2,:) = trains(i,OrderIndex{SortIdx(3)});
            else
                trainsNew(i,2,:) = trains(i,OrderIndex{SortIdx(2)});
            end
        end
        % get two principal orientations for each test sample
        for i=1:size(tests,1)
            for j=1:P
                TempLBP(j) = sum(tests(i,(j-1)*RN+1:j*RN));
            end
            [SortLBP,SortIdx] = sort(TempLBP,'descend');
            testsNew(i,1,:) = tests(i,OrderIndex{SortIdx(1)}); % first principal direction
            if ((SortIdx(1)+P/2)==SortIdx(2)) || ((SortIdx(1)-P/2)==SortIdx(2)) 
                % because of the symmetry, the difference between the first and second principal orientation should not be 180
                testsNew(i,2,:) = tests(i,OrderIndex{SortIdx(3)});
            else
                testsNew(i,2,:) = tests(i,OrderIndex{SortIdx(2)});
            end
        end
    otherwise
        disp('Could not support the input parameter.')
        return        
end

DistMat = zeros(PDNum*PDNum,trainNum);
DM = zeros(testNum,trainNum);
for i=1:testNum;
    if PDNum>1
        test = squeeze(testsNew(i,:,:));
    else
        test = squeeze(testsNew(i,:,:))';
    end
    for m=1:PDNum
        for n=1:PDNum
            DistMat((m-1)*PDNum+n,:) = distMATChiSquare(squeeze(trainsNew(:,m,:)),test(n,:))';
        end
    end
    if PDNum>1
        DM(i,:) = min(DistMat);
    else
        DM(i,:) = DistMat;
    end
end