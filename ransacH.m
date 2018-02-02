function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC
ct =0;
C=[];
InliersP1 = [];
InliersP2 = [];
P1new =[];
for i=1:nIter
    Random = randi([1, size(matches,1)],1,4);
    p1 = double(locs1(matches(Random,1),1:2))';
    p2 = double(locs2(matches(Random,2),1:2))';
    H = computeH(p1,p2);
    M = matches(:,1);
    M2 = matches(:,2);
    P1 = double([locs1(M(:),1:2)';ones(1,size(M,1))]);
    P2 = double([locs2(M2(:),1:2)';ones(1,size(M2,1))]);
    P1n = H * (P2);
    P1new = [(P1n(1,:) ./ P1n(3,:)) ; (P1n(2,:) ./ P1n(3,:)) ; (P1n(3,:) ./ P1n(3,:))];
    
    D = (P1new - P1);
    dist =(D .* D); 
    s = sqrt(sum(dist)); %Eucledean distance
    
    Greater = (s<(tol));
    [row col ] = find(Greater == 1); %col stores information, row = 1
    count = sum(Greater);
    if count>ct;
%         InliersP1 = [];
%         InliersP2 = [];
        points1 = P1(1:2,col);
        points2 = P2(1:2,col);
        ct = count;
        C = [C count];
    end
   
%         InliersP1 = [InliersP1 ,P1(1:2,:)];
%         InliersP2 = [InliersP2 ,P2(1:2,:)];
disp(count);     
end

bestH = computeH(points2,points1);
disp(size(points1));
    
  
    
end