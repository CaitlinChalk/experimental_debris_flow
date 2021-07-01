function PIV = flipFlowDirection(PIV)

no_dirs = length(fieldnames(PIV));
dir_names =  fieldnames(PIV);

for i = 1:no_dirs
    dirName = dir_names{i};
    PIV.(dirName).U = -fliplr(PIV.(dirName).U);
    %PIV.(dirName).U_average = -fliplr(PIV.(dirName).U_average);
%     PIV.(dirName).V_average = fliplr(PIV.(dirName).V_average);
    %PIV.(dirName).SD = -fliplr(PIV.(dirName).SD);
%     %X = fliplr(PIV.(dirName).X);
%     PIV.(dirName).X = fliplr(PIV.(dirName).X);
   %  PIV.(dirName).Y = fliplr(PIV.(dirName).Y) - 0.001; %shift y down by mm to fit image
end
