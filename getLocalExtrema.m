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
srows = size(DoGPyramid,1);
scol = size(DoGPyramid,2);
m = 3 * ones(1,srows);
n = 3 * ones(1,scol);
locsDoG =[];

% zero padding 
 Z1 = zeros(1,size(DoGPyramid,2),5);
 Z2 = zeros(size(DoGPyramid,1)+2,1,5);
 DPyr = [Z1;DoGPyramid;Z1];
 DP = [Z2,DPyr,Z2];
ind =0;
flag = 2;
for l = 1:5
    for i = 2:size(DP,1)-1
        for j = 2:size(DP,2)-1
            
           Temp =  DP(i-1:i+1,j-1:j+1,l);
           mx = max(max(Temp));
           mn = min(min(Temp));
           if (abs(DP(i,j,l))> th_contrast && PrincipalCurvature(i-1,j-1,l) < th_r)
               
           if(DP(i,j,l) == mx )
               
               flag = 1;
           elseif (DP(i,j,l) == mn)
               
               flag = 0;
           
           end
          
           if (flag == 1)
              
               if l==1
                   if(DP(i,j,l) > DP(i,j,l+1))
                        locsDoG(ind+1,1) = j-1;
                        locsDoG(ind+1,2) = i-1;
                        locsDoG(ind+1,3) = l;
                        ind = ind+1;
                        
                   end
                   
               elseif l ==5
                   if(DP(i,j,l) > DP(i,j,l-1))
                         locsDoG(ind+1,1) = j-1;
                         locsDoG(ind+1,2) = i-1;
                         locsDoG(ind+1,3) = l;
                         ind = ind+1;
                   end
           
               elseif l >1 && l<5
                    if(DP(i,j,l) > DP(i,j,l-1) && DP(i,j,l)>DP(i,j,l+1))
                        locsDoG(ind+1,1) = j-1;
                        locsDoG(ind+1,2) = i-1;
                        locsDoG(ind+1,3) = l;
                        ind = ind+1;
                    end
               end
               flag =2;    
           end
           
            if (flag == 0)
              if l==1
                   if(DP(i,j,l) < DP(i,j,l+1))
                        locsDoG(ind+1,1) = j-1;
                        locsDoG(ind+1,2) = i-1;
                        locsDoG(ind+1,3) = l;
                        ind = ind+1;
                        
                   end
                   
               elseif l ==5
                   if(DP(i,j,l) < DP(i,j,l-1))
                         locsDoG(ind+1,1) = j-1;
                         locsDoG(ind+1,2) = i-1;
                         locsDoG(ind+1,3) = l;
                         ind = ind+1;
                   end
           
               elseif l >1 && l<5
                    if(DP(i,j,l) < DP(i,j,l-1) && DP(i,j,l)<DP(i,j,l+1))
                        locsDoG(ind+1,1) = j-1;
                        locsDoG(ind+1,2) = i-1;
                        locsDoG(ind+1,3) = l;
                        ind = ind+1;
                    end
               end
               flag =2;    
           end
            
           end
%         Pyr3 = mat2cell(DoGPyramid(:,:,i),m,n);
%         Pyr2 = mat2cell(DoGPyramid(:,:,i-1),m,n);
%         Pyr1 = mat2cell(DoGPyramid(:,:,i-2),m,n);
        end 
    end
end
end
