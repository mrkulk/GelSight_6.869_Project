%Main file

RECOMPUTE = 0;

tic;

if RECOMPUTE == 1
        formatMaterialDataset;
else
        load('media\materialgelsight_dataset');
end

results = [];
fpresults = [];

[accuracy, fp] = train(DATA,LABEL,1,10,randdata, labeldict('fabrics'),RECOMPUTE );
load(['media\','data_cat_',num2str(labeldict('fabrics'))]);
M=ConvertU2LBP(trainingdata,8);
testlbl = [1:1:length(testingdata)];
for i=length(testingdata)+1:length(testingdata)+1+21
    testingdata(i,:) = randdata(i-length(testingdata),:);
    testlbl(i-10) = -1;
end
S=ConvertU2LBP(testingdata,8);
DM = distGMPDRN(M,S,8,2,3);
CP=ClassifyOnNN(DM,lbl,testlbl);
disp(['Fabrics: SVM classification rate is ', num2str(accuracy*100), '%', '  |  NN ', num2str(CP) ]);
results(1)=accuracy;
fpresults(1) = fp;

[accuracy, fp] = train(DATA,LABEL,47,57,randdata, labeldict('foliage'),RECOMPUTE );
load(['media\','data_cat_',num2str(labeldict('foliage'))]);
M=ConvertU2LBP(trainingdata,8);
testlbl = [1:1:length(testingdata)];
for i=length(testingdata)+1:length(testingdata)+1+21
    testingdata(i,:) = randdata(i-length(testingdata),:);
    testlbl(i-10) = -1;
end
S=ConvertU2LBP(testingdata,8);
DM = distGMPDRN(M,S,8,2,3);
CP=ClassifyOnNN(DM,lbl,testlbl);
disp(['Foliage: SVM classification rate is ', num2str(accuracy*100), '%', '  |  NN ', num2str(CP) ]);
results(2)=accuracy;
fpresults(2) = fp;



[accuracy, fp] = train(DATA,LABEL,72,82,randdata, labeldict('stone'),RECOMPUTE );
load(['media\','data_cat_',num2str(labeldict('stone'))]);
M=ConvertU2LBP(trainingdata,8);
testlbl = [1:1:length(testingdata)];
for i=length(testingdata)+1:length(testingdata)+1+21
    testingdata(i,:) = randdata(i-length(testingdata),:);
    testlbl(i-10) = -1;
end
S=ConvertU2LBP(testingdata,8);
DM = distGMPDRN(M,S,8,2,3);
CP=ClassifyOnNN(DM,lbl,testlbl);
disp(['Stone: SVM classification rate is ', num2str(accuracy*100), '%', '  |  NN ', num2str(CP) ]);
results(3)=accuracy;
fpresults(3) = fp;


[accuracy, fp] = train(DATA,LABEL,93,103,randdata, labeldict('wood'),RECOMPUTE );
load(['media\','data_cat_',num2str(labeldict('wood'))]);
M=ConvertU2LBP(trainingdata,8);
testlbl = [1:1:length(testingdata)];
for i=length(testingdata)+1:length(testingdata)+1+21
    testingdata(i,:) = randdata(i-length(testingdata),:);
    testlbl(i-10) = -1;
end
S=ConvertU2LBP(testingdata,8);
DM = distGMPDRN(M,S,8,2,3);
CP=ClassifyOnNN(DM,lbl,testlbl);
disp(['Wood: SVM classification rate is ', num2str(accuracy*100), '%', '  |  NN ', num2str(CP) ]);
results(4)=accuracy;
fpresults(4) = fp;


toc;
