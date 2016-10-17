function [nImg, histograms] = lbp(oImg)
    iImg = rgb2gray(oImg);
    histograms = zeros(1,256);
    for i = 2 : size(iImg) - 1
        for j = 2 : size(iImg) - 1
            tmp = iImg(i-1:i+1, j-1:j+1);
            tmp = tmp >= tmp(2, 2);
            lbpArr = [tmp(1, :), tmp(2 : 3, 3)', tmp(3,2), tmp(3,1), tmp(2,1)];
            lbpStr = num2str(lbpArr);
            lbpNum = uint8(bin2dec(lbpStr));
            nImg(i,j) = lbpNum;
            histograms(lbpNum + 1) = histograms(lbpNum + 1) + 1;
        end
    end
end