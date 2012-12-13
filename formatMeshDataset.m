
files=getAllFiles('media\dataset\tk_dataset');

labeldict =MapN();
labeldict('fabrics') = 1;
labeldict('foliage') = 2;
labeldict('stone') = 3;
labeldict('wood') = 4;


MESHDATA = {};
MESHLABEL = {};

CNT = 1;
testtmp  = {};

for i=1:length(files)
    ss=regexp(files{i},'\','split');
    for ii=1:length(ss)
        if strcmp(ss{ii},'surface.pfm')
            [img,scale]=read_pfm(files{i},0);
            BW=filterDepthMap(img);
            MESHDATA{CNT} = computeHistFromMeshSegmentation(BW);
            testtmp{CNT} = img;
            MESHLABEL{CNT} = labeldict(ss{4});
            CNT = CNT + 1;
        end
    end
end
  

%Random data (-1) which does not belong to any category
randfiles = getAllFiles('media\dataset\otherdata');
MESHranddata = [];
CNT=1;
for i=1:length(randfiles)
    ss=regexp(randfiles{i},'\','split');
    for ii=1:length(ss)
        if strcmp(ss{ii},'surface.pfm')
            [img,scale]=read_pfm(randfiles{i},0);
            BW=filterDepthMap(img);
            MESHranddata(CNT,:) = computeHistFromMeshSegmentation(BW);
            CNT=CNT+1;
        end
    end
end

save('media\mesh_dataset','MESHDATA','MESHLABEL','MESHranddata','labeldict');