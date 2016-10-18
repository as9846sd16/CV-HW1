function [nImg] = lbp(oImg)
    iImg = rgb2gray(oImg);
    %repeat border pixels by mirror
    iImg = [iImg(1, :); iImg; iImg(end, :)];
    iImg = [iImg(:, 1), iImg, iImg(:, end)];
    for i = 2 : size(iImg, 1) - 1
        for j = 2 : size(iImg, 2) - 1
            tmp = iImg(i-1:i+1, j-1:j+1);
            %gain 3X3 matrix which the elements means that is it larger or
            %equal to 2,2 element
            tmp = tmp >= tmp(2, 2);
            %turns the matrix into decimal number
            lbpArr = [tmp(1, :), tmp(2 : 3, 3)', tmp(3,2), tmp(3,1), tmp(2,1)];
            lbpStr = num2str(lbpArr);
            lbpNum = double(bin2dec(lbpStr));
            nImg(i-1,j-1) = lbpNum;
        end
    end
    %cast the element of the image matrix into uint8
    nImg = uint8(nImg);
end