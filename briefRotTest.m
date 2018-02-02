% Script to test BRIEF under rotations

 I1 = imread('data/model_chickenbroth.jpg');
 I2 = imread('data/model_chickenbroth.jpg');
% I1 = imread('data/incline_R.png');
% I2 = imread('data/incline_L.png');
im1 = im2double(I1);
[locs1, desc1] = briefLite(im1);
newm=[];
CorrMatch = [];
for i = 10:10:360
    im2 = im2double(I2);
    im2 = imrotate(im2,i);
    if size(im1,3)==3
        im1= rgb2gray(im1);
    end
    if size(im2,3)==3
        im2= rgb2gray(im2);
    end
   
    [locs2, desc2] = briefLite(im2);
    [matches] = briefMatch(desc1,desc2,0.8);
%     plotMatches(im1,im2,matches,locs1,locs2);
    close all;
    newm(1,1) = size(matches,1);
    newm(1,2)= i; 
    CorrMatch=[CorrMatch ;newm];
end
bar(CorrMatch(:,2),CorrMatch(:,1));