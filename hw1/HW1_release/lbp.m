function [nImg] = lbp(oImg)
    iImg = rgb2gray(oImg);
    iImg = [iImg(1, :); iImg; iImg(end, :)];
    iImg = [iImg(:, 1), iImg, iImg(:, end)];
    for i = 2 : size(iImg, 1) - 1
        for j = 2 : size(iImg, 2) - 1
            tmp = iImg(i-1:i+1, j-1:j+1);
            tmp = tmp >= tmp(2, 2);
            lbpArr = [tmp(1, :), tmp(2 : 3, 3)', tmp(3,2), tmp(3,1), tmp(2,1)];
            lbpStr = num2str(lbpArr);
            lbpNum = double(bin2dec(lbpStr));
            nImg(i-1,j-1) = lbpNum;
        end
    end
    nImg = uint8(nImg);
end