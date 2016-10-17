function[sImg] = sCorner(Img, dX, dY, h)
    id = fix(h/2);
    sImg = zeros(size(Img));
    for i = id + 1 : size(Img, 1)-id
        for j = id + 1 : size(Img, 2)-id
            sdX = dX(i-id:i+id, j-id:j+id).^2;
            dXdY = dX(i-id:i+id, j-id:j+id).*dY(i-id:i+id, j-id:j+id);
            sdY = dY(i-id:i+id, j-id:j+id).^2;
            H =[sum(sum(sdX)), sum(sum(dXdY));
                sum(sum(dXdY)), sum(sum(sdY))];
            [v, d] = eig(H);
            sImg(i,j) = min(diag(d));
        end
    end
end