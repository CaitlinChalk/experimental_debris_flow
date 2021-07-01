% plots the velocity profile at a given x coordinate 
%First, plots of the velocity/normalised velocity against height
%Then with the frictional/viscous, and mu(I) rehology scaling laws

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


%% Normalised velocity profiles

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

tplot = [1,1.2,1.4,1.6,2.2,2.4]; %select times to plot
symbols = ['o','x','^','>','v','p'];
colours = {'#003f5c','#2f4b7c','#665191','#a05195','#d45087','#f95d6a','#ff7c43','#ffa600'};
close all
fig1 = plotVelocity(PIV_flow_out,parameters,tplot,symbols,colours,1,0);

%% dimensional plots - Figure 9a
%run 1
tplot = [0.6,0.8,1,1.2,1.4,1.6,2.2,2.4,2.8]; %select times to plot
parameters.runname = 'run1';
symbols = ['o','<','*','x','^','>','v','p','s'];
colours = {'k','#003f5c','#2f4b7c','#665191','#a05195','#d45087','#f95d6a','#ff7c43','#ffa600'};
close all
fig2 = plotVelocity(PIV_flow_out,parameters,tplot,symbols,colours,0,0);
xlim([-0.5 1.3])
ylim([0 0.011])
set(legend,'Location','West')
title('Run 1', 'Interpreter','Latex','FontSize',16)

%saveas(gcf,'Figures/vel_profiles.jpeg')
%
%SaveFigureWin(gcf,12,12,'fig9a1.pdf')

% run 2
parameters.runname = 'run2';
fig2 = plotVelocity(PIV_flow_out,parameters,tplot,symbols,colours,0,0);
title('Run 2', 'Interpreter','Latex','FontSize',16)
legend off
xlim([-0.5 1.3])
ylim([0 0.011])

%SaveFigureWin(gcf,12,12,'fig9a2.pdf')

% run 3
parameters.runname = 'run3';
fig3 = plotVelocity(PIV_flow_out,parameters,tplot,symbols,colours,0,0);
title('Run 3', 'Interpreter','Latex','FontSize',16)
legend off
xlim([-0.5 1.3])
ylim([0 0.011])

%SaveFigureWin(gcf,12,12,'fig9a3.pdf')

%% normalised velocity plots - Figure 9b
%run 1
close all
parameters.runname = 'run1';
tplot = [0.6,0.8,1,1.2,1.4,1.6,2.2,2.4,2.8]; %select times to plot
symbols = ['o','<','*','x','^','>','v','p','s'];
colours = {'k','#003f5c','#2f4b7c','#665191','#a05195','#d45087','#f95d6a','#ff7c43','#ffa600'};
close all
fig = plotVelocity(PIV_flow_out,parameters,tplot,symbols,colours,1,0);
axis([-0.35 1.05 0 1.05])
set(legend,'Location','West')
title('Run 1', 'Interpreter','Latex','FontSize',16)
legend off

%SaveFigureWin(gcf,12,12,'fig9b1.pdf')

% run 2
parameters.runname = 'run2';
fig2 = plotVelocity(PIV_flow_out,parameters,tplot,symbols,colours,1,0);
title('Run 2', 'Interpreter','Latex','FontSize',16)
legend off
axis([-0.35 1.05 0 1.05])

%SaveFigureWin(gcf,12,12,'fig9b2.pdf')

% run 3
parameters.runname = 'run3';
fig3 = plotVelocity(PIV_flow_out,parameters,tplot,symbols,colours,1,0);
title('Run 3', 'Interpreter','Latex','FontSize',16)
legend off
axis([-0.35 1.05 0 1.05])

%SaveFigureWin(gcf,12,12,'fig9b3.pdf')



%% plot with viscous and granular scaling (Figure 12)

tplot = [1,1.2,1.4,1.6,2.2,2.4]; %select times to plot
t_tf = ismember(t,tplot);
tplot_names = names(t_tf); %get the field names corresponding to the times each one is being plot  

symbols = ['o','x','^','>','v','p']; %corresponding symbols for each
n2 = length(tplot); %number of times being plotted

U2 = cell(1,n2);
Y2 = cell(1,n2);

vel_profiles = 1;

if vel_profiles
    legend_entry = cell(1,n2+2);
else
    legend_entry = cell(1,n2);
end
    
yshift = 0.0015;

close all
figure; hold on
for i = 1:n2
    U2{i} = PIV_flow_out.(tplot_names{i}).(runname).U(:,xindex);
    Y2{i} = PIV_flow_out.(tplot_names{i}).(runname).Y(:,xindex)-yshift; 
    h = PIV_flow_out.(tplot_names{i}).(runname).h - yshift;
    legend_entry{i} = [num2str(tplot(i)) ' s'];
    [U_norm,Y_norm] = normaliseVel(U2{i},Y2{i},h);    
    scatter(U_norm,Y_norm,50,symbols(i))
end

if vel_profiles
    % viscous and granular fit
    yfit = linspace(0,1,100);
    c1 = 1;
    ufit_gran = c1.*(1 - (1-yfit).^(3/2));
    c2 = 1;
    ufit_visc = c2.*(1 - (1-yfit).^2);
    plot(ufit_gran,yfit,'k','Linewidth',1.25)
    legend_entry{n2+1} = "granular fit";
    plot(ufit_visc,yfit,'k--','Linewidth',1.25)
    legend_entry{n2+2} = "viscous fit";
end
    
legend(legend_entry,'Location','NorthWest','Interpreter','Latex','FontSize',12);
axis([0 1.1 0 1.1])

xlabel("$u_x/u_{max}$",'Interpreter','Latex','FontSize',12)
ylabel("$y/H$",'Interpreter','Latex','FontSize',12)

axis square
box on

%saveas(gcf,'Figures/vel_scaling.jpeg')

%SaveFigureWin(gcf,10,10,'fig11.pdf')

%granular fit: u(y) = c1(H^3/2 - (H-y)^3/2)
%viscous fit: u(y) = c2(H^2 - (H-y)^2)
%NOTE - error spotted beneath fig 11 in paper, u_x or u?

%% mu(I) rheology scaling - Figure 13


rho = 1373.3;
theta = 31;
d = 0.001*0.917; %grain size (m);

close all
fig1 = figure(1);
%set(fig1, 'Units', 'centimeters');
fig1.Position = [500 500 1200 400];
for i = 1:n2
    U = PIV_flow_out.(tplot_names{i}).(runname).U(:,xindex);
    Y2 = PIV_flow_out.(tplot_names{i}).(runname).Y(:,xindex)-yshift;     
    h = PIV_flow_out.(tplot_names{i}).(runname).h - yshift;
    [shear_rate,shear_rateD] = calcShearRate(U,dy,h);
    pressure = calcPressure(rho,theta,h,Y2);
    %I = (shear_rateD.*d)./((pressure(2:end)./rho).^0.5);
    I = (shear_rate.*d)'./((pressure(2:end)./rho).^0.5);
    A = (2/3).*I.*(cos(theta))^0.5;
    UmuI = (((9.81*d)^0.5)/(d^(3/2))).*A.*(h^(3/2) - (h - Y2(2:end)).^(3/2));  
    figure(1);
    subplot(1,n2,i); hold on
    plot(U,Y2,'-or','Linewidth',1.25)
    plot(UmuI,Y2(2:end),'-k','Linewidth',1.25)
    %plot(I,Y2(2:end),'g','Linewidth',1.25)
    title([num2str(tplot(i)) ' s'],'Interpreter','Latex','FontSize',14)
    xlim([min(UmuI) max(U)+0.1])
    if i == 1
        xlabel("$u_x$ (ms$^{-1}$)",'Interpreter','Latex','FontSize',12)
        ylabel("$y$ (m)",'Interpreter','Latex','FontSize',12)        
        xlim([-2 1.5])
    end
    hax = gca;
    box on
    hax.YAxis.Exponent = 0;
    hax.FontSize = 10;
    ylim([0 max(Y2)+0.0005])
end

saveas(gcf,'Figures/vel_scaling2.jpeg')

%SaveFigureWin(gcf,25,7,'new_fig.pdf')
%pressure








function [U_norm,Y_norm] = normaliseVel(U,Y,h)
    U_norm = U./max(U);
    Y_norm = Y./h;
end