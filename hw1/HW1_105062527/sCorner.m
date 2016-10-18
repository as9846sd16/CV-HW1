function[sImg] = sCorner(oImg, dX, dY, h)
    id = fix(h/2);
    sImg = zeros(size(oImg));
    %repeat border pixels by mirror
    oImg = [oImg(flip(1:id), :); oImg; oImg(flip((end-id+1):end), :)];
    oImg = [oImg(:, flip(1:id), :), oImg, oImg(:, flip((end-id+1):end))];
    dX = [dX(flip(1:id), :); dX; dX(flip((end-id+1):end), :)];
    dX = [dX(:, flip(1:id), :), dX, dX(:, flip((end-id+1):end))];
    dY = [dY(flip(1:id), :); dY; dY(flip((end-id+1):end), :)];
    dY = [dY(:, flip(1:id), :), dY, dY(:, flip((end-id+1):end))];
    for i = id + 1 : size(oImg, 1)-id
        for j = id + 1 : size(oImg, 2)-id
            %calculate the small eigenvalue of Harris matrix
            sdX = dX(i-id:i+id, j-id:j+id).^2;
            dXdY = dX(i-id:i+id, j-id:j+id).*dY(i-id:i+id, j-id:j+id);
            sdY = dY(i-id:i+id, j-id:j+id).^2;
            H =[sum(sum(sdX)), sum(sum(dXdY));
                sum(sum(dXdY)), sum(sum(sdY))];
            [v, d] = eig(H);
            sImg(i-id,j-id) = min(diag(d));
        end
    end
end