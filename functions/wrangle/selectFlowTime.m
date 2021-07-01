function PIV2 = selectFlowTime(PIV, time_out)
%returns data at specified time, and the corresponding jpeg path
%name

no_dirs = length(fieldnames(PIV));
dir_names =  fieldnames(PIV);

for i = 1:no_dirs
    dirName = dir_names{i};
    PIV2.(dirName).time = time_out;
    PIV2.(dirName).X = PIV.(dirName).X; 
    PIV2.(dirName).Y = PIV.(dirName).Y; 
    time_i = abs(PIV.(dirName).time - time_out);
    [~, idx] = min(time_i);
    t_index = idx;
    frame = num2str(PIV.(dirName).jpeg(t_index),'%05.f');
    jpeg_name = ['data\jpegs\' dirName '\fine' num2str(i) frame '.jpg'];
    PIV2.(dirName).jpeg = string(jpeg_name);
    PIV2.(dirName).U_average = PIV.(dirName).U_average(:,:,t_index);
    PIV2.(dirName).V_average = PIV.(dirName).V_average(:,:,t_index);
    PIV2.(dirName).SD = PIV.(dirName).SD(:,:,t_index);
end
