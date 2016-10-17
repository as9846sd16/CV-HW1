%clc;clear;close all;
raw_img = imread('GangPoro.png');
load('GangPoroGradients.mat');

%% Define Color Map
% The hsvMap will mapping value 0 ~ 1 to custom color space
hsvMap = linspace( 0, 1, 99 )' ;
hsvMap(:, 2) = 0.5;
hsvMap(:, 3) = 1;
rgbMap = hsv2rgb(hsvMap);
rgbMap = [ 0.2 0.2 0.2 ; rgbMap ];

%% Show Image
figure;
subplot(131);imshow(raw_img);
subplot(132);imshow(GangPoro_Gradient_Magnitude);
subplot(133);imshow(GangPoro_Gradient_Direction);

threshold = 0.2;
GangPoro_Gradient_Direction(GangPoro_Gradient_Magnitude < threshold) = 0;
figure;
imshow(GangPoro_Gradient_Direction,'ColorMap',rgbMap);
