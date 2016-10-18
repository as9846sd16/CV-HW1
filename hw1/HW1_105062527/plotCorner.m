function [nImg] = plotCorner(oImg, cImg, R, G, B, isR)
    nImg = oImg;    
    if(isR)
        %remain R of RGB
        nImg(:,:,2:3) = 0;
    end
    %plot corner point on the img
    x = (cImg ~= 0);
    x = repmat(x, 1, 1, 3);
    nImg(x) = 0;
    nImg = nImg + uint8(x.*repmat(cat(3, R, G, B), size(x, 1), size(x, 2)));
end