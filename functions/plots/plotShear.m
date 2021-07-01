%function to plot shear rate against height at specified times
function fig = plotShear(PIV_flow_out,parameters,tplot,symbols,colours,norm)

    t = parameters.t;
    names = parameters.names;
    xindex = parameters.xindex;
    runname = parameters.runname;

    t_tf = ismember(t,tplot);
    tplot_names = names(t_tf); %get the field names corresponding to the times each one is being plot  

    n2 = length(tplot); %number of times being plotted

    yshift = 0.0015;

    legend_entry = cell(1,n2);

    
    figure; hold on
    for i = 1:n2
        U = PIV_flow_out.(tplot_names{i}).(runname).U(:,xindex);
        Y = PIV_flow_out.(tplot_names{i}).(runname).Y(:,xindex)-yshift;         
        dy = Y(2,1) - Y(1,1);
        h = PIV_flow_out.(tplot_names{i}).(runname).h - yshift;
        [shear_rate,~] = calcShearRate(U,dy,h);
        if norm == 1
            [shear_norm, Y_norm] = normaliseShear(shear_rate,Y,h,U);
            if i == 1
                plot(shear_norm,Y_norm(2:end),['--' symbols(i)],'LineWidth',1,'Color',colours{i})
            else
                plot(shear_norm,Y_norm(2:end),['-' symbols(i)],'LineWidth',1.25,'Color',colours{i})
            end 
        else
            if i == 1
                plot(shear_rate,Y(2:end),['--' symbols(i)],'LineWidth',1.25,'Color',colours{i})
            else
                plot(shear_rate,Y(2:end),['-' symbols(i)],'LineWidth',1.25,'Color',colours{i})
            end
        end
        legend_entry{i} = [num2str(tplot(i)) ' s'];
%         Y2{i} = Y;
%         shear_rate2{i} = shear_rate;
    end

    legend(legend_entry,'Location','NorthEast','Interpreter','Latex','FontSize',12);
    
    if norm == 1
        xlabel("$\dot{\gamma}/\bar{\dot{\gamma}}$ ",'Interpreter','Latex','FontSize',16)
        ylabel("$y/H$",'Interpreter','Latex','FontSize',16)         
        ylim([0 1.1])
%         axes('Position',[6,6,.1,.4])
%         box on
%         plot(shear_rate2,Y2)
    else
        xlabel("$\dot{\gamma}$ (s$^{-1}$)",'Interpreter','Latex','FontSize',16)
        ylabel("$y$ (m)",'Interpreter','Latex','FontSize',16)
        ylim([0 0.0115])
    end
        
    axis square
    box on
    %legend boxoff
    hax = gca;
    hax.YAxis.Exponent = 0;
    hax.FontSize = 12;
    
    fig = gcf;
end


function [shear_norm,Y_norm] = normaliseShear(gamma,Y,h,U)
    A = h/(U(end) - U(1));
    Y_norm = Y./h;
    shear_norm = gamma.*A;
end


