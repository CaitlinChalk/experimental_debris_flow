% plots the shear profiles at a given x coordinate 

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

%% extract actual times from field names

t = nan(1,n);
for i = 1:n
   t(i) = PIV_flow_out.(names{i}).(runname).t; %array of actual flow times
end

X = PIV_flow_out.(names{1}).(runname).X;
Y0 = PIV_flow_out.(names{1}).(runname).Y;
dy = Y0(2,1) - Y0(1,1);
%xindex = round(length(X)/2);
xplot = 0.01; %round(X/2);
[~,xindex] = min(abs(X(1,:) - xplot)); 

parameters.t = t;
parameters.names = names;
parameters.xindex = xindex;
parameters.runname = runname;

%% dimensional plot - Figure 11 a

tplot = [0.6,0.8,1,1.2,1.4,2.2,2.4,2.8];
symbols = ['o','<','*','x','^','>','v','p','s'];
colours = {'#003f5c','#2f4b7c','#665191','#a05195','#d45087','#f95d6a','#ff7c43','#ffa600'};

close all
%dimensional plot
fig1 = plotShear(PIV_flow_out,parameters,tplot,symbols,colours,0);
xlim([-600 760])
%SaveFigureWin(fig1,12,12,'shear_new.pdf')
saveas(gcf,'Figures/shear.jpeg');

%% dimensionless plots - Figure 11 b (xlim = [-5 5]), and 11 c (xlim = [-60 80])
fig2 = plotShear(PIV_flow_out,parameters,tplot,symbols,colours,1);
%legend off;
legend boxon
xlim([-5 5]) %[-60 80]
%SaveFigureWin(fig2,12,12,'shear_nd_new.pdf')







