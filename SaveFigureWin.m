function [] = SaveFigureWin(fig1, Lx, Ly, name)
% SaveFigure(fig1, Lx, Ly, filename(string) )
path = pwd;
savePath = [path, '\Figures'];
if exist(savePath) == 0 %#ok<EXIST>
    mkdir(savePath);
    fprintf('Figures directory has been created \n');
end

set(fig1, 'PaperPosition', [0 0 Lx Ly]); %Position plot at left hand corner with width Lxy and height Lxy.
set(fig1, 'PaperSize', [Lx Ly]);         %Set the paper to have width Lxy and height Lxy.
saveas(fig1, [savePath,'\',name], 'pdf') %Save figure
fprintf(['Figure ', name, ' succesfully saved ! \n']);
end