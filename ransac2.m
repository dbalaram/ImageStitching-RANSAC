function [bestH] = ransac2(matches, locs1, locs2, nIter, tol)
    % set default constant
    if nargin < 4
        nIter = 1000;
        tol = 0.4;
    end
    if nargin < 5;
        tol = 0.4;
    end
    locs2 = double(locs2);
    bestH = zeros(3,3);
    N = size(matches, 1);
    % get all matches.
    locs2_temp = locs2';
    locs2_temp = locs2_temp(1:2,:);
    locs2_temp = locs2_temp(:,matches(:,2));
    locs2_temp = [locs2_temp; ones(1,size(locs2_temp,2))];
    % reference points in image1
    locs1_ref = locs1';
    locs1_ref = locs1_ref(:,matches(:,1));
    best_num = 0;

    for i = 1:nIter
        p = randperm(N,4);
        locs1_new = double(locs1_ref(1:2,:));
        locs2_new = double(locs2_temp(1:2,:));
        p1 = locs1_new(:,p);
        p2 = locs2_new(:,p);
        h2to1_temp = computeH(p1,p2);
        % locs1_temp is points compute by locs2_new.
        locs1_temp = h2to1_temp*locs2_temp;
        locs1_temp = locs1_temp./(repmat(locs1_temp(3,:),3,1));
        dif = double(locs1_ref) - locs1_temp;
        % third line doesn't matter
        dif = dif(1:2,:);
        % compute distance using arrayfun to speed up
        distance = arrayfun(@(iter) norm(dif(:,iter)), 1:size(dif,2));
        % set outlier to tol, then inlier to 1 then outlier to 0. if we set outlier to 0 at first, all points will be set to 1.
        distance(distance >= tol) = tol;
        distance(distance ~= tol) = 1;
        distance(distance == tol) = 0;
        inlier_num = sum(distance);
        if inlier_num > best_num
            bestH = h2to1_temp;
            best_num = inlier_num;
        end
    end
end