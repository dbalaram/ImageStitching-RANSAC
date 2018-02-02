function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary

locs=[];
b=size(GaussianPyramid,1);
a=size(GaussianPyramid,2);
 for i=1:size(locsDoG,1)
     if (locsDoG(i,1)>4 && locsDoG(i,1)<a-4 && locsDoG(i,2)>4 && locsDoG(i,2)<b-4)
             locs=[locs;locsDoG(i,:)];
        
     end
 end

% l1 = locsDoG(:,1);
% l2 = locsDoG(:,2);
% endr = size(im,1);
% endc = size(im,2);
% locs= uint64(locsDoG((l1>4 & l2>4 & l1<endc-4 & l2< endr-4),:));


desc=zeros(size(locs,1),size(compareA,2));
for i=1:size(locs,1)
    m=locs(i,1);
    n=locs(i,2);
    A=im(n-4:n+4,m-4:m+4);
    A= A';
    A=A(:);
    A=A';
    for j=1:size(compareA,2)
        l=compareA(1,j);
        s=compareB(1,j);
        if A(1,l)<A(1,s)
            desc(i,j)=1;
        else
            desc(i,j)=0;
        end
    end
    
    
    
    
end


