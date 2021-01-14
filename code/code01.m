% -------------------------------------------------------------------------
%% --------------------------- MLD-figure 01 ------------------------------
% -------------------------------------------------------------------------
% install m_map for matlab first
% related-data, 'support_file_01.nc'
% rnt_2grid

%% directory
DIR = '../data/';

%% load grid info and colormap
load([DIR, 'grdfile.mat']);
load([DIR, 'OMG_CM.mat'])
grd = grd1;

%% pre-defined parameters
minlon = -98; maxlon = -82; minlat = 24; maxlat = 30.5;

%% load variables
filename = [DIR, 'support_file_01.nc'];
temp = ncread(filename, 'temp');
zeta = ncread(filename, 'zeta');
u = ncread(filename, 'u');
v = ncread(filename, 'v');
site_loc = ncread(filename, 'site_loc');

%% plotting
figure;
% subplot 1
tracer_west = -96; tracer_south = 25; 
[~, a] = min(abs(grd.lonr(:,1) - tracer_west));
[~, b] = min(abs(grd.latr(1,:) - tracer_south));
lon_tracer = grd.lonr(a:end, b:end);
lat_tracer = grd.latr(a:end, b:end);
h_tracer = grd.h(a:end, b:end);

ax1 = subplot(2,1,1);
m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
m_gshhs_h();
hold on
m_pcolor(grd.lonr, grd.latr, temp .* grd.maskr); 
shading flat
m_grid('box', 'fancy', 'tickdir', 'in', 'fontname', ...
    'Times New Roman', 'fontsize', 18, 'linest',...
    'none', 'xaxisloc', 'bottom', 'yaxisloc', 'left'); 
m_ruler([0.05 .15], .88, 'tickdir', 'out', 'ticklen', ...
    [.006 .006],'fontname', 'Times New Roman', 'fontsize', 15);
hold on
m_contour(lon_tracer, lat_tracer, h_tracer, [200, 200], 'color', 'k', 'linewidth', 2);
[~, c] = min(abs(h_tracer(1,:) + tracer_bounder));
[~, d] = min(abs(h_tracer(:,1) + tracer_bounder));
m_line([grd.lonr(a,1), grd.lonr(a,1)], [lat_tracer(1,1), lat_tracer(1,c)], ...
    'color', 'k', 'linewidth', 2)
m_line([lon_tracer(1,1), lon_tracer(d,1)], [lat_tracer(1,1), lat_tracer(1,1)], ...
    'color', 'k', 'linewidth', 2)
hold on
m_plot(site_loc(:,1), site_loc(:,2), 'o', 'markersize', 6, ...
    'markeredgecolor','k', 'markerfacecolor', 'g')
m_text(-83, 29.75, 'a', 'FontWeight', 'bold','fontname', ...
    'Times New Roman', 'fontsize', 22)
caxis([8 28]);
cmocean('thermal')
cb = colorbar;
title(cb,{'^\circC'}, 'fontname', 'Times New Roman','fontsize',18); 
cb.FontName = 'Times New Roman';
cb.FontSize = 15;

% subplot 2
d_scale1 = 30; % control current vector
lon_ = grd1.lonp(1:d_scale1:end, 1:d_scale1:end);
lat_ = grd1.latp(1:d_scale1:end, 1:d_scale1:end);
u1 = rnt_2grid(u, 'u', 'p');
v1 = rnt_2grid(v, 'v', 'p');
uu_ = u1(1:d_scale1:end,1:d_scale1:end);
vv_ = v1(1:d_scale1:end,1:d_scale1:end);
uu_(3,20) = 1; vv_(3,20) = 0;

ax2 = subplot(2,1,2);
m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
m_gshhs_h(); 
hold on
m_pcolor(grd.lonr, grd.latr, zeta .* grd.maskr); 
shading flat
m_quiver(lon_, lat_, uu_, vv_, 0, 'k');
[c, hc] = m_contour(grd.lonr, grd.latr, zeta, [0.5 0.5], ...
    'color', 'c', 'linewidth', 2);
clabel(c, hc, 'Color', 'c', 'FontName', 'Times New Roman', ...
    'fontsize', 15);
m_grid('box', 'fancy', 'tickdir', 'in', 'fontname', 'Times New Roman', ...
    'fontsize', 18, 'linest','none', 'xaxisloc', 'bottom', ...
    'yaxisloc', 'left');
m_text(-97.5, 29.5, '1m/s', 'fontname', 'Times New Roman', 'fontsize', 15)
m_text(-83, 29.75, 'b', 'FontWeight', 'bold', 'fontname', ...
    'Times New Roman', 'fontsize', 22)
m_text(-96.25, 26.9, 'Loop Current Eddy', 'FontWeight', 'bold', ...
    'fontname', 'Times New Roman', 'fontsize', 15)
m_text(-86.5, 25.7, 'Loop Current', 'FontWeight', 'bold', ...
    'fontname', 'Times New Roman', 'fontsize', 15)
caxis([-1 1])
cb = colorbar;
title(cb,{'m'}, 'fontname', 'Times New Roman','fontsize',18); 
cb.FontName = 'Times New Roman';
cb.FontSize = 15;
colormap(ax2, cm4jet)
set(gcf,'position',[100,200,1000,700])

% arrange position
pos1 = get(ax1, 'position');
pos2 = pos1;
pos2(2) = pos1(2) - pos1(4) - 0.08;
set(ax2, 'position', pos2)