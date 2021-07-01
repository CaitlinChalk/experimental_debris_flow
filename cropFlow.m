function PIV = cropFlow(PIV,y_crop,y_crop2)

no_dirs = length(fieldnames(PIV));
dir_names =  fieldnames(PIV);   

Y = PIV.(dir_names{1}).Y;
ind = Y < y_crop;
ntop = ind(:,1);
%count no of zeros
n = length(ntop(ntop == 1));

dy = PIV.run1.Y(2,1) - PIV.run1.Y(1,1);

if y_crop2 == 0
    n2 = 1;
else
    n2 = round(y_crop2/dy);
end

for i = 1:no_dirs
    dirName = dir_names{i};
    PIV.(dirName).U_average = PIV.(dirName).U_average(n2:n,:,:);
    PIV.(dirName).V_average = PIV.(dirName).V_average(n2:n,:,:);
    PIV.(dirName).SD = PIV.(dirName).SD(n2:n,:,:);
    PIV.(dirName).X = PIV.(dirName).X(n2:n,:);
    PIV.(dirName).Y = PIV.(dirName).Y(n2:n,:);
end