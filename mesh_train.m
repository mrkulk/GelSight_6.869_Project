function [accuracy,falsepos] = mesh_train(MESHDATA, MESHLABEL, test_ind_start,test_ind_end, MESHranddata, category, RECOMPUTE,testtmp  )

    if RECOMPUTE == 1
        %Test set
        MESHtrainstorage={};
        MESHtestingstorage={};
        dummy = {};
        for ii=1:109
            if ii >= test_ind_start && ii <= test_ind_end;
                MESHtestingstorage{ii} = MESHDATA{ii};
            else
                MESHtrainstorage{ii} = MESHDATA{ii};
            end
            ii/109;
        end

        CNT = 1;
        for ii=1:length(MESHtrainstorage)
            if ~isempty(MESHtrainstorage{ii})
                MESHtrainingdata(CNT,:) = MESHtrainstorage{ii};       
                if MESHLABEL{ii} == category
                    MESHlbl(CNT) = 1;
                else
                    MESHlbl(CNT) = -1;
                end   
                CNT = CNT + 1;
            end
        end

        CNT = 1;
        for ii=1:length(MESHtestingstorage)
            if ~isempty(MESHtestingstorage{ii})
                MESHtestingdata(CNT,:) = MESHtestingstorage{ii};         
                dummy{CNT}=testtmp{ii};
                CNT = CNT + 1;
            end
        end

        save(['media\','MESH_data_cat_',int2str(category)],'MESHtestingdata','MESHtrainingdata','MESHlbl','MESHranddata');
        
    else
        load(['media\','MESH_data_cat_',int2str(category)]);
    end
        
    SVMStruct=svmtrain(MESHtrainingdata,MESHlbl);
    labels = svmclassify(SVMStruct,MESHtestingdata);
    MESHrandlabels = svmclassify(SVMStruct,MESHranddata);
    accuracy = (size(find(labels==1),1)+size(find(MESHrandlabels==-1),1))/(size(labels,1)+size(MESHrandlabels,1));
    falsepos = 100*(length(find(MESHrandlabels == 1))/length(MESHrandlabels));
    disp(['False Positives: ' ,  num2str(falsepos), '%' ]);
end

