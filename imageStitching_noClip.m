function [panoImg] = imageStitching_noClip(img1,img2,H2to1)

[height2,width2,~] = size(img2);
[height1,width1,~] = size(img1);

cornerPoints = [[1,1,1];[1,height2,1];[width2,1,1];[width2,height2,1]];
H = H2to1 / H2to1(3,3);
C = cornerPoints';
Warp_CP = H  * C;
Warp_CP = Warp_CP ./ repmat(Warp_CP(3,:),3,1);

left = floor(min(1,min(Warp_CP(1,:))));
up = floor(min(1,min(Warp_CP(2,:))));
right = floor(max(width1,max(Warp_CP(1,:))));
down = floor(max(height1,max(Warp_CP(2,:))));

AspectRatio = (down - up) / (right-left) ; 
wid = 1200;
scalex =wid/abs(right-left) ;
Ht = ceil(abs(down-up)*scalex);
% Ht =  floor(wid * AspectRatio);


% Translation = [[1,0,-left];[0,1,-up];[0,0,1]];
% Scaling  = [[wid/(right-left),0,0];[0,Ht/(down-up),0];[0,0,1]];
%  M = Scaling .* Translation;
t1= min([0,Warp_CP(1,:)] * scalex);
t2 = min([0,Warp_CP(2,:)] * scalex);

M = [[scalex,0,-t1];[0,scalex,-t2];[0,0,1]];
out_size = [Ht wid];
wim1 = warpH(img1, M, out_size);
wim2 = warpH(img2, M * H2to1, out_size);
panoImg = max(wim1,wim2);

% panoImg=imfuse(wim1,wim2,'blend','Scaling','joint');


end
