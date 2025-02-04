clear
close all
%%
D = dir('*all_4_Hz.csv');
T = readtable(D.name);
% T = readtable('20230309_170219_all_4_Hz.csv'); % Reads CSV into a table
% data = table2struct(T);
% data = struct2table(T, 'AsArray', true);

dx = 1; %km
% dx = 3*60; %s
dy = 0.5; %m
sx = 5;
sy = 5;

rangex = max(T.Alo) - min(T.Unix_time_sec);
rangey = max(T.Depth_m) - min(T.Depth_m);

% dx = 0.3;%km
[px_org,py_org,sa_gridded,DT] = delaunay_gridder(T.Unix_time_sec,T.Depth_m,T.Absolute_salinity_g_kg,dx,dy,rangex/rangey,sx*dx,sy*dy);
[px_org,py_org,ct_gridded,DT] = delaunay_gridder(T.Unix_time_sec,T.Depth_m,T.Conservative_temperature_C,dx,dy,rangex/rangey,sx*dx,sy*dy);


fig = figure;
set(gcf,'Position',[1 352 1029 985],'color','w')

ax1 = subplot(2,1,1);
ttt = pcolor(px_org,py_org,sa_gridded);
set(ttt,'EdgeColor','none')
set(ax1,'YDir','reverse');
colormap(ax1,cmocean('haline'))
auxh = colorbar;
ax1.FontSize = 22
xlabel('Distance (km)','FontWeight','Bold','FontSize',22)
ylabel('\sigma (kg/m^3)','FontWeight','Bold','FontSize',22)
ylabel(auxh,'g/kg','FontWeight','Bold','FontSize',22)
title('0.3km gridding','FontWeight','Bold','FontSize',22)
% ylim(ax1,[minrho,maxrho])

ax2 = subplot(2,1,2);
ttt = pcolor(px_org,py_org,ct_gridded);
set(ttt,'EdgeColor','none')
set(ax2,'YDir','reverse');
colormap(ax2,cmocean('thermal'))
auxh = colorbar;
ax2.FontSize = 24
xlabel('Distance (km)','FontWeight','Bold','FontSize',30)
ylabel('Potential Density (kg/m^3)','FontWeight','Bold','FontSize',26)
ylabel(auxh,'m^3/kg','FontWeight','Bold','FontSize',26)
% clim([-150,150])
% ylim(ax2,[minrho,maxrho])


%% 
dx = 0.3;%km
[px_org,py_org,sa_gridded,DT] = delaunay_gridder(T.Along_track_distance_km,T.Depth_m,T.Absolute_salinity_g_kg,dx,dy,rangex/rangey,sx*dx,sy*dy);
[px_org,py_org,ct_gridded,DT] = delaunay_gridder(T.Along_track_distance_km,T.Depth_m,T.Conservative_temperature_C,dx,dy,rangex/rangey,sx*dx,sy*dy);


p_ref = 0;
prho = gsw_rho(sa_gridded,ct_gridded,p_ref);

data_dengrid_check = grid_density_space(sa_gridded,ct_gridded,py_org',prho,px_org);

spice_curve = calculate_DSC(data_dengrid_check.SA,data_dengrid_check.CT,data_dengrid_check.potrho);

% %% plot
% 
minrho = 1024.7;
maxrho = 1027;

fig = figure;
set(gcf,'Position',[1 352 1029 985],'color','w')

ax1 = subplot(2,1,1);
ttt = pcolor(data_dengrid_check.dist,data_dengrid_check.potrho,data_dengrid_check.SA);
set(ttt,'EdgeColor','none')
set(ax1,'YDir','reverse');
colormap(ax1,cmocean('haline'))
auxh = colorbar;
ax1.FontSize = 22
xlabel('Distance (km)','FontWeight','Bold','FontSize',22)
ylabel('\sigma (kg/m^3)','FontWeight','Bold','FontSize',22)
ylabel(auxh,'g/kg','FontWeight','Bold','FontSize',22)
title('0.3km gridding','FontWeight','Bold','FontSize',22)
ylim(ax1,[minrho,maxrho])

ax2 = subplot(2,1,2);
ttt = pcolor(data_dengrid_check.dist,data_dengrid_check.potrho,spice_curve);
set(ttt,'EdgeColor','none')
set(ax2,'YDir','reverse');
colormap(ax2,cmocean('balance'))
auxh = colorbar;
ax2.FontSize = 24
xlabel('Distance (km)','FontWeight','Bold','FontSize',30)
ylabel('Potential Density (kg/m^3)','FontWeight','Bold','FontSize',26)
ylabel(auxh,'m^3/kg','FontWeight','Bold','FontSize',26)
clim([-150,150])
ylim(ax2,[minrho,maxrho])

