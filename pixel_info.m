scale = 'data/scalefinecoarse.jpg';
A = imread(scale);
%close all
figure
imshow(A);
impixelinfo;

%1cm = 300 pixels
%1 pixel = 1/300 cm = 0.01/300 m