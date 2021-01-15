% -------------------------------------------------------------------------
%% --------------------------- MLD-figure 10 ------------------------------
% MLD-figure 11 is almost the same, but for 5km; use 'support_file_06.nc';
% -------------------------------------------------------------------------
% install m_map for matlab first
% related-data, 'support_file_05.nc', 'rev-Figure-10.mat'
% NOTE: 'rev-Figure-10.mat' can be calculated using LTRANSv2b files 
% criterions, and mld field directly.

%% directory
DIR = '../data/';

%% read pre-processed data
load([DIR, 'grdfile.mat']);
load([DIR, 'OMG_CM.mat'])
grd = grd1;

filename = [DIR, 'support_file_05.nc'];
mld = ncread(filename, 'mld');

% calculate and save mat file, use LTRANSv2b output and mld above 

% load file to save time
load([DIR, 'rev-Figure-10.mat'], 'DOWN_LAT', 'DOWN_LAT2', 'DOWN_LON', ...
    'DOWN_LON2', 'UP_LAT', 'UP_LAT2', 'UP_LON', 'UP_LON2')

%% pre-defined parameters
minlon = -98; maxlon = -82; minlat = 24; maxlat = 30.5;
bw = [0.4, 0.2];
normFac = 0.0236; % normalization factor, calculated from uniform distribution
color_ = [1 0 0]; 
ids = {'a', 'b', 'c', 'd'};
d_type = {'fixed depth', 'fixed depth', 'cross ML', 'cross ML'};
a_type = {'downwelling', 'upwelling', 'downwelling', 'upwelling'};
lonfiles = {'DOWN_LON', 'UP_LON', 'DOWN_LON2', 'UP_LON2'};
latfiles = {'DOWN_LAT', 'UP_LAT', 'DOWN_LAT2', 'UP_LAT2'};

for i = 1:4
    % assign data variable
    eval(['LON = ', lonfiles{i}, ';'])
    eval(['LAT = ', latfiles{i}, ';'])
    
    % kde calculation and normalizaton
    [cc, ~] = ksdensity([LON,LAT], [LON,LAT], 'Bandwidth', bw);
    c = cc / normFac;
    
    % figure plot
    figure(1)
    s(i) = subplot(2,2,i);
    m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
    m_gshhs_h('color', 'k');
    m_grid('fontname', 'Times New Roman', 'fontsize', 18);
    hold on
    [X1,Y1] = m_ll2xy(LON, LAT);
    scatter(X1, Y1, 3, 'filled', 'cdata', c); 
    m_text(-97.5, 30, ids{i}, 'FontWeight', 'bold', 'Color', 'k',...
        'fontname', 'Times New Roman', 'fontsize', 22)
    m_text(-86, 30.25, d_type{i}, 'Color', color_,...
         'fontname', 'Times New Roman', 'fontsize', 15)
    m_text(-86.7, 29.35, a_type{i}, 'Color', color_,...
         'fontname', 'Times New Roman', 'fontsize', 15) 
    set(gca, 'colorscale', 'log'); 
    set(gcf, 'position', [100, 300, 1400, 500])
    colormap(cm4jet)
    caxis([0.1 7.2]);
    if i == 2 || i == 4
        cb = colorbar;
        cb.FontName = 'Times New Roman';
        cb.FontSize = 15;
        set(gca, 'colorscale', 'log'); 
        set(cb, 'YTick', [0.2 0.5 1 1.5 3.5])
    end
end
