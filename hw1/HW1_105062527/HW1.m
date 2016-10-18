%% clear and read image
clc;clear;close all;
oImg = imread('data/J4Poro.png');
%% Define Color Map
% The hsvMap will mapping value 0 ~ 1 to custom color space
hsvMap = linspace( 0, 1, 99 )' ;
hsvMap(:, 2) = 0.5;
hsvMap(:, 3) = 1;
rgbMap = hsv2rgb(hsvMap);
rgbMap = [ 0.2 0.2 0.2 ; rgbMap ];
%% Part 1. A. gaussian filter with kernel size 3x3 and 9x9
gaussian_5s3h = fspecial('gaussian', 3, 5);
g3hImg = imfilter(oImg, gaussian_5s3h);
gaussian_5s9h = fspecial('gaussian', 9, 5);
g9hImg = imfilter(oImg, gaussian_5s9h);
figure('Name','g3hImg','NumberTitle','off');
imshow(g3hImg);imwrite(g3hImg, 'result/g3hImg.png');
figure('Name','g9hImg','NumberTitle','off');
imshow(g9hImg);imwrite(g9hImg, 'result/g9hImg.png');
fprintf('Part 1. A. finished\n');
%% Part 1. B. Apply sobel masks and find magnitude and direction
grayG3hImg = rgb2gray(g3hImg);
[magG3hImg, d3X, d3Y, dirG3hImg] = SobelMask(grayG3hImg);
grayG9hImg = rgb2gray(g9hImg);
[magG9hImg, d9X, d9Y, dirG9hImg] = SobelMask(grayG9hImg);
figure('Name','magG3hImg','NumberTitle','off');imshow(magG3hImg);
imwrite(magG3hImg, 'result/magG3hImg.png');
figure('Name','dirG3hImg','NumberTitle','off');imshow(dirPi2One(dirG3hImg), 'ColorMap', rgbMap);
imwrite(gray2ind(dirPi2One(dirG3hImg), 99), rgbMap,'result/dirG3hImg.png');
figure('Name','magG9hImg','NumberTitle','off');imshow(magG9hImg);
imwrite(magG9hImg, 'result/magG9hImg.png');
figure('Name','dirG9hImg','NumberTitle','off');imshow(dirPi2One(dirG9hImg), 'ColorMap', rgbMap);
imwrite(gray2ind(dirPi2One(dirG9hImg), 99), rgbMap,'result/dirG9hImg.png');
fprintf('Part 1. B. finished\n');
%% Part 1. C. construct small eigen value of H matrix
[sImg33] = sCorner(grayG3hImg, d3X, d3Y, 3);
[sImg35] = sCorner(grayG3hImg, d3X, d3Y, 5);
[sImg93] = sCorner(grayG9hImg, d9X, d9Y, 3);
[sImg95] = sCorner(grayG9hImg, d9X, d9Y, 5);
figure('Name', 'sImg33', 'NumberTitle', 'off');imshow(sImg33);
imwrite(sImg33, 'result/sImg33.png');
figure('Name', 'sImg35', 'NumberTitle', 'off');imshow(sImg35);
imwrite(sImg35, 'result/sImg35.png');
figure('Name', 'sImg93', 'NumberTitle', 'off');imshow(sImg93);
imwrite(sImg93, 'result/sImg93.png');
figure('Name', 'sImg95', 'NumberTitle', 'off');imshow(sImg95);
imwrite(sImg95, 'result/sImg95.png');
fprintf('Part 1. C. finished\n');
%% Part 1. D. perform non-maximal suppression on 1. C. results
[nsImg33] = nonMaxSup(sImg33, dirG3hImg, 3);
[nsImg35] = nonMaxSup(sImg35, dirG3hImg, 3);
[nsImg93] = nonMaxSup(sImg93, dirG9hImg, 3);
[nsImg95] = nonMaxSup(sImg95, dirG9hImg, 3);
figure('Name', 'nsImg33', 'NumberTitle', 'off');imshow(plotCorner(oImg, nsImg33));
imwrite(plotCorner(oImg, nsImg33), 'result/nsImg33.png');
figure('Name', 'nsImg35', 'NumberTitle', 'off');imshow(plotCorner(oImg, nsImg35));
imwrite(plotCorner(oImg, nsImg35), 'result/nsImg35.png');
figure('Name', 'nsImg93', 'NumberTitle', 'off');imshow(plotCorner(oImg, nsImg93));
imwrite(plotCorner(oImg, nsImg93), 'result/nsImg93.png');
figure('Name', 'nsImg95', 'NumberTitle', 'off');imshow(plotCorner(oImg, nsImg95));
imwrite(plotCorner(oImg, nsImg95), 'result/nsImg95.png');
fprintf('Part 1. D. finished\n');
%% Part 1. E. rotate 30 degree and scale to 0.5x, then apply 1.A to 1.D
nImg = imrotate(oImg, 30);
nImg = imresize(nImg, 0.5);
%1.A
g3hImg = imfilter(nImg, gaussian_5s3h);
g9hImg = imfilter(nImg, gaussian_5s9h);
%1.B
grayG3hImg = rgb2gray(g3hImg);
[magG3hImg, d3X, d3Y, dirG3hImg] = SobelMask(grayG3hImg);
grayG9hImg = rgb2gray(g9hImg);
[magG9hImg, d9X, d9Y, dirG9hImg] = SobelMask(grayG9hImg);
%1.C
[sImg33] = sCorner(grayG3hImg, d3X, d3Y, 3);
[sImg35] = sCorner(grayG3hImg, d3X, d3Y, 5);
[sImg93] = sCorner(grayG9hImg, d9X, d9Y, 3);
[sImg95] = sCorner(grayG9hImg, d9X, d9Y, 5);
%1.D
[nsImg33D] = nonMaxSup(sImg33, dirG3hImg, 3);
[nsImg35D] = nonMaxSup(sImg35, dirG3hImg, 3);
[nsImg93D] = nonMaxSup(sImg93, dirG9hImg, 3);
[nsImg95D] = nonMaxSup(sImg95, dirG9hImg, 3);
figure('Name', 'nsImg33D', 'NumberTitle', 'off');imshow(plotCorner(nImg, nsImg33D));
imwrite(plotCorner(nImg, nsImg33D), 'result/nsImg33D.png');
figure('Name', 'nsImg35D', 'NumberTitle', 'off');imshow(plotCorner(nImg, nsImg35D));
imwrite(plotCorner(nImg, nsImg35D), 'result/nsImg35D.png');
figure('Name', 'nsImg93D', 'NumberTitle', 'off');imshow(plotCorner(nImg, nsImg93D));
imwrite(plotCorner(nImg, nsImg93D), 'result/nsImg93D.png');
figure('Name', 'nsImg95D', 'NumberTitle', 'off');imshow(plotCorner(nImg, nsImg95D));
imwrite(plotCorner(nImg, nsImg95D), 'result/nsImg95D.png');
fprintf('Part 1. E. finished\n');
%% Part 1. F.
roImg = imrotate(oImg, 30);
scImg = imresize(oImg, 0.5);
%rotate 30 degree
g9hImg = imfilter(roImg, gaussian_5s9h);
grayG9hImg = rgb2gray(g9hImg);
[magG9hImg, d9X, d9Y, dirG9hImg] = SobelMask(grayG9hImg);
[sImg95] = sCorner(grayG9hImg, d9X, d9Y, 5);
[nsImg95D] = nonMaxSup(sImg95, dirG9hImg, 3);
figure('Name', 'roImg', 'NumberTitle', 'off');imshow(plotCorner(roImg, nsImg95D));
imwrite(plotCorner(roImg, nsImg95D), 'result/roImg.png');
%scale to 0.5
g9hImg = imfilter(scImg, gaussian_5s9h);
grayG9hImg = rgb2gray(g9hImg);
[magG9hImg, d9X, d9Y, dirG9hImg] = SobelMask(grayG9hImg);
[sImg95] = sCorner(grayG9hImg, d9X, d9Y, 5);
[nsImg95D] = nonMaxSup(sImg95, dirG9hImg, 3);
figure('Name', 'scImg', 'NumberTitle', 'off');imshow(plotCorner(scImg, nsImg95D));
imwrite(plotCorner(scImg, nsImg95D), 'result/scImg.png');
fprintf('Part 1. F. finished\n');
%% Part 2. A. 
oImg1 = imread('data/gasolFace.png');
oImg2 = imread('data/kobeFace.png');
nImg1 = lbp(oImg1);
nImg2 = lbp(oImg2);
figure('Name', 'gasolLbp', 'NumberTitle', 'off');imshow(nImg1);
imwrite(nImg1, 'result/gasolLbp.png');
figure('Name', 'kobeLbp', 'NumberTitle', 'off');imshow(nImg2);
imwrite(nImg2, 'result/kobeLbp.png');
fprintf('Part 2. A. finished\n');
%% Part 2. B.
hist1 = myHist(nImg1, 1);
hist2 = myHist(nImg2, 1);
faceSim = hist1*hist2';
fprintf('face similarity = %f\n',faceSim);
fprintf('Part 2. B. finished\n');
%% Part 2. C.
for i = [2,3,4,9,20]
    hist1 = myHist(nImg1, i);
    hist2 = myHist(nImg2, i);
    faceSim = hist1*hist2';
    fprintf('%2d * %2d cells, face similarity = %f\n', i,i,faceSim);
end
fprintf('Part 2. C. finished\n');
%% Part 2. D. 
table = zeros(1, 256);
label = 1;
for i = 0:255
    index = arrayfun(@str2num, dec2bin(i,8));
    if(nnz(diff(index([1:end, 1]))) <= 2)
        table(i+1) = label;
        label = label + 1;
    else
        table(i+1) = 0;
    end
end
table = uint8(table);
uImg1 = ulbp(nImg1, table);
uImg2 = ulbp(nImg2, table);
figure('Name', 'gasolULbp', 'NumberTitle', 'off');imshow(uImg1);
imwrite(uImg1, 'result/gasolULbp.png');
figure('Name', 'kobeULbp', 'NumberTitle', 'off');imshow(uImg2);
imwrite(uImg2, 'result/kobeULbp.png');
fprintf('Part 2. D. finisehd\n');
%% Part 2. E.
uhist1 = myHist(uImg1, 1);
uhist2 = myHist(uImg2, 1);
ufaceSim = uhist1*uhist2';
fprintf('uniform LBP face similarity = %f\n',ufaceSim);
fprintf('Part 2. E. finished\n');
%% Part 2. F.
for i = [2,3,4,9,20]
    uhist1 = myHist(uImg1, i);
    uhist2 = myHist(uImg2, i);
    ufaceSim = uhist1*uhist2';
    fprintf('uniform LBP %2d * %2d cells, face similarity = %f\n', i,i,ufaceSim);
end
fprintf('Part 2. F. finished\n');