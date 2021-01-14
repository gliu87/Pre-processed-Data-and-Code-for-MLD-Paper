% -------------------------------------------------------------------------
%% --------------------------- MLD-figure S03 -----------------------------
% -------------------------------------------------------------------------
% install m_map for matlab first
% related-data, 'support_file_09.nc'
% plot function is similar as previous one, here shows curl calculation

%% directory
DIR = '../data/';

%% file
filename = [DIR, 'support_file_09.nc'];
u = ncread(filename, 'u');
v = ncread(filename, 'v');
grdfile = [DIR, 'gmx1km_grd.nc'];

rec = 1; 
[curlf, ~] = getCurl(grdfile, u(:,:,rec), v(:,:,rec));

function [curlf, msk] = getCurl(grdname, u, v)
grd.pm = ncread(grdname, 'pm');
grd.pn = ncread(grdname, 'pn');
grd.f = ncread(grdname, 'f');
grd.maskp = ncread(grdname, 'mask_psi');
[curl, ~] = rnt_curl(u,v,grd);
fp = rnt_2grid(grd.f, 'r', 'p');
curlf = curl ./ fp;
msk = grd.maskp;
msk(msk(:)==0) = NaN;
end