function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.
locsDoG=[];
tempPyramid=padarray(DoGPyramid,[1,1],0,'both');
myPyramid=zeros(size(tempPyramid,1),size(tempPyramid,2),size(tempPyramid,3)+2);

for i=1:size(tempPyramid,3)
    myPyramid(:,:,i+1)=tempPyramid(:,:,i);
end

% myPyramid=abs(myPyramid);
for i=2:size(myPyramid,1)-1
    for j=2:size(myPyramid,2)-1
        for k=2:size(myPyramid,3)-1
          A=[myPyramid(i,j,k-1),myPyramid(i,j,k+1),myPyramid(i-1,j,k),myPyramid(i+1,j,k),myPyramid(i,j-1,k),...
              myPyramid(i,j+1,k),myPyramid(i+1,j+1,k),myPyramid(i-1,j-1,k),myPyramid(i+1,j-1,k),...
              myPyramid(i-1,j+1,k)];
          M=max(A);
          N=min(A);
         if((myPyramid(i,j,k)>M)||(myPyramid(i,j,k)<N))
             if (abs(myPyramid(i,j,k))>th_contrast)
                 if (abs(PrincipalCurvature(i-1,j-1,k-1))<th_r)
                     L=[i-1,j-1,k-2];
                     locsDoG=[locsDoG;L];
                 end
             end
         end
        end
    end
end
points=locsDoG(:,1:end-1);
points=fliplr(points);
tempno=locsDoG(:,end);
temp=[points,tempno];
locsDoG=temp;

