%Tejas Kulkarni
%tejask@mit.edu

function T = TransformRANSAC( x1,x2 )

    max_iter = 100;
    T=zeros(3,3);
    sample_size = 8;
    A=zeros(2*sample_size,9); %2n X 9

    if size(x1) ~= size(x2)
        disp('ERROR: X1 and X2 need to be of the same size!');
        return;
    end

    THRESHOLD = 0.1;
    MAX_INLINERS = -1;

    for i=1:max_iter
        % sample 8 points from x1 and x2
        pt = ceil(rand(1,sample_size)*(size(x1,1)-1))';
        k=1;
        for j = 1:length(pt)
             x_1 = x1(pt(j),1);
             y_1 = x1(pt(j),2);
             x_2 = x2(pt(j),1);
             y_2 = x2(pt(j),2);
             A(k,:) = [x_1 y_1 1 0 0 0 -x_2*x_1 -x_2*y_1 -x_2]; 
             A(k+1,:) = [0 0 0 x_1 y_1 1 -y_2*x_1 -y_2*y_1 -y_2];
             k=k+2;
        end
        [~,~,V] = svd(A);
		H = reshape(V(:,end),3,3);
        
        tform = maketform('projective',H);
        [xtran(:,1) xtran(:,2)] = tformfwd(tform,x1(:,1),x2(:,2));
        
        %calculating inliners
        inlines = sum(abs(x2-xtran).^2,2) < THRESHOLD;

        if MAX_INLINERS < sum(inlines)
            MAX_INLINERS = sum(inlines);
            inline_inds = inlines;
        end
        
    end
    
    % calculating homography for most OPTIMAL inliners
    x1_inlines = x1(inline_inds,:);
    x2_inlines = x2(inline_inds,:);
    for j = 1:length(x1_inlines)             
        x_1 = x1_inlines(j,1);      
        y_1 = x1_inlines(j,2);       
        x_2 = x2_inlines(j,1);      
        y_2 = x2_inlines(j,2);      
        A(j,:) = [x_1 y_1 1 0 0 0 -x_2*x_1 -x_2*y_1 -x_2];    
        A(j+1,:) = [0 0 0 x_1 y_1 1 -y_2*x_1 -y_2*y_1 -y_2];    
    end
    
    [~,~,V] = svd(A);
	H = reshape(V(:,end),3,3);
      
    T = maketform('projective',H);
    

