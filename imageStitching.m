function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image

outs = [700, 1800];
i2 = warpH(img2,H2to1,(outs));
panoImg = i2;
[height,width] = size(img1(:,:,1));
panoImg(1:height, 1:width, :) = img1;

end