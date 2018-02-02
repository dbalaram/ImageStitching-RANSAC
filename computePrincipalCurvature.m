function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid
R =[];
for i = 1:size(DoGPyramid,3)
    [dx,dy] = gradient(DoGPyramid(:,:,i));
    [dxx,dxy] = gradient(dx);
    [dyx,dyy] = gradient(dy);
    disp('Equal?')
    eq = isequal(dyx,dxy);
    disp(eq);
    T = dxx + dyy;
    D = (dxx.*dyy)- (dxy .* dyx);
    R(:,:,i) = (T.*T)./D;
end
PrincipalCurvature = R;
end