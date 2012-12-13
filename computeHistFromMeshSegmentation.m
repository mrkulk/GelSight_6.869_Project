function histout = computeHistFromMeshSegmentation( BW )

%BW = abs( BW - 1 );
CC = bwconncomp(BW);

%hist=zeros(1,260);
tmp(1)=0;
for ii=1:CC.NumObjects
    tmp(ii) = sum(CC.PixelIdxList{ii});
end
 
tmp=tmp/sum(tmp);

histout = histc(tmp,[0:0.0001:1]);
length(histout);

% HIST_SIZE = 1;
% 
% L=L+1;
% 
% segments = unique(L);
% 
% histout=[];
% 
% starts=min(segments(:));
% ends=max(segments(:));
% 
% for i=starts:ends
%    tmp(i) = length(find(L==i)); 
% end
%     
% cnt = 1;
% for i=starts:HIST_SIZE:ends-HIST_SIZE
%     histout(cnt) = 0;
%     for j=i:i+HIST_SIZE
%         histout(cnt) = histout(cnt) + tmp(j);
%     end
%     cnt=cnt+1;
% end
% 
% histout = histout/sum(histout); %normalization
% length(histout)
end

