function fig = plotContour(PIV_flow_out,parameters,tplot,plot_SD,norm)
%input - PIV_flow_out - PIV data
%      - tplot - single time value to plot
%      - parameters - parameters containing info about data in PIV_flow_out
%      - plot_SD - logical, 1 if plotting SD, 0 if plotting velocity 

t = parameters.t;
names = parameters.names;
runname = parameters.runname;

t_tf = ismember(t,tplot);
tplot_names = names(t_tf); %get the field names corresponding to the times each one is being plot  

yshift = 0.0015;

X = PIV_flow_out.(tplot_names{1}).(runname).X;
Y = PIV_flow_out.(tplot_names{1}).(runname).Y-yshift;
U = PIV_flow_out.(tplot_names{1}).(runname).U;
SD = PIV_flow_out.(tplot_names{1}).(runname).SD;

figure;
if ~plot_SD
    contourf(X(:,:),Y(:,:),U(:,:),15,'LineWidth',0.05,'LineColor','none'); %
    xlabel('$x$ (m)','Interpreter', 'latex','FontSize',22)
    ylabel('$y$ (m)','Interpreter', 'latex','FontSize',22)
    colormap(jet)
else
    if norm
        vel_lim = 50;
        Z = abs(SD./U).*100;
        Z2 = (( min(vel_lim, Z)));
        %Z2 = (( min(vel_lim, abs(Z-vel_lim))));
        contourf(X(:,:),Y(:,:),Z2,50,'LineColor','none'); %
        caxis([0 vel_lim]);
        contourcbar;
    else
        Z = SD;
        contourf(X(:,:),Y(:,:),Z,'LineColor','none');
        caxis([0.15 1]);
        contourcbar;
    end
    
    xlabel('$x$ (m)','Interpreter', 'latex','FontSize',22)
    ylabel('$y$ (m)','Interpreter', 'latex','FontSize',22)

end

%caxis([vel_lim 1]);
%c = colorbar;
%c.Label.FontSize = 20;

%caxis([vel_lim 1]);
ylim([0.0015 0.0135])
axis square
box on

fig = gcf;

hax2 = gca;
set(hax2,'FontSize',16);
hax2.YAxis.Exponent = 0;

