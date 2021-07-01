function plotVectors(A,PIV_snap,run,parameters,Uprof)
%plots PIV vectors on top of flow image
%input - A - flow image
%      - PIV_snap - PIV data at snapshot in time corresponding to A
%      - parameters - geometric parameters
%      - Uprof - logical. If true, plots vertical velocity profile in
%      addition to velocity vectors

run_name = ['run' num2str(run)];

width = parameters.width;
height = parameters.height;
dx1 = parameters.dx1;
dx2 = parameters.dx2;
ref_arrow = parameters.ref_arrow;

X = PIV_snap.(run_name).X;
Y = PIV_snap.(run_name).Y;

var_names = fieldnames(PIV_snap.(run_name));

if sum(ismember(var_names,'U_average')) == 1
    U = PIV_snap.(run_name).U_average; %pick any velocity
    V = fliplr(PIV_snap.(run_name).V_average);
else
    U = PIV_snap.(run_name).U; %pick any velocity
    V = fliplr(PIV_snap.(run_name).V);
end

%close all

xlim = [0 width];
ylim = [0 height];
A2 = flipud(A);

figure
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);   
image(xlim, ylim, A2)
hold on
if ref_arrow
    text(0.02,0.01815,'1 ms$^{-1}$','color','k','FontSize',16,'Interpreter','Latex','BackgroundColor','w','Margin',9)
    hold on
end    
Q = quiver(X(1:dx1:end,[1:dx2:end-1,end]),Y(1:dx1:end,[1:dx2:end-1,end]),U(1:dx1:end,[1:dx2:end-1,end]),V(1:dx1:end,[1:dx2:end-1,end]),1.1,'r','LineWidth',1.25);
if ref_arrow
    hold on
    addrefarrow(Q,0.02,0.0168,1,0);
end
    
set(gca,'YDir','normal')

if Uprof
   xindex1 = round(length(X)/2);
    xplot = 0.01; %round(length(X)/2);
    [~,xindex2] = min(abs(X(1,:) - xplot)); 

    Uprofile = 0.01*U(:,xindex1);
    Uprofile = Uprofile - Uprofile(1) + X(1,xindex1); %shift profile to be in the middle of plot
    Uprofile2 = 0.01*U(:,xindex2);
    Uprofile2 = Uprofile2 - Uprofile2(1) + X(1,xindex2); 
    hold on
    plot(Uprofile,Y(:,xindex1),'k-o','LineWidth',1.25)
    hold on
    plot(Uprofile2,Y(:,xindex2),'k-o','LineWidth',1.25)   
end