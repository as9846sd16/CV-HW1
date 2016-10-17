function [img] = nonMaxSup(oImg, dir)
    n = 7;
    id = floor(n/2);
    img = oImg;
    for i = id + 1 : size(oImg, 1) - id
        for j = id + 1 : size(oImg, 2) - id
            isPMax = true;
            p = oImg(i,j);
            p1=[];p2=[];p3=[];p4=[];
            theta = dir(i,j) + pi/2;
            if(theta > pi)
                theta = theta - 2*pi;
            end
            m = tan(theta);
            %check horizontal line
            for ii = i-id:i+id
                %find itself
                if(ii == i)
                    continue;
                end
                x = (ii - i) / m + j;
                x1 = floor(x); x2 = ceil(x);
                ratio = abs(x-x1);
                %check the point is in the mask
                if~(x1 >= j - id && x2 <= j + id)
                    continue;
                end
                np = (1 - ratio) * oImg(ii, x1) + ratio * oImg(ii, x2);
                if(np >= p)
                    isPMax = false;
                    break;
                end
            end
            %check verical line
            for jj = j-id:j+id
                %find itself
                if(jj == j)
                    continue;
                end
                y = m * (jj - j) + i;
                y1 = floor(y); y2 = ceil(y);
                ratio = abs(y-y1);
                %check the point is in the mask
                if~(y1 >= i - id && y2 <= i + id)
                    continue;
                end
                np = (1 - ratio) * oImg(y1, jj) + ratio * oImg(y2, jj);
                if(np >= p)
                    isPMax = false;
                    break;
                end
            end
            if~(isPMax)
                img(i,j) = 0;
            end
%             if(theta > -pi/4 && theta < pi/4) ||...
%                theta > 3*pi/4 || theta < -3*pi/4
%                 ratio = abs(tan(theta));
%             else
%                 ratio = abs(cot(theta));
%             end
%             %set p1
%             if(theta >= 0 && theta < pi/2)
%                 p1 = oImg(i-1, j+1);
%                 p3 = oImg(i+1, j-1);
%             elseif(theta >= pi/2)
%                 p1 = oImg(i-1, j-1);
%                 p3 = oImg(i+1, j+1);
%             elseif(theta < 0 && theta >= -pi/2)
%                 p1 = oImg(i+1, j+1);
%                 p3 = oImg(i-1, j-1);
%             else
%                 p1 = oImg(i+1, j-1);
%                 p3 = oImg(i-1, j+1);
%             end
%             %set p2
%             if(theta >= -pi/4 && theta < pi/4)
%                 p2 = oImg(i, j+1);
%                 p4 = oImg(i, j-1);
%             elseif(theta >= pi/4 && theta < 3*pi/4)
%                 p2 = oImg(i-1, j);
%                 p4 = oImg(i+1, j);
%             elseif(theta > 3*pi/4 || theta < -3*pi/4)
%                 p2 = oImg(i, j-1);
%                 p4 = oImg(i, j+1);
%             else
%                 p2 = oImg(i+1, j);
%                 p4 = oImg(i-1, j);
%             end
%             pp1 = p1*ratio + p2*(1-ratio);
%             pp2 = p3*ratio + p4*(1-ratio);
%             if ~(p > pp1 && p > pp2)
%                 img(i,j) = 0;
%             end
        end
    end
    img(img< 200*mean(mean(img)))=0;
end