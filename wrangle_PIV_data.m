%% This script time averages and tidies up the raw PIV data
clear 
close

%add path to folders containing functions used here
addpath('functions','functions/plots','functions/wrangle')

%raw data has been preloaded into a .mat file:
load 'data/PIV_data'

%% flip the horizontal axis direction of the data (so x increases from left to right)
PIV = flipFlowDirection(PIV_data);

%% time average the raw velocity data over 30 time frames (also computes standard deviation)
PIV_filter = timeAverage(PIV,30);

%% shift and crop 
%shift so that t = 0 corresponds to when the flow front hits the camera
PIV = correctStartTime(PIV_filter); 

%% define width and height of camera field of view here
%dimensions of one pixel (determined by inspecting the image in
%pixel_info.m)
pix1 = 0.01/300; % 1 pixel = 0.01/300 m

%load and show any jpeg image from the PIV data
t = 0.8; %select any snapshot to look at (t= 0.3 approximately corresponds to time time of maximum flow height)
%Note that online images are only available for the following times: t = [0.035,0.07,0.3,0.6,0.8,1,1.2,1.4,1.6,2.2,2.4,2.8]; 
%select run to look at (run 1,2 or 3)
run = 1;
run_name = ['run' num2str(run)];

PIV_snap = selectFlowTime(PIV,t); %extract flow data at time t
%plot image
A = imread(PIV_snap.(run_name).jpeg);
A = fliplr(A);
A2 = flipud(A);
% close all
% imshow(A)
%
title(['t = ' num2str(t) ' s']);
%get image size in pixels, and convert to metres
nrow = size(A,1); %number of rows of A = y in pixels
ncol = size(A,2); %number of columns of A = x in pixels
Ax_m = ncol*pix1; %x in metres
Ay_m = nrow*pix1; %y in metres
width = Ax_m; 
height = Ay_m; 

%save geometry parameters 
parameters.width = width;
parameters.height = height;
parameters.dx1 = 1;
parameters.dx2 = 1;
parameters.ref_arrow = 0;
parameters.pix1 = pix1;

%plots flow image with data overlain (uncropped)
close all
figure
plotVectors(A,PIV_snap,run,parameters,1)
title(['t = ' num2str(t) ' s']);


%% Play with cropping the camera images (not required for next steps, but left here anyway)
% any flow)
%define limits to crop all PIV data
y_upper = 0.02;
y_lower = 0.001;
height2 = y_upper - y_lower;
%plot cropped image at time t
Acrop = cropImage(A, Ay_m, y_upper, y_lower);
close all
imshow(Acrop) %examine the cropped flow image
title(['t = ' num2str(t) ' s']);


%% Crop data to correspond with the flow free surface at different times

%define times of interest
t = [0.035,0.07,0.3,0.6,0.8,1,1.2,1.4,1.6,2.2,2.4,2.8]; 

%store corresponding jpeg names to save these images
jpeg_keep = cell(length(t),1);
for i = 1:length(t)
    PIV_snap = selectFlowTime(PIV,t(i)); %extract flow data at time t
    jpeg_keep{i} = PIV_snap.run1.jpeg;
end

%%
%this function asks the user to click on the approximate flow free surface
%and returns the PIV data cropped at that value (the free surface is
%approximated as a straight line
PIV_flow_out = selectFreeSurface(PIV,t,parameters);

%% check that the crop worked 

PIV_snap = PIV_flow_out.t5;
A = PIV_snap.run1.jpeg;
close all
imshow(A);
close all
plotVectors(A,PIV_snap,1,parameters,1)


%% save wrangled data to file
save('data/PIV_flow','PIV_flow_out') 











