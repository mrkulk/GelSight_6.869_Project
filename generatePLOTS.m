% 
% % Performance graph
% clear Y;
% Y(1,:)=results;
% Y(2,:)=meshresults;
% Y(3,:)=[0.25 0.25 0.25 0.25];
% Y=Y';
% 
% figure;
% bar(Y,'grouped');
% title('Classification rate for material categories');

% 
% clear Y;
% Y(1,:)=fpresults;
% Y(2,:)=meshfpresults;
% Y=Y';
% 
% figure;
% bar(Y,'stacked');
% title('False positive rate for entire test set');
% 

%performance
% clear Y;
% Y(1,:)=[0.0309 0.2060];
% Y=Y';
% 
% figure;
% bar(Y,'grouped');
% title('Speed test for different LBP feature implementations');




