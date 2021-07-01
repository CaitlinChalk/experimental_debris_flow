function PIV = flipFlowDirection(PIV)

no_dirs = length(fieldnames(PIV));
dir_names =  fieldnames(PIV);

for i = 1:no_dirs
    dirName = dir_names{i};
    PIV.(dirName).U = -fliplr(PIV.(dirName).U);
end
