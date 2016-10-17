function [nHist] = myHist(oImg, cellNum)
    oImg = double(oImg);
    C = mat2cell(oImg, floor(size(oImg, 1)/cellNum)*ones(1, cellNum), floor(size(oImg, 2)/cellNum)*ones(1, cellNum));
    nHist = [];
    for i = 1:cellNum
        for j = 1:cellNum
            m = C{i,j};
            tHist = zeros(1,256);
            for k = 1:size(m, 1)
                for l = 1:size(m, 2)
                   tHist(uint16(m(k,l) + 1)) = tHist(uint16(m(k,l) + 1)) + 1; 
                end
            end
            nHist = [nHist, tHist];
        end
    end
    nHist = nHist./sum(nHist);
end