% -------------------------------------------------------------------------
%% --------------------------- MLD-figure 02 ------------------------------
% -------------------------------------------------------------------------
% install m_map for matlab first
% related-data, 'support_file_02.nc'

%% directory
DIR = '../data/';

%% load variables
filename = [DIR, 'support_file_02.nc'];
discharge_time = ncread(filename, 'discharge_time');
discharge = ncread(filename, 'discharge');
mld1km_time = ncread(filename, 'mld1km_time');
mld5km_time = ncread(filename, 'mld5km_time');
mld1km = ncread(filename, 'mld1km');
mld5km = ncread(filename, 'mld5km');

%% plotting
figure;
yyaxis left
plot(datetime(datestr(discharge_time)), discharge, 'k-', 'linewidth', 2);
xlabel('time (day)')
ylabel('discharge (m^3/s)')
ylim([0.5e4, 3.5e4])

yyaxis right
plot(datetime(datestr(mld1km_time)), mld1km, 'r-', 'linewidth', 2);
ylabel('MLD (m)')
grid on
ylim([0, 100])
xlim([datetime('01-Jan-2015'),datetime('01-Dec-2015')])
set(gcf,'position',[100,200,800,500])

hold on
plot(datetime(datestr(mld5km_time(1:24:end))),  mld5km(1:24:end), 'g--')
legend('Discharge', 'MLD SP', 'MLD MR')