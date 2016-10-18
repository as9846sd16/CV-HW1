function nImg = ulbp(oImg, table)
    for i = 1:size(oImg, 1)
        for j = 1:size(oImg, 2)
            index = uint16(oImg(i,j)) + 1;
            nImg(i, j) = table(index);
        end
    end
end