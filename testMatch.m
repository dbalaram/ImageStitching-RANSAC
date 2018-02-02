%  I1 = imread('../data/model_chickenbroth.jpg');
%  I2 = imread('../data/Chickenbroth_01.jpg');
% I1 = imread('../data/incline_L.png');
% I2 = imread('../data/incline_R.png');
I1 = imread('../data/pf_scan_scaled.jpg');
% I2 = imread('../data/pf_desk.jpg');
% I2 = imread('../data/pf_floor.jpg');
% I2 = imread('../data/pf_floor_rot.jpg');
% I2 = imread('../data/pf_pile.jpg');
I2 = imread('../data/pf_stand.jpg');
im1 = im2double(I1);
im2 = im2double(I2);
if size(im1,3)==3
    im1= rgb2gray(im1);
end
if size(im2,3)==3
    im2= rgb2gray(im2);
end
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
[matches] = briefMatch(desc1,desc2,0.8);
plotMatches(im1,im2,matches,locs1,locs2);