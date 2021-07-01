function PIV = correctStartTime(PIV)

%corrects start time in corresponding data column stored in PIV,
%so that t = 0  corresponds to the time when the flow front reached the
%camera field of view

dir_names = fieldnames(PIV);

%subtract the minimum from each time
for i = 1:length(dir_names)    
    time0 = PIV.(dir_names{i}).time; %store original time reference
    PIV.(dir_names{i}).jpeg = time0*1200; %save frame number of corresponding jpeg
    time2 = time0 - min(time0);
    PIV.(dir_names{i}).time = time2;
end