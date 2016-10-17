function [magnitude, dX, dY, direction] = SobelMask(img)
    magnitude = zeros(size(img));
    dX = zeros(size(img));
    dY = zeros(size(img));
    direction = zeros(size(img));
    for i = 2:size(img, 1)-1
        for j = 2:size(img, 2)-1
            %cross correlation
            tmp = double(img(i-1:i+1, j+1)) - double(img(i-1:i+1, j-1));
            magX = sum(tmp) + tmp(2);
            tmp = double(img(i-1, j-1:j+1)) - double(img(i+1, j-1:j+1));
            magY = sum(tmp) + tmp(2);
            %record dX, dY
            dX(i, j) = magX;
            dY(i, j) = magY;
            %compute magnitude
            mag = sqrt(magX^2 + magY^2);
            magnitude(i,j) = mag;
            %compute direction
            dir = atan2(magY, magX);
            direction(i,j) = dir;
        end
    end
    %thresholding  eliminate weak gradients
    th = 4*mean(mean(magnitude));
    magnitude(magnitude<=th)=0;
    %(x + pi)/2*pi = 0 -> x = -pi
    direction(magnitude<=th)=-pi;
end