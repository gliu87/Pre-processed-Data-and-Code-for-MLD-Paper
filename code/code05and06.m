% -------------------------------------------------------------------------
%% --------------------------- MLD-figure 05 ------------------------------
% MLD-figure 06 is amlost the same, but for deep releases
% -------------------------------------------------------------------------
% install m_map for matlab first
% related-data, ''
% for figure 05, no support file needed, use LTRANSv2b output files 
% remove_bad_tracer

%% directory
DIR = '../data/';
 
%% load grid info and colormap
load([DIR, 'grdfile.mat']);
load([DIR, 'OMG_CM.mat'])
grd = grd1;
 
%% pre-defined parameters
minlon = -98; maxlon = -82; minlat = 24; maxlat = 30.5; 
days = 10*24; % process day
size_ = 2; % for particle size
color_ = [1 0 0]; % for text

ids = {'a', 'b', 'c', 'd'};
seasons = {'Feb', 'May', 'Aug', 'Nov'};
values = {'-49.2m', '-11.4m', '-7.6m', '-18.9m'};
cx = [-200, 10; 
    -60, -1; 
    -60, -1; 
    -100, -5];

%% plotting
for i = 1:4
    file = [DIR, 'lt_1km_wholedomain_15', lower(seasons{i}),'_5m_day1.nc'];
    figure(1)
    s(i) = subplot(2,2,i);
    lon_ori = ncread(file,'lon');
    lat_ori = ncread(file,'lat');
    depth_ori = ncread(file,'depth');
    [lon, lat, depth] = remove_bad_tracer(lon_ori, lat_ori, depth_ori);
    clear lon_ori lat_ori depth_ori
    m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
    m_gshhs_h('color', 'k');
    m_grid('fontname', 'Times New Roman', 'fontsize', 18);
    hold on;
    [X1,Y1] = m_ll2xy(lon(:, days), lat(:, days));
    scatter(X1, Y1, size_, 'filled', 'cdata', depth(:, days)); 
    abs(nanmean(-depth(:, days)))
    m_text(-97.5, 30, ids{i}, 'FontWeight', 'bold', ...
        'fontname', 'Times New Roman', 'fontsize', 22);
    m_text(-84.75, 30, seasons{i}, 'FontWeight', 'bold', 'Color', color_ ...
        ,'fontname', 'Times New Roman', 'fontsize', 15);
    m_text(-84.75, 29, values{i}, 'FontWeight', 'bold', 'Color', color_...
        ,'fontname', 'Times New Roman', 'fontsize', 15);
    cb = colorbar;
    % set(cb,'ytick',[-200 -75 -25  -10],...
    % 'yticklabel',[-200 -75 -25 -10],'tickdir','out');
    cb.FontName = 'Times New Roman';
    cb.FontSize = 15;
    title(cb,{'m'},'fontname','Times New Roman','fontsize',18); 
    colormap(cm4jet)
    set(gca, 'colorscale', 'log');
    caxis(cx(i,:))
    set(gcf,'position',[100,200,1600,500])
end

% location
pos = get(s(2), 'position');
pos(1) = 0.49;
set(s(2), 'position', pos)
pos = get(s(4), 'position');
pos(1) = 0.49;
set(s(4), 'position', pos)
