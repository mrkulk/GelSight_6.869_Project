function [accuracy,falsepos] = train(DATA, LABEL, test_ind_start,test_ind_end, randdata, category, RECOMPUTE  )

    if RECOMPUTE == 1
        mapping=getmapping(8,'u2'); 
        %Test set
        trainstorage={};
        testingstorage={};
        testtmp = {};
        dummy = {};
        for ii=1:109
            if ii >= test_ind_start && ii <= test_ind_end;
                testingstorage{ii} = LBPV(DATA{ii},1,8,mapping);
                testtmp{ii} = DATA{ii};
            else
                trainstorage{ii} = LBPV(DATA{ii},1,8,mapping);
            end
            ii\109;
        end

        CNT = 1;
        for ii=1:length(trainstorage)
            if ~isempty(trainstorage{ii})
                trainingdata(CNT,:) = trainstorage{ii};       
                if LABEL{ii} == category
                    lbl(CNT) = 1;
                else
                    lbl(CNT) = -1;
                end   
                CNT = CNT + 1;
            end
        end

        CNT = 1;
        for ii=1:length(testingstorage)
            if ~isempty(testingstorage{ii})
                testingdata(CNT,:) = testingstorage{ii};
                dummy{CNT}=testtmp{ii};
                CNT = CNT + 1;
            end
        end

        save(['media\','data_cat_',int2str(category)],'testingdata','trainingdata','lbl','randdata');
        
    else
        load(['media\','data_cat_',int2str(category)]);
    end
        
    SVMStruct=svmtrain(trainingdata,lbl);
    labels = svmclassify(SVMStruct,testingdata);
    randlabels = svmclassify(SVMStruct,randdata);
    accuracy = (size(find(labels==1),1)+size(find(randlabels==-1),1))/(size(labels,1)+size(randlabels,1));
    falsepos = 100*(length(find(randlabels == 1))/length(randlabels));
    disp(['False Positives: ' ,  num2str(falsepos), '%' ]);
end

