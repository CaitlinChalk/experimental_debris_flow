function PIV_flow_out = selectFreeSurface(PIV,t,parameters)
%crops PIV data to match the free surface in the flow snapshot at specified
%times
%input - PIV - PIV data
%         t - specific flow times to examine
%         parameters - contains geometry info such as the value of 1 pixel
%         in metres
%output - PIV_flow_out - PIV data at specified times t, cropped to
%          correspond to the flow free surface

% pix1 = parameters.pix1;
% Ay_m = parameters.height;
% y_upper = parameters.y_upper;
% y_lower = parameters.y_lower;

%crop the PIV data 
%PIV_crop = cropFlow(PIV,y_upper,y_lower);

PIV_flow_out = struct; 

for j = 1:3
    run_name = ['run' num2str(j)];

    nt = length(t);    
    hMetres = NaN(nt,1);
    for i = 1:nt
        PIV_snap = selectFlowTime(PIV,t(i)); %extract flow data at time t
        A = imread(PIV_snap.(run_name).jpeg);
        A = fliplr(A);
       % Acrop = cropImage(A, Ay_m, y_upper, y_lower);
       % parameters.height = y_upper - y_lower;
        close all
        plotVectors3(A,PIV_snap,j,parameters,1)
        title(['t = ' num2str(t(i)) ' s']);
        disp('Click on the point corresponding to flow free surface, press Enter to confirm');
        % Save points selected on plot by user
        [user_selection] = ginput;
        hMetres(i) = user_selection(2);
        %hMetres(i) = pixToMaterialY(hPixels,pix1,size(A,1));

        %crop data and plot to check that it is an appropriate free surface
        %estimation
        PIV_flow = cropFlow(PIV_snap,hMetres(i),0);   
        %save data at specified times to PIV_flow_out
        t_name = ['t' num2str(i)];
        PIV_flow_out.(t_name).(run_name).U = PIV_flow.(run_name).U_average;
        PIV_flow_out.(t_name).(run_name).V = PIV_flow.(run_name).V_average;
        PIV_flow_out.(t_name).(run_name).X = PIV_flow.(run_name).X;
        PIV_flow_out.(t_name).(run_name).Y = PIV_flow.(run_name).Y;
        PIV_flow_out.(t_name).(run_name).SD = PIV_flow.(run_name).SD;
        PIV_flow_out.(t_name).(run_name).jpeg = A;
        PIV_flow_out.(t_name).(run_name).h = hMetres(i);
        PIV_flow_out.(t_name).(run_name).t = t(i);
        PIV_flow_out.parameters = parameters; %save cropping parameters
    end

end