%Main file

RECOMPUTE = 1;

tic;

formatMaterialDataset;
load('media/materialgelsight_dataset');

%Train and report fabrics category
accuracy = train(DATA,LABEL,1,10,randdata, labeldict('fabrics'),RECOMPUTE );
disp('Classification Rate for Fabrics:');
accuracy*100


%Train and report fabrics category
accuracy = train(DATA,LABEL,58,68,randdata, labeldict('foliage'),RECOMPUTE );
disp('Classification Rate for Foliage:');
accuracy*100



%Train and report fabrics category
accuracy = train(DATA,LABEL,72,82,randdata, labeldict('stone'),RECOMPUTE );
disp('Classification Rate for stone:');
accuracy*100


%Train and report fabrics category
accuracy = train(DATA,LABEL,93,103,randdata, labeldict('wood'),RECOMPUTE );
disp('Classification Rate for Wood:');
accuracy*100


toc;
