load 'data/PIV_flow'

names = fieldnames(PIV_flow_out);
tf = ismember(names,'parameters');
names = names(~tf);

n = length(names);

run = 1;
runname = ['run' num2str(run)];

%% extract actual times

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

%% plots
% tplot = [0.6,0.8]; %select times to plot
% symbols = ['o','<']; %corresponding symbols for each time
% colours = {'#003f5c','#003f5c'};
% 
% tplot2 = [1,1.2,1.4,2.2,2.4,2.8]; %select times to plot
% symbols2 = ['*','x','^','>','v','p','s']; %corresponding symbols for each time

tplot = [0.6,0.8,1,1.2,1.4,2.2,2.4,2.8];
symbols = ['o','<','*','x','^','>','v','p','s'];
%colours = {'#004c6d','#046284','#0b799b','#1590b1','#22a9c6','#31c2da','#43dbed','#58f5ff'}; %blues
colours = {'#003f5c','#2f4b7c','#665191','#a05195','#d45087','#f95d6a','#ff7c43','#ffa600'};

close all
%dimensional plot
fig1 = plotShear(PIV_flow_out,parameters,tplot,symbols,colours,0);
xlim([-600 760])
%SaveFigureWin(fig1,12,12,'shear_new.pdf')

%% dimensionless plot
fig2 = plotShear(PIV_flow_out,parameters,tplot,symbols,colours,1);
%legend off;
legend boxon
xlim([-5 5]) %[-60 80]
%SaveFigureWin(fig2,12,12,'shear_nd_new.pdf')

%%
fig2;
legend off
xlim([-60 80])
pbaspect([1 2 1])
%SaveFigureWin(fig2,12,12,'shear_nd_new2.pdf')





