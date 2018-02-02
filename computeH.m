function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation
N = size(p1,2);
u = p2(1,:)';
v = p2(2,:)';
x = p1(1,:)';
y = p1(2,:)';
A =[];
for i = 1:N
    a = [[-u(i),-v(i),-1,0,0,0,x(i)*u(i),x(i)*v(i),x(i)];[0,0,0,-u(i),-v(i),-1,y(i)*u(i),y(i)*v(i),y(i)]];
    A = [A;a];
end

% [U,S,V] = svd(A);
% 
% h = V(:,size(V,2)-1);

[V,D] = eig(double(A)'*double(A));
[value,in] = min(sum(D));
h = V(:,in);

H2to1 = reshape(h,[3,3])';



end