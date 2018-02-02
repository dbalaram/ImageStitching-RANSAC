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

l1 = locsDoG(:,1);
l2 = locsDoG(:,2);
endr = size(im,1);
endc = size(im,2);
locs= uint64(locsDoG((l1>4 & l2>4 & l1<endc-4 & l2< endr-4),:));

desc =[];
for i = 1:size(locs,1)
    temp = im(locs(i,2)-4:locs(i,2)+4,locs(i,1)-4: locs(i,1)+4);
    A = (temp(compareA) > temp(compareB));
    desc(i,:) = A;
    
end
