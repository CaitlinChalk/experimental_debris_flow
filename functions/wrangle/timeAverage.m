function PIV_average = timeAverage(PIV,nf)

%time averages the PIV velocity
%input - PIV - structure containing raw PIV data to time average
%      - nf - number of frames to average over

%output - PIV_average - new structure containing time-averaged PIV data, along with
%         standard deviation 

format long
%number of data folders (corresponding to different runs)
no_dirs = length(fieldnames(PIV));
dir_names =  fieldnames(PIV);
%time average each frame 
for i = 1:no_dirs
    
    clear time_temp; clear u_temp; clear v_temp
    
    %dir names
    dirName = dir_names{i};
    
    %store raw time and velocities
    time_temp = PIV.(dirName).time;
    u_temp = PIV.(dirName).U;
    v_temp = PIV.(dirName).V;
    
    nan_u = 0;
    nan_v = 0;
    
    %change NaN values to 0
    for l = 1:size(u_temp,1)
        for j = 1:size(u_temp,2)
            for k = 2:floor(length(time_temp))
                if isnan(u_temp(l,j,k))
                    u_temp(l,j,k) = 0; %u_temp(l,j,k-1);
                    nan_u = nan_u + 1;
                end
                if isnan(v_temp(l,j,k))
                    v_temp(l,j,k) = 0; %v_temp(l,j,k-1);
                    nan_v = nan_v + 1;
                end
            end
        end 
    end
    
    %time average u and v velocity components
    n1 = length(time_temp); 
    n1 = n1 - nf;
    k = 1;
    nstart = 16;
    [Nux, Nuy, ~] = size(u_temp);
    time_av = NaN(1, n1);
    u_av = NaN(Nux, Nuy, n1);
    v_av = u_av;
    while k <= n1
        time_av(k) = time_temp(nstart);
        u_av(:,:,k) = (1/nf)*sum(u_temp(:,:,nstart-(nf/2):nstart+(nf/2)), 3);
        v_av(:,:,k) = (1/nf)*sum(v_temp(:,:,nstart-(nf/2):nstart+(nf/2)), 3);
        nstart = nstart+1;
        k=k+1;
    end
    
    %store averaged data in new cell
    PIV_average.(dirName).time = time_av; 
    PIV_average.(dirName).U_average = u_av;
    PIV_average.(dirName).V_average = v_av;
    
    %transfer X,Y to filtered data
    PIV_average.(dirName).X = PIV.(dirName).X;
    PIV_average.(dirName).Y = PIV.(dirName).Y;
    
    %calculate and store standard deviations 
    [Nux2, Nuy2, ~] = size(u_av);
    SD = NaN(Nux2,Nuy2,n1);
    
    k=1;
    nstart=16;
    while k <= n1   
        u_temp2 = u_temp(:,:,nstart-(nf/2.):nstart+(nf/2.)) - u_av(:,:,k);
        u_temp2 = u_temp2.^2;
        SD(:,:,k) = sqrt((sum(u_temp2,3))/(nf-1));
        nstart = nstart+1;
        k=k+1;
    end
   
    PIV_average.(dirName).SD = SD;
        
end