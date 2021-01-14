% -------------------------------------------------------------------------
%% --------------------------- MLD-figure S02 -----------------------------
% -------------------------------------------------------------------------
% install m_map for matlab first
% related-data, 'support_file_08.nc'
% 

%% directory
DIR = '../data/';

%% load grid info and colormap
load([DIR, 'grdfile.mat']);
load([DIR, 'OMG_CM.mat'])
grd = grd1;

%% pre-defined parameters
minlon = -98; maxlon = -82; minlat = 24; maxlat = 30.5;

%% load variables
filename = [DIR, 'support_file_08.nc'];
mldTempBar = ncread(filename, 'mld_temp');
mldDensBar = ncread(filename, 'mld_dens');
lonT = ncread(filename, 'par_lon_temp');
latT = ncread(filename, 'par_lat_temp');
lonD = ncread(filename, 'par_lon_dens');
latD = ncread(filename, 'par_lat_dens');

%% plotting
figure(1); 
% mld check
s1 = subplot(2,3,1);
pcolor(grd.lonr, grd.latr, mldTempBar .* grd.maskr);  % 73m, >200m
shading flat; colorbar; colormap(cm4jet)
text(-97.5, 29.5, 'a', 'fontweight', 'bold')
box on;
axis([-98, -82, 24, 30.5])
caxis([0 120])

s2 = subplot(2,3,2);
pcolor(grd.lonr, grd.latr, mldDensBar .* grd.maskr); % 68.41
shading flat; colorbar; colormap(cm4jet)
text(-97.5, 29.5, 'b', 'fontweight', 'bold')
box on;
axis([-98, -82, 24, 30.5])
caxis([0, 120])

s3 = subplot(2,3,3);
mldDiffBar = mldTempBar - mldDiffBar;
pcolor(grd.lonr, grd.latr, mldDiffBar .* maskr); 
caxis([-35 35])
shading flat; colorbar; colormap(cm4jet)
text(-97.5, 29.5, 'c', 'fontweight', 'bold')
box on;
axis([-98, -82, 24, 30.5])

% bin and count
dx = 10;
xedges = grd.lonr(1:dx:end, 1);
yedges = grd.latr(1, 1:dx:end);
masks = rnt_2grid(grd.maskp(1:dx:end, 1:dx:end), 'r', 'p');
x = lonT;
y = latT;
NT = histcounts2(x, y, xedges, yedges,'Normalization','probability');
s4 = subplot(2,3,4);
pcolor(rnt_2grid(grd.lonp(1:dx:end, 1:dx:end), 'r', 'p'), ...
    rnt_2grid(grd.latp(1:dx:end, 1:dx:end), 'r', 'p'), NT .* masks); 
shading interp; colormap(cm4jet); colorbar;caxis([0, 1.2e-3])
text(-97.5, 29.5, 'd', 'fontweight', 'bold')
box on;
axis([-98, -82, 24, 30.5])

x = lonD;
y = latD;
ND = histcounts2(x, y, xedges, yedges,'Normalization','probability');
s5 = subplot(2,3,5);
pcolor(rnt_2grid(grd.lonp(1:dx:end, 1:dx:end), 'r', 'p'), ...
    rnt_2grid(grd.latp(1:dx:end, 1:dx:end), 'r', 'p'), ND .* masks); 
shading interp; colormap(cm4jet); colorbar;
caxis([0, 1.2e-3])
text(-97.5, 29.5, 'e', 'fontweight', 'bold')
box on;
axis([-98, -82, 24, 30.5])

s6 = subplot(2,3,6);
pcolor(rnt_2grid(grd.lonp(1:dx:end, 1:dx:end), 'r', 'p'), ...
    rnt_2grid(grd.latp(1:dx:end, 1:dx:end), 'r', 'p'), (NT - ND) .* masks); 
shading interp; colormap(cm4jet); colorbar;
caxis([-3e-4, 3e-4])
text(-97.5, 29.5, 'f', 'fontweight', 'bold')
box on;
axis([-98, -82, 24, 30.5])

set(gcf,'position',[100,100,1600,500])
% location
pos = get(s2(1), 'position');
pos(1) = 0.38;
set(s2(1), 'position', pos)
pos = get(s3(1), 'position');
pos(1) = 0.63;
set(s3(1), 'position', pos)
pos = get(s4(1), 'position');
pos(2) = 0.15;
set(s4(1), 'position', pos)
pos = get(s5(1), 'position');
pos(1) = 0.38;
pos(2) = 0.15;
set(s5(1), 'position', pos)
pos = get(s6(1), 'position');
pos(1) = 0.63;
pos(2) = 0.15;
set(s6(1), 'position', pos)
set(s6, 'clim', [-3e-4, 3e-4])