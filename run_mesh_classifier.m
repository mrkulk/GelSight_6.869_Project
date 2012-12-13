%Main file

RECOMPUTE = 1;

tic;

formatMeshDataset;
%load('media\mesh_dataset');

meshresults = [];
meshfpresults = [];
CP = 0;

%mesh_train and report fabrics category
[accuracy, fp] = mesh_train(MESHDATA,MESHLABEL,1,10,MESHranddata, labeldict('fabrics'),RECOMPUTE,testtmp );
load(['media\','MESH_data_cat_',int2str(labeldict('fabrics'))]);
% M=ConvertU2LBP(MESHtrainingdata,8);
% MESHtestlbl = [1:1:length(MESHtestingdata)];
% for i=length(MESHtestingdata)+1:length(MESHtestingdata)+1+21
%     MESHtestingdata(i,:) = MESHranddata(i-length(MESHtestingdata),:);
%     MESHtestlbl(i-10) = -1;
% end
% S=ConvertU2LBP(MESHtestingdata,8);
% DM = distGMPDRN(M,S,8,2,3);
% CP=ClassifyOnNN(DM,MESHlbl,MESHtestlbl);
disp(['fabrics: SVM classification rate is ', num2str(accuracy*100), '%', '  |  NN ', num2str(CP) ]);
meshresults(1)=accuracy;
meshfpresults(1) = fp;



%mesh_train and report fabrics category
[accuracy, fp] = mesh_train(MESHDATA,MESHLABEL,58,68,MESHranddata, labeldict('foliage'),RECOMPUTE,testtmp );
load(['media\','MESH_data_cat_',int2str(labeldict('foliage'))]);
% M=ConvertU2LBP(MESHtrainingdata,8);
% MESHtestlbl = [1:1:length(MESHtestingdata)];
% for i=length(MESHtestingdata)+1:length(MESHtestingdata)+1+21
%     MESHtestingdata(i,:) = MESHranddata(i-length(MESHtestingdata),:);
%     MESHtestlbl(i-10) = -1;
% end
% S=ConvertU2LBP(MESHtestingdata,8);
% DM = distGMPDRN(M,S,8,2,3);
% CP=ClassifyOnNN(DM,MESHlbl,MESHtestlbl);
disp(['foliage: SVM classification rate is ', num2str(accuracy*100), '%', '  |  NN ', num2str(CP) ]);
meshresults(2)=accuracy;
meshfpresults(2) = fp;





%mesh_train and report fabrics category
[accuracy, fp] = mesh_train(MESHDATA,MESHLABEL,72,82,MESHranddata, labeldict('stone'),RECOMPUTE,testtmp );
load(['media\','MESH_data_cat_',int2str(labeldict('stone'))]);
% M=ConvertU2LBP(MESHtrainingdata,8);
% MESHtestlbl = [1:1:length(MESHtestingdata)];
% for i=length(MESHtestingdata)+1:length(MESHtestingdata)+1+21
%     MESHtestingdata(i,:) = MESHranddata(i-length(MESHtestingdata),:);
%     MESHtestlbl(i-10) = -1;
% end
% S=ConvertU2LBP(MESHtestingdata,8);
% DM = distGMPDRN(M,S,8,2,3);
% CP=ClassifyOnNN(DM,MESHlbl,MESHtestlbl);
disp(['stone: SVM classification rate is ', num2str(accuracy*100), '%', '  |  NN ', num2str(CP) ]);
meshresults(3)=accuracy;
meshfpresults(3) = fp;



%mesh_train and report fabrics category
[accuracy, fp] = mesh_train(MESHDATA,MESHLABEL,93,103,MESHranddata, labeldict('wood'),RECOMPUTE,testtmp );
load(['media\','MESH_data_cat_',int2str(labeldict('wood'))]);
% M=ConvertU2LBP(MESHtrainingdata,8);
% MESHtestlbl = [1:1:length(MESHtestingdata)];
% for i=length(MESHtestingdata)+1:length(MESHtestingdata)+1+21
%     MESHtestingdata(i,:) = MESHranddata(i-length(MESHtestingdata),:);
%     MESHtestlbl(i-10) = -1;
% end
% S=ConvertU2LBP(MESHtestingdata,8);
% DM = distGMPDRN(M,S,8,2,3);
% CP=ClassifyOnNN(DM,MESHlbl,MESHtestlbl);
disp(['wood: SVM classification rate is ', num2str(accuracy*100), '%', '  |  NN ', num2str(CP) ]);
meshresults(4)=accuracy;
meshfpresults(4) = fp;

toc;
