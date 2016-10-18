function [magnitude, dX, dY, direction] = SobelMask(oImg)
    magnitude = zeros(size(oImg));
    dX = zeros(size(oImg));
    dY = zeros(size(oImg));
    direction = zeros(size(oImg));
    %repeat border pixels by mirror
    oImg = [oImg(1, :); oImg; oImg(end, :)];
    oImg = [oImg(:, 1), oImg, oImg(:, end)];
    for i = 2:size(oImg, 1)-1
        for j = 2:size(oImg, 2)-1
            %cross correlation
            tmp = double(oImg(i-1:i+1, j+1)) - double(oImg(i-1:i+1, j-1));
            magX = sum(tmp) + tmp(2);
            tmp = double(oImg(i-1, j-1:j+1)) - double(oImg(i+1, j-1:j+1));
            magY = sum(tmp) + tmp(2);
            %record dX, dY
            dX(i-1, j-1) = magX;
            dY(i-1, j-1) = magY;
            %compute magnitude
            mag = sqrt(magX^2 + magY^2);
            magnitude(i-1,j-1) = mag;
            %compute direction
            dir = atan2(magY, magX);
            direction(i-1,j-1) = dir;
        end
    end
    %thresholding  eliminate weak gradients
    th = 4*mean(mean(magnitude));
    magnitude(magnitude<=th)=0;
    %(x + pi)/2*pi = 0 -> x = -pi
    direction(magnitude<=th)=-pi;
end