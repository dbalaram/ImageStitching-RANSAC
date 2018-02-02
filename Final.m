I1 = imread('..data/incline_L.png');
I2 = imread('..data/incline_R.png');
img1 = im2double(I1);
img2 =im2double(I2);
if size(img1,3)==3
    img1= rgb2gray(img1);
end
if size(img2,3)==3
    img2= rgb2gray(img2);
end
[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);
[matches] = briefMatch(desc1,desc2,0.8);
nIter = 100;
tol = 1;
[bestH] = ransacH(matches, double(locs1), double(locs2), nIter, tol)
% [panoImg] = imageStitching(im2double(I1), im2double(I2), bestH);
 [panoImg] = imageStitching_noClip(I1,I2,bestH);
figure();
imshow(panoImg);
