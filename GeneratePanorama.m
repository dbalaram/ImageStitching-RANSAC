function GeneratePanorama(I1,I2)
% I1 = imread('data/incline_L.png');
% I2 = imread('data/incline_R.png');
mkdir('../results');
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

[panoI] = imageStitching(im2double(I1), im2double(I2), bestH);
figure();
imshow(panoI);

imwrite(panoI,'../results/q6_1.jpeg','jpg');
 save('../results/q6_1.mat','bestH');

[panoImg] = imageStitching_noClip(I1,I2,bestH);
figure();
imshow(panoImg);
imwrite(panoImg,'../results/q6_2_pan.jpg','jpg');
end
