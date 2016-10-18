function [nImg] = plotCorner(oImg, cImg)
    %remain R of RGB
    nImg = oImg;
    nImg(:,:,2:3) = 0;
    %plot corner point on the img
    x = (cImg ~= 0);
    x = repmat(x, 1, 1, 3);
    nImg(x) = 0;
    R = 255; G = 255; B = 255;
    nImg = nImg + uint8(x.*repmat(cat(3, R, G, B), size(x, 1), size(x, 2)));
end