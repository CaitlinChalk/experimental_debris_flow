%% wrangles PIV data prior to analysis

close 
clear
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

close all
figure
plotVectors3(A,PIV_snap,run,parameters,1)
title(['t = ' num2str(t) ' s']);

%% Decide where to crop all PIV data (i.e. chop off the bits that never have
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

%save geometry and cropping info parameters 
parameters.pix1 = pix1;
parameters.y_upper = y_upper;
parameters.y_lower = y_lower;


%% Crop data to correspond with the flow free surface at different times

%define times of interest
t = [0.035,0.07,0.3,0.6,0.8,1,1.2,1.4,1.6,2.2,2.4,2.8]; 
%this function asks the user to click on the approximate flow free surface
PIV_flow_out = selectFreeSurface(PIV,t,parameters);

%% check that crop worked 

PIV_snap = PIV_flow_out.t5;
A = PIV_snap.run1.jpeg;
close all
imshow(A);
close all
plotVectors3(A,PIV_snap,1,parameters,1)


%% save wrangled data to file
save('data/PIV_flow','PIV_flow_out') 











