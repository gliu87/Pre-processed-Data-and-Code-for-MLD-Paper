% -------------------------------------------------------------------------
%% --------------------------- MLD-figure 03 & 04 -------------------------
% -------------------------------------------------------------------------
% install m_map and cmocean for matlab first
% related-data, 'support_file_03.nc', 'support_file_04.nc'
% 

%% directory
DIR = '../data/';

%% load grid info and colormap
load([DIR, 'grdfile.mat']);
load([DIR, 'OMG_CM.mat'])
grd = grd1;

%% pre-defined parameters
minlon = -98; maxlon = -82; minlat = 24; maxlat = 30.5;
sL = 31.5; sH= 37.5; vL = -1; vH = 1; 
ids = {'a', 'b', 'c', 'd'};
dates = {'04-Feb-2015', '05-May-2015', '03-Aug-2015', '11-Nov-2015'};

%% load variables
filename = [DIR, 'support_file_03.nc'];
salt = ncread(filename, 'salt');
filename = [DIR, 'support_file_04.nc'];
u = ncread(filename, 'u');
v = ncread(filename, 'v');

%% plotting
for i = 1:4
    figure(1)
    f1(i) = subplot(2,2,i);
    % calculate curl
    [curl, ~] = rnt_curl(u(:,:,i), v(:,:,i), grd);
    fp = rnt_2grid(grd.f, 'r', 'p');
    curlf = curl ./ fp;
    % plot
    m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
    m_gshhs_h('color', 'k');
    m_grid('fontname', 'Times New Roman', 'fontsize', 18);
    hold on
    m_pcolor(grd.lonp, grd.latp, curlf .* grd.maskp); shading interp;
    caxis([vL, vH])
    m_text(-97.4, 29.5, ids{i}, 'FontWeight', 'bold','fontname', ...
        'Times New Roman', 'fontsize', 22)
    title(dates{i},'fontname', 'Times New Roman', 'fontsize', 16)
    cmocean('curl')
    set(gcf,'position',[100,200,1400,500])
    
    figure(2)
    f2(i) = subplot(2,2,i);
    m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
    m_gshhs_h('color', 'k'); 
    m_grid('fontname', 'Times New Roman', 'fontsize', 18);
    hold on
    m_pcolor(grd.lonr, grd.latr, salt(:,:,i) .* grd.maskr); shading interp;
    m_text(-97.4, 29.5, ids{i}, 'FontWeight', 'bold','fontname', ...
        'Times New Roman', 'fontsize', 22)
    colormap(cm4jet)
    caxis([sL, sH])
    title(dates{i},'fontname', 'Times New Roman', 'fontsize', 16)
    cb = colorbar;
    cb.FontName = 'Times New Roman';
    cb.FontSize = 15;
    set(gcf,'position',[100,200,1400,500])
end

%% figure position
pos = get(f1(2), 'position')
pos(1) = 0.49;
set(f1(2), 'position', pos)
pos = get(f1(4), 'position')
pos(1) = 0.49;
set(f1(4), 'position', pos)

pos = get(f2(2), 'position')
pos(1) = 0.48;
set(f2(2), 'position', pos)
pos = get(f2(4), 'position')
pos(1) = 0.48;
set(f2(4), 'position', pos)