%plots the PIV vectors on top of the camera images

%add path to folders containing functions used here
addpath('functions','functions/plots','functions/wrangle')

%load wrangled data at specific times
load 'data/PIV_flow'

%get names of each field, corresponding to a snapshot in time
names = fieldnames(PIV_flow_out);
tf = ismember(names,'parameters');
names = names(~tf);

n = length(names);

%select experimental run (1,2 or 3)
run = 1;
runname = ['run' num2str(run)];

%% extract actual times

t = nan(1,n);
for i = 1:n
   t(i) = PIV_flow_out.(names{i}).(runname).t; %array of actual flow times
end

parameters.t = t;
parameters.names = names;
parameters.runname = runname;

tplot = [0.035,0.07,0.3,0.6,0.8,1.2,1.6,2.8]; %select times to plot

%% flow images with arrows on top

width = 0.0427;
height = 0.0267;

parameters.width = width;
parameters.height = height;
parameters.dx1 = 2;
parameters.dx2 = 8;
parameters.ref_arrow = 1;


close all

for i = 1:length(tplot)
    t_tf = ismember(t,tplot(i));
    tplot_names = names(t_tf);

    PIV_snap = PIV_flow_out.(tplot_names{1});
    A = PIV_snap.(runname).jpeg;

    % PIV vectors
    plotVectors(A,PIV_snap,1,parameters,0)
    ylim([0.0015 0.02])
    width_plot = 15;
    height_plot = width_plot/(width/height);
    set(gcf, 'units','centimeters','outerposition',[10 10 width_plot height_plot + 2]);  
    axis off
    plot_title = ['t = ' num2str(tplot(i)) ' s'];
    title(plot_title,'Interpreter', 'latex','FontSize',26)
    iterName = ['PIV', mat2str(i)];
    %SaveFigureWin(gcf,15,9,iterName); uncomment to save pdf
    if i == 5
        saveas(gcf,'Figures/vectorPlot.jpeg')
    end
end
















