%% Normalised velocity profiles
function fig = plotVelocity(PIV_flow_out,parameters,tplot,symbols,colours,norm,vel_profiles)

t = parameters.t;
names = parameters.names;
xindex = parameters.xindex;
runname = parameters.runname;

t_tf = ismember(t,tplot);
tplot_names = names(t_tf); %get the field names corresponding to the times each one is being plot  

n2 = length(tplot); %number of times being plotted

yshift = 0.0015;

if vel_profiles
    legend_entry = cell(1,n2+2);
else
    legend_entry = cell(1,n2);
end
    
figure; hold on
for i = 1:n2
    U = PIV_flow_out.(tplot_names{i}).(runname).U(:,xindex);
    Y = PIV_flow_out.(tplot_names{i}).(runname).Y(:,xindex)-yshift; 
    h = PIV_flow_out.(tplot_names{i}).(runname).h - yshift;
    legend_entry{i} = [num2str(tplot(i)) ' s'];
    if norm
        [U_norm,Y_norm] = normaliseVel(U,Y,h);    
        %scatter(U_norm,Y_norm,50,symbols(i))
        plot(U_norm,Y_norm,['-' symbols(i)],'LineWidth',1.25,'Color',colours{i})
    else
        plot(U,Y,['-' symbols(i)],'LineWidth',1.25,'Color',colours{i})
    end
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
    
legend(legend_entry,'Location','NorthWest','Interpreter','Latex','FontSize',14);

if norm
    xlabel("$u_x/u_{max}$",'Interpreter','Latex','FontSize',22)
    ylabel("$y/H$",'Interpreter','Latex','FontSize',22)
    %axis([0 1.1 0 1.1])
else
    xlabel("$u_x$ (m s$^{-1}$)",'Interpreter','Latex','FontSize',22)
    ylabel("$y$ (m)",'Interpreter','Latex','FontSize',22)
end

axis square
box on

hax = gca;
hax.YAxis.Exponent = 0;
hax.FontSize = 14;

fig = gcf;

end


function [U_norm,Y_norm] = normaliseVel(U,Y,h)
    U_norm = U./max(U);
    Y_norm = Y./h;
end