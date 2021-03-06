%plots flow contours of either velocity or standard deviation

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

%% velocity contours - Figure 8
close all
for i = 1:length(tplot)
    plotContour(PIV_flow_out,parameters,tplot(i),0,0);
    title(['t = ' num2str(tplot(i)) ' s'], 'Interpreter','Latex','FontSize',20)
    iterName = ['vel_' num2str(i)];
    %SaveFigureWin(gcf,15,15,iterName)
end

%% standard deviation contours

close all
for i = 1:length(tplot)
    plotContour(PIV_flow_out,parameters,tplot(i),1,0);
    title(['t = ' num2str(tplot(i)) ' s'], 'Interpreter','Latex','FontSize',20)
    iterName = ['sd_' num2str(i)];
    %SaveFigureWin(gcf,15,15,iterName)
end

%% normalised standard deviation contours

close all
for i = 1:length(tplot)
    plotContour(PIV_flow_out,parameters,tplot(i),1,1);
    title(['t = ' num2str(tplot(i)) ' s'], 'Interpreter','Latex','FontSize',20)
    iterName = ['sd_b50' num2str(i)];
    SaveFigureWin(gcf,15,15,iterName)
end