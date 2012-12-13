
files=getAllFiles('media\dataset\tk_dataset');

labeldict =MapN();
labeldict('fabrics') = 1;
labeldict('foliage') = 2;
labeldict('stone') = 3;
labeldict('wood') = 4;


DATA = {};
LABEL = {};

CNT = 1;

for i=1:length(files)
    ss=regexp(files{i},'\','split');
    for ii=1:length(ss)
        if strcmp(ss{ii},'image4.png')
            DATA{CNT} = imread(files{i});
            LABEL{CNT} = labeldict(ss{4});
            CNT = CNT + 1;
        end
    end
end
  

%Random data (-1) which does not belong to any category
mapping=getmapping(8,'u2'); 
randfiles = getAllFiles('media\dataset\otherdata');
randdata = [];
CNT=1;
for i=1:length(randfiles)
    ss=regexp(randfiles{i},'\','split');
    for ii=1:length(ss)
        if strcmp(ss{ii},'image4.png')
            randdata(CNT,:) = LBPV(imread(randfiles{i}),1,8,mapping);
            CNT=CNT+1;
        end
    end
end

save('media\materialgelsight_dataset','DATA','LABEL','randdata','labeldict');