% % %% clear and read image
% % clc;clear;close all;
% % oImg = imread('data/J4Poro.png');
% % imshow(oImg);
% % %% Define Color Map
% % % The hsvMap will mapping value 0 ~ 1 to custom color space
% % hsvMap = linspace( 0, 1, 99 )' ;
% % hsvMap(:, 2) = 0.5;
% % hsvMap(:, 3) = 1;
% % rgbMap = hsv2rgb(hsvMap);
% % rgbMap = [ 0.2 0.2 0.2 ; rgbMap ];
% % %% Part 1. A. gaussian filter with kernel size 3x3 and 9x9
% % gaussian_5s3h = fspecial('gaussian', 3, 5);
% % g3hImg = imfilter(oImg, gaussian_5s3h);
% % gaussian_5s9h = fspecial('gaussian', 9, 5);
% % g9hImg = imfilter(oImg, gaussian_5s9h);
% % fprintf('Part 1. A. finished\n');
% % %% Part 1. B. Apply sobel masks and find magnitude and direction
% % grayG3hImg = rgb2gray(g3hImg);
% % [magG3hImg, d3X, d3Y, dirG3hImg] = SobelMask(grayG3hImg);
% % grayG9hImg = rgb2gray(g9hImg);
% % [magG9hImg, d9X, d9Y, dirG9hImg] = SobelMask(grayG9hImg);
% % % figure;imshow(magG3hImg);
% % % figure;imshow(dirPi2One(dirG3hImg), 'ColorMap', rgbMap);
% % % figure;imshow(magG9hImg);
% % % figure;imshow(dirPi2One(dirG9hImg), 'ColorMap', rgbMap);
% % fprintf('Part 1. B. finished\n');
% % %% Part 1. C. construct small eigen value of H matrix
% % [sImg33] = sCorner(grayG3hImg, d3X, d3Y, 3);
% % [sImg35] = sCorner(grayG3hImg, d3X, d3Y, 5);
% % [sImg93] = sCorner(grayG9hImg, d9X, d9Y, 3);
% % [sImg95] = sCorner(grayG9hImg, d9X, d9Y, 5);
% % % figure;imshow(sImg33);
% % % figure;imshow(sImg35);
% % % figure;imshow(sImg93);
% % % figure;imshow(sImg95);
% % fprintf('Part 1. C. finished\n');
% %% Part 1. D. 
% % [nsImg33] = nonMaxSup(sImg33, dirG3hImg);
% % [nsImg35] = nonMaxSup(sImg35, dirG3hImg);
% % [nsImg93] = nonMaxSup(sImg93, dirG9hImg);
% [nsImg95] = nonMaxSup(sImg95, dirG9hImg);
% % figure;imshow(plotCorner(oImg, nsImg33));
% % figure;imshow(plotCorner(oImg, nsImg35));
% % figure;imshow(plotCorner(oImg, nsImg93));
% figure;imshow(plotCorner(oImg, nsImg95));
% fprintf('Part 1. D. finished\n');
% % %% Part 1. E. rotate 30 degree and scale to 0.5x, then apply 1.A to 1.D
% % nImg = imrotate(oImg, 30);
% % nImg = imresize(nImg, 0.5);
% % %1.A
% % gaussian_5s3h = fspecial('gaussian', 3, 5);
% % g3hImg = imfilter(oImg, gaussian_5s3h);
% % gaussian_5s9h = fspecial('gaussian', 9, 5);
% % g9hImg = imfilter(oImg, gaussian_5s9h);
% % %1.B
% % grayG3hImg = rgb2gray(g3hImg);
% % [magG3hImg, d3X, d3Y, dirG3hImg] = SobelMask(grayG3hImg);
% % grayG9hImg = rgb2gray(g9hImg);
% % [magG9hImg, d9X, d9Y, dirG9hImg] = SobelMask(grayG9hImg);
% % %1.C
% % [sImg33] = sCorner(grayG3hImg, d3X, d3Y, 3);
% % [sImg35] = sCorner(grayG3hImg, d3X, d3Y, 5);
% % [sImg93] = sCorner(grayG9hImg, d9X, d9Y, 3);
% % [sImg95] = sCorner(grayG9hImg, d9X, d9Y, 5);
% % %1.D
% % [nsImg33] = nonMaxSup(sImg33, dirG3hImg);
% % [nsImg35] = nonMaxSup(sImg35, dirG3hImg);
% % [nsImg93] = nonMaxSup(sImg93, dirG9hImg);
% % [nsImg95] = nonMaxSup(sImg95, dirG9hImg);
% % figure;imshow(plotCorner(oImg, nsImg33));
% % figure;imshow(plotCorner(oImg, nsImg35));
% % figure;imshow(plotCorner(oImg, nsImg93));
% % figure;imshow(plotCorner(oImg, nsImg95));
% fprintf('Part 1. E. finished\n');
% %% Part 1. F.
% fprintf('Part 1. F. finished\n');
%% Part 2. A. 
oImg1 = imread('data/gasolFace.png');
%oImg2 = imread('data/kobeFace.png');
figure;imshow(oImg);
[nImg, his] = lbp(oImg);
figure;imshow(nImg);
figure;bar(0:255, his);axis([0, 255, 0, max(his)]);
set(gca, 'position', [0.1 0.1 0.8 0.4]);
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
