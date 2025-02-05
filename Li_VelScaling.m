%% START
% Edited by: Justin on Feb 4th
clc;
clear;
close all;
%hi
set(0,'defaultTextInterpreter','latex');

%% Load BL Based Data

rootdir = './ExperimentalData/';
filelist = dir(fullfile(rootdir,'Re*/*BL'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list

N_bl = length(filelist);

for i = 1:N_bl
   
    thisname = filelist(i).name;
    thisdir = filelist(i).folder;
    thisfile = strcat(thisdir,'/',thisname);
    
    BL_Data = load(thisfile);
    
    xhat{i} = BL_Data(:,1);
    Uinfty{i} = BL_Data(:,2);
    utau{i} = BL_Data(:,3);
    nu{i} = BL_Data(:,4);
    delta99{i} = BL_Data(:,end);
    
end

utau_upstream = [1.0114 1.0437 1.0572 1.0191];

clear this* BL_Data filelist

%%

filelist = dir(fullfile(rootdir,'Re*/*xhat*'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list

thisN = length(filelist);

i7 = 0;
i10 = 0;
i14 = 0;
i21 = 0;

for i = 1:thisN
   
    thisname = filelist(i).name;
    thisfolder = filelist(i).folder;
    thisfile = strcat(thisfolder,'/',thisname);
    
    thisData = load(thisfile);
    
    if contains(thisname,'Re07')
        
        i7 = i7 + 1;
        
        Re07_zplus{i7} = flipud(thisData(:,1));
        Re07_zdel99{i7} = flipud(thisData(:,2));
        Re07_Uplus{i7} = flipud(thisData(:,3));
        Re07_UvelDef{i7} = flipud(thisData(:,4));
        Re07_uuplus{i7} = flipud(thisData(:,end));

        Re07_N(i7) = length(Re07_zplus{i7});
        
    elseif contains(thisname,'Re10')
        
        i10 = i10 + 1;
        
        Re10_zplus{i10} = flipud(thisData(:,1));
        Re10_zdel99{i10} = flipud(thisData(:,2));
        Re10_Uplus{i10} = flipud(thisData(:,3));
        Re10_UvelDef{i10} = flipud(thisData(:,4));
        Re10_uuplus{i10} = flipud(thisData(:,end));

        Re10_N(i10) = length(Re10_zplus{i10});
    
    elseif contains(thisname,'Re14')
        
        i14 = i14 + 1;
        
        Re14_zplus{i14} = flipud(thisData(:,1));
        Re14_zdel99{i14} = flipud(thisData(:,2));
        Re14_Uplus{i14} = flipud(thisData(:,3));
        Re14_UvelDef{i14} = flipud(thisData(:,4));
        Re14_uuplus{i14} = flipud(thisData(:,end));

        Re14_N(i14) = length(Re14_zplus{i14});
    
    elseif contains(thisname,'Re21')
        
        i21 = i21 + 1;
        
        Re21_zplus{i21} = flipud(thisData(:,1));
        Re21_zdel99{i21} = flipud(thisData(:,2));
        Re21_Uplus{i21} = flipud(thisData(:,3));
        Re21_UvelDef{i21} = flipud(thisData(:,4));
        Re21_uuplus{i21} = flipud(thisData(:,end));

        Re21_N(i21) = length(Re21_zplus{i21});
    
    end
end

clear this* filelist i7 i10 i14 i21

%% Group Ks Load In

rootdir = './ExperimentalData/';
filelist = dir(fullfile(rootdir,'ks_Re*/*BL'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list

ks_N_bl = length(filelist);

for i = 1:ks_N_bl
   
    thisname = filelist(i).name;
    thisdir = filelist(i).folder;
    thisfile = strcat(thisdir,'/',thisname);
    
    ks_BL_Data = load(thisfile);
    
    ks_xhat{i} = ks_BL_Data(:,1);
    ks_Uinfty{i} = ks_BL_Data(:,2);
    ks_utau{i} = ks_BL_Data(:,3);
    ks_nu{i} = ks_BL_Data(:,4);
    ks_delta99{i} = ks_BL_Data(:,end);
    
end

% ks_Re14ks16 ks_Re14ks23 ks_Re15ks11
ks_utau_upstream = [1.0572 1.4537 0.7153];

clear this* ks_BL_Data filelist

%%

filelist = dir(fullfile(rootdir,'ks_Re*/ks_*xhat*'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list

thisN = length(filelist);

i16 = 0;
i23 = 0;
i11 = 0;

for i = 1:thisN
   
    thisname = filelist(i).name;
    thisfolder = filelist(i).folder;
    thisfile = strcat(thisfolder,'/',thisname);
    
    thisData = load(thisfile);
    
    if contains(thisname,'ks16')
        
        i16 = i16 + 1;
        
        ks_16_zplus{i16} = flipud(thisData(:,1));
        ks_16_zdel99{i16} = flipud(thisData(:,2));
        ks_16_Uplus{i16} = flipud(thisData(:,3));
        ks_16_UvelDef{i16} = flipud(thisData(:,4));
        ks_16_uuplus{i16} = flipud(thisData(:,end));

        ks_16_N(i16) = length(ks_16_zplus{i16});
        
    elseif contains(thisname,'ks23')
        
        i23 = i23 + 1;
        
        ks_23_zplus{i23} = flipud(thisData(:,1));
        ks_23_zdel99{i23} = flipud(thisData(:,2));
        ks_23_Uplus{i23} = flipud(thisData(:,3));
        ks_23_UvelDef{i23} = flipud(thisData(:,4));
        ks_23_uuplus{i23} = flipud(thisData(:,end));

        ks_23_N(i23) = length(ks_23_zplus{i23});
    
    elseif contains(thisname,'ks11')
        
        i11 = i11 + 1;
        
        ks_11_zplus{i11} = flipud(thisData(:,1));
        ks_11_zdel99{i11} = flipud(thisData(:,2));
        ks_11_Uplus{i11} = flipud(thisData(:,3));
        ks_11_UvelDef{i11} = flipud(thisData(:,4));
        ks_11_uuplus{i11} = flipud(thisData(:,end));

        ks_11_N(i11) = length(ks_11_zplus{i11});
    end
end

clear this* filelist i16 i11 i23

%% Calculate IBL Height Based on Power Law Fit

delta0 = [0.11 0.15 0.22 0.32];

for i = 1:N_bl
   
    xhatdelta0 = xhat{i}./delta0(i);
    
    delta_ibl{i} = ((delta0(i)*0.094).*((xhatdelta0).^0.77));
    
end

ks_delta0 = [0.22 0.32 0.15];

for i = 1:ks_N_bl
   
    ks_xhatdelta0 = ks_xhat{i}./ks_delta0(i);
    
    ks_delta_ibl{i} = ((ks_delta0(i)*0.095).*((ks_xhatdelta0).^0.75));
    
end


%% Velocity

for i = 1:N_bl
    
    if i == 1
        thisN = length(Re07_N);
        for j = 1:thisN
            thisZ = Re07_zdel99{j};
            
            Re07_U{j} = Re07_Uplus{j}.*utau{i}(j);
            
            ii = find(thisZ > delta_ibl{i}(j)/delta99{i}(j),1);
            
            Re07_Udelta_ibl(j) = Re07_U{j}(ii);
        end
    
    elseif i == 2 
        thisN = length(Re10_N);
        for j = 1:thisN
            thisZ = Re10_zdel99{j};
            
            Re10_U{j} = Re10_Uplus{j}.*utau{i}(j);
            
            ii = find(thisZ > delta_ibl{i}(j)/delta99{i}(j),1);
            
            Re10_Udelta_ibl(j) = Re10_U{j}(ii);
        end
        
    elseif i == 3 
        thisN = length(Re14_N);
        for j = 1:thisN
            thisZ = Re14_zdel99{j};
            
            Re14_U{j} = Re14_Uplus{j}.*utau{i}(j);
            
            ii = find(thisZ > delta_ibl{i}(j)/delta99{i}(j),1);
            
            Re14_Udelta_ibl(j) = Re14_U{j}(ii);
        end
        
    else 
        thisN = length(Re21_N);
        for j = 1:thisN
            thisZ = Re21_zdel99{j};
            
            Re21_U{j} = Re21_Uplus{j}.*utau{i}(j);
            
            ii = find(thisZ > delta_ibl{i}(j)/delta99{i}(j),1);
            
            Re21_Udelta_ibl(j) = Re21_U{j}(ii);
        end
        
    end
       
    
end


for i = 1:ks_N_bl
    
    if i == 1
        thisN = length(ks_16_N);
        for j = 1:thisN
            thisZ = ks_16_zdel99{j};
            
            ks_16_U{j} = ks_16_Uplus{j}.*ks_utau{i}(j);
            
            ii = find(thisZ > ks_delta_ibl{i}(j)/ks_delta99{i}(j),1);
            
            ks_16_Udelta_ibl(j) = ks_16_U{j}(ii);
        end
    
    elseif i == 2 
        thisN = length(ks_23_N);
        for j = 1:thisN
            thisZ = ks_23_zdel99{j};
            
            ks_23_U{j} = ks_23_Uplus{j}.*ks_utau{i}(j);
            
            ii = find(thisZ > ks_delta_ibl{i}(j)/ks_delta99{i}(j),1);
            
            ks_23_Udelta_ibl(j) = ks_23_U{j}(ii);
        end
        
    else 
        thisN = length(ks_11_N);
        for j = 1:thisN
            thisZ = ks_11_zdel99{j};
            
            ks_11_U{j} = ks_11_Uplus{j}.*ks_utau{i}(j);
            
            ii = find(thisZ > ks_delta_ibl{i}(j)/ks_delta99{i}(j),1);
            
            ks_11_Udelta_ibl(j) = ks_11_U{j}(ii);
        end
        
    end
       
    
end




%% Colors

Li_7k_Colors = ["#babd00","#b0f736","#57ea52","#00d776","#00bd93",...
    "#00a49c","#008e9a","#007a91","#006783","#005575","#004370",...
    "#0b1b84"]; % Yellow to Blue Gradient 

Li_10k_Colors = ["#babd00","#9ef43b","#00e35f","#00c58c","#00a79c",...
    "#008b9a","#00738c","#005d7b","#004770","#0b1b84"];

Li_14k_Colors_1 = ["#babd00","#a8f637","#3ce758","#00cf82","#00b398",...
    "#00999c","#008195","#006c87","#005978","#004570","#0b1b84"];
    
Li_21k_Colors = ["#babd00","#9ef43b","#00e35f","#00c58c","#00a79c",...
    "#008b9a","#00738c","#005d7b","#004770","#0b1b84"];

Li_ks16_Colors = ["#babd00","#a8f637","#3ce758","#00cf82","#00b398",...
    "#00999c","#008195","#006c87","#005978","#004570","#0b1b84"];

Li_ks23_Colors = ["#babd00","#9ef43b","#00e35f","#00c58c","#00a79c",...
    "#008b9a","#00738c","#005d7b","#004770","#0b1b84"];

Li_ks11_Colors = ["#babd00","#91f23f","#00de68","#00b995","#00999c",...
    "#007c92","#00627f","#004a70","#0b1b84"];

%% Mean Velocity Profiles GROUP RE FIRST

close all;

theseLengths = [length(Re07_N) length(Re10_N) length(Re14_N) length(Re21_N)];

figure();
tiledlayout(2,4);

%%%%%% Viscous Top Row

%%%%% Re7k
p1 = nexttile;
for i = 1:theseLengths(1)
    p1 = semilogx(Re07_zplus{i},Re07_Uplus{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_7k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z^+$','FontSize',28);
ylabel('$\langle U \rangle^+$','FontSize',28);
title('Re07ks16','FontSize',28);


%%%%%%% Re10k
p3 = nexttile;
for i = 1:theseLengths(2)
    p2 = semilogx(Re10_zplus{i},Re10_Uplus{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_10k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z^+$','FontSize',28);
title('Re10ks16','FontSize',28);
%ylabel('$\langle U \rangle^+$','FontSize',28);

%%%%%% Re14k
p5 = nexttile;
for i = 1:theseLengths(3)
    p3 = semilogx(Re14_zplus{i},Re14_Uplus{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_14k_Colors_1(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z^+$','FontSize',28);
title('Re14ks16','FontSize',28);
% ylabel('$\langle U \rangle^+$','FontSize',28);

%%%%% Re21k
p7 = nexttile;
for i = 1:theseLengths(4)
    p4 = semilogx(Re21_zplus{i},Re21_Uplus{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_21k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z^+$','FontSize',28);
title('Re21ks16','FontSize',28);
% ylabel('$\langle U\rangle^+$','FontSize',28);

%%%%%%% Outer Bottom Row
p2 = nexttile;
for i = 1:theseLengths(1)
    plot(Re07_U{i}./Uinfty{1}(i),Re07_zdel99{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_7k_Colors(i)); hold on
end
set(gca,'FontSize',20);
ylabel('$z/\delta$','FontSize',28);
xlabel('$\langle U \rangle /U_\infty$','FontSize',28);

p4 = nexttile;
for i = 1:theseLengths(2)
    plot(Re10_U{i}./Uinfty{2}(i),Re10_zdel99{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_10k_Colors(i)); hold on
end
set(gca,'FontSize',20);
% ylabel('$z/\delta$','FontSize',28);
xlabel('$\langle U \rangle /U_\infty$','FontSize',28);

p6 = nexttile;
for i = 1:theseLengths(3)
    plot(Re14_U{i}./Uinfty{3}(i),Re14_zdel99{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_14k_Colors_1(i)); hold on
end
set(gca,'FontSize',20);
% ylabel('$z/\delta$','FontSize',28);
xlabel('$\langle U \rangle /U_\infty$','FontSize',28);

p8 = nexttile;
for i = 1:theseLengths(4)
    plot(Re21_U{i}./Uinfty{4}(i),Re21_zdel99{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_21k_Colors(i)); hold on
end
set(gca,'FontSize',20);
% ylabel('$z/\delta$','FontSize',28);
xlabel('$\langle U \rangle /U_\infty$','FontSize',28);


%% Mean Velocity Profiles GROUP KS 

close all;

ks_theseLengths = [length(ks_16_N) length(ks_23_N) length(ks_11_N)];

figure();
tiledlayout(2,3);

%%%%%% Viscous Top Row

%%%%% Re14k ks16
p1 = nexttile;
for i = 1:ks_theseLengths(1)
    p1 = semilogx(ks_16_zplus{i},ks_16_Uplus{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_ks16_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z^+$','FontSize',28);
ylabel('$\langle U \rangle^+$','FontSize',28);
title('Re14ks16','FontSize',28);

%%%%%% Re15k ks23
p5 = nexttile;
for i = 1:ks_theseLengths(2)
    p3 = semilogx(ks_23_zplus{i},ks_23_Uplus{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_ks23_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z^+$','FontSize',28);
title('Re15ks23','FontSize',28);

%%%%%%% Re14k ks11
p3 = nexttile;
for i = 1:ks_theseLengths(3)
    p2 = semilogx(ks_11_zplus{i},ks_11_Uplus{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_ks11_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z^+$','FontSize',28);
title('Re14ks11','FontSize',28);
%ylabel('$\langle U \rangle^+$','FontSize',28);


%%%%%%% Outer Bottom Row

%%%%% Re14k ks16
p2 = nexttile;
for i = 1:ks_theseLengths(1)
    plot(ks_16_U{i}./ks_Uinfty{1}(i),ks_16_zdel99{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_ks16_Colors(i)); hold on
end
set(gca,'FontSize',20);
ylabel('$z/\delta$','FontSize',28);
xlabel('$\langle U \rangle /U_\infty$','FontSize',28);

%%%%%% Re15k ks23
p6 = nexttile;
for i = 1:ks_theseLengths(2)
    plot(ks_23_U{i}./ks_Uinfty{2}(i),ks_23_zdel99{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_ks23_Colors(i)); hold on
end
set(gca,'FontSize',20);
% ylabel('$z/\delta$','FontSize',28);
xlabel('$\langle U \rangle /U_\infty$','FontSize',28);

%%%%%%% Re14k ks11
p4 = nexttile;
for i = 1:ks_theseLengths(3)
    plot(ks_11_U{i}./ks_Uinfty{3}(i),ks_11_zdel99{i},'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_ks11_Colors(i)); hold on
end
set(gca,'FontSize',20);
% ylabel('$z/\delta$','FontSize',28);
xlabel('$\langle U \rangle /U_\infty$','FontSize',28);



%% IBL Scaling


close all;

figure();
tiledlayout(1,4);
p1 = nexttile;
for i = 1:theseLengths(1)
    thisZ = Re07_zdel99{i};
    plot(Re07_U{i}./Re07_Udelta_ibl(i),thisZ.*delta99{1}(i)./delta_ibl{1}(i),...
        'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_7k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$\langle U \rangle/U_i$','FontSize',24);
xlim([0 1]);
ylim([0 1]);
title('Re07ks16','FontSize',24)
ylabel('$z/\delta_i$','FontSize',24);


p2 = nexttile;
for i = 1:theseLengths(2)
    thisZ = Re10_zdel99{i};
    plot(Re10_U{i}./Re10_Udelta_ibl(i),thisZ.*delta99{2}(i)./delta_ibl{2}(i),...
        'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_10k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$\langle U \rangle/U_i$','FontSize',24);
xlim([0 1]);
ylim([0 1]);
title('Re10ks16','FontSize',24)

p3 = nexttile;
for i = 1:theseLengths(3)
    thisZ = Re14_zdel99{i};
    plot(Re14_U{i}./Re14_Udelta_ibl(i),thisZ.*delta99{3}(i)./delta_ibl{3}(i),...
        'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_14k_Colors_1(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$\langle U \rangle/U_i$','FontSize',24);
xlim([0 1]);
ylim([0 1]);
title('Re10ks16','FontSize',24)

p4 = nexttile;
for i = 1:theseLengths(4)
    thisZ = Re21_zdel99{i};
    plot(Re21_U{i}./Re21_Udelta_ibl(i),thisZ.*delta99{4}(i)./delta_ibl{4}(i),...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_21k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$\langle U \rangle/U_i$','FontSize',24);
xlim([0 1]);
ylim([0 1]);
title('Re21ks16','FontSize',24)


%% IBL Scaling Group ks


close all;

figure();
tiledlayout(1,3);
p1 = nexttile;
for i = 1:ks_theseLengths(1)
    thisZ = ks_16_zdel99{i};
    plot(ks_16_U{i}./ks_16_Udelta_ibl(i),thisZ.*ks_delta99{1}(i)./ks_delta_ibl{1}(i),...
        'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_ks16_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$\langle U \rangle/U_i$','FontSize',24);
xlim([0 1]);
ylim([0 1]);
title('Re14ks16','FontSize',24);
ylabel('$z/\delta_i$','FontSize',24);


p2 = nexttile;
for i = 1:ks_theseLengths(2)
    thisZ = ks_23_zdel99{i};
    plot(ks_23_U{i}./ks_23_Udelta_ibl(i),thisZ.*ks_delta99{2}(i)./ks_delta_ibl{2}(i),...
        'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_ks23_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$\langle U \rangle/U_i$','FontSize',24);
xlim([0 1]);
ylim([0 1]);
title('Re15ks23','FontSize',24)

p3 = nexttile;
for i = 1:ks_theseLengths(3)
    thisZ = ks_11_zdel99{i};
    plot(ks_11_U{i}./ks_11_Udelta_ibl(i),thisZ.*ks_delta99{3}(i)./ks_delta_ibl{3}(i),...
        'ko','MarkerSize',8,...
    'MarkerFaceColor',Li_ks11_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$\langle U \rangle/U_i$','FontSize',24);
xlim([0 1]);
ylim([0 1]);
title('Re14ks11','FontSize',24)

%% We will plot u'u'

close all;

figure();
subplot(1,2,1);
for i = 1:ks_theseLengths(3)
   thisZ = ks_11_zplus{i};
   semilogx(thisZ,ks_11_uuplus{i},...
       'ko','MarkerSize',8,...
       'MarkerFaceColor',Li_ks11_Colors(i)); hold on;
end
set(gca,'FontSize',20);
xlabel('$z^+$');
ylabel('$\langle u^\prime u^\prime \rangle^+$');

subplot(1,2,2);
for i = 1:ks_theseLengths(3)
   thisZ = ks_11_zdel99{i};
   plot((ks_11_uuplus{i}.*(ks_utau{3}(i)^2))./(ks_11_Udelta_ibl(i)^2),...
       thisZ.*ks_delta99{3}(i)./ks_delta_ibl{3}(i),...
       'ko','MarkerSize',8,...
       'MarkerFaceColor',Li_ks11_Colors(i)); hold on;
end
set(gca,'FontSize',20);
ylim([0 1]);
ylabel('$z/\delta_i$');
xlabel('$\langle u^\prime u^\prime \rangle/U_i^2$');



%% Calculate new defect

for i = 1:N_bl
    
    thisN = theseLengths(i);
    thisUtau = utau{i};
    
    if i == 1
        for j = 1:thisN
            thisVel = Re07_U{j};
            Re07_velDefect{j} = (Re07_Udelta_ibl(j) - thisVel)./thisUtau(j);
        end
    elseif i == 2
        for j = 1:thisN
            thisVel = Re10_U{j};
            Re10_velDefect{j} = (Re10_Udelta_ibl(j) - thisVel)./thisUtau(j);
        end
    elseif i == 3
        for j = 1:thisN
            thisVel = Re14_U{j};
            Re14_velDefect{j} = (Re14_Udelta_ibl(j) - thisVel)./thisUtau(j);
        end
    else
        for j = 1:thisN
            thisVel = Re21_U{j};
            Re21_velDefect{j} = (Re21_Udelta_ibl(j) - thisVel)./thisUtau(j);
        end
    end
end

clear thisN thisUtau thisVel

for i = 1:ks_N_bl
    
    thisN = ks_theseLengths(i);
    thisUtau = ks_utau{i};
    
    if i == 1
        for j = 1:thisN
            thisVel = ks_16_U{j};
            ks_16_velDefect{j} = (ks_16_Udelta_ibl(j) - thisVel)./thisUtau(j);
        end
    elseif i == 2
        for j = 1:thisN
            thisVel = ks_23_U{j};
            ks_23_velDefect{j} = (ks_23_Udelta_ibl(j) - thisVel)./thisUtau(j);
        end
    else
        for j = 1:thisN
            thisVel = ks_11_U{j};
            ks_11_velDefect{j} = (ks_11_Udelta_ibl(j) - thisVel)./thisUtau(j);
        end
    end
end

clear thisN thisUtau thisVel

%% Plot Velocity Defects

close all;

figure();

tiledlayout(2,4)

%%%% Top Row Old Defects 
p1 = nexttile;
for i = 1:theseLengths(1)
    semilogx(Re07_zdel99{i},Re07_UvelDef{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_7k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re07ks16','FontSize',24);
ylabel('$(U_\infty - \langle U \rangle)/u_{\tau,2}$','FontSize',28)

p2 = nexttile;
for i = 1:theseLengths(2)
    semilogx(Re10_zdel99{i},Re10_UvelDef{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_10k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re10ks16','FontSize',24);

p3 = nexttile;
for i = 1:theseLengths(3)
    p3 = semilogx(Re14_zdel99{i},Re14_UvelDef{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_14k_Colors_1(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re14ks16','FontSize',24);

p4 = nexttile;
for i = 1:theseLengths(4)
    p4 = semilogx(Re21_zdel99{i},Re21_UvelDef{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_21k_Colors(i)); hold on
end
set(gca,'FontSize',16);
xlabel('$z/\delta$','FontSize',18);
title('Re21ks16','FontSize',24);

%%%%% Bottom Row IBL Scaling Defect

p5 =  nexttile;
for i = 1:theseLengths(1)
    thisZ = Re07_zdel99{i};
    semilogx(thisZ.*delta99{1}(i)./delta_ibl{1}(i),Re07_velDefect{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_7k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta_i$','FontSize',28);
xlim([0 1]);
ylabel('$(U_i - \langle U \rangle)/u_{\tau,2}$','FontSize',28);

p6 = nexttile;
for i = 1:theseLengths(2)
    thisZ = Re10_zdel99{i};
    semilogx(thisZ.*delta99{2}(i)./delta_ibl{2}(i),Re10_velDefect{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_10k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);

p7 = nexttile;
for i = 1:theseLengths(3)
    thisZ = Re14_zdel99{i};
    semilogx(thisZ.*delta99{3}(i)./delta_ibl{3}(i),Re14_velDefect{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_14k_Colors_1(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);

p8 = nexttile;
for i = 1:theseLengths(4)
    thisZ = Re21_zdel99{i};
    semilogx(thisZ.*delta99{4}(i)./delta_ibl{4}(i),Re21_velDefect{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_21k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);


%% Plot Velocity Defects Group Ks

close all;

figure();

tiledlayout(2,3)

%%%% Top Row Old Defects 
p1 = nexttile;
for i = 1:ks_theseLengths(1)
    semilogx(ks_16_zdel99{i},ks_16_UvelDef{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_ks16_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re14ks16','FontSize',24);
ylabel('$(U_\infty - \langle U \rangle)/u_{\tau,2}$','FontSize',28)

p2 = nexttile;
for i = 1:ks_theseLengths(2)
    semilogx(ks_23_zdel99{i},ks_23_UvelDef{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_ks23_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re15ks23','FontSize',24);

p3 = nexttile;
for i = 1:ks_theseLengths(3)
    p3 = semilogx(ks_11_zdel99{i},ks_11_UvelDef{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_ks11_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re15ks11','FontSize',24);


%%%%% Bottom Row IBL Scaling Defect

p5 =  nexttile;
for i = 1:ks_theseLengths(1)
    thisZ = ks_16_zdel99{i};
    semilogx(thisZ.*ks_delta99{1}(i)./ks_delta_ibl{1}(i),ks_16_velDefect{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_ks16_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta_i$','FontSize',28);
xlim([0 1]);
ylabel('$(U_i - \langle U \rangle)/u_{\tau,2}$','FontSize',28);

p6 = nexttile;
for i = 1:ks_theseLengths(2)
    thisZ = ks_23_zdel99{i};
    semilogx(thisZ.*ks_delta99{2}(i)./ks_delta_ibl{2}(i),ks_23_velDefect{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_ks23_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);

p7 = nexttile;
for i = 1:ks_theseLengths(3)
    thisZ = ks_11_zdel99{i};
    semilogx(thisZ.*ks_delta99{3}(i)./ks_delta_ibl{3}(i),ks_11_velDefect{i},...
        'ko','MarkerSize',8,'MarkerFaceColor',Li_ks11_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);



%% Calculate Defect Laws for all Group Re


smoothPI = 0.55;
weakPI = 0.25;
kappa = 0.4;

for i = 1:4
    
    myIND = theseLengths(i);
    
    if i == 1
        thisYD{i} = Re07_zdel99{end};
        thisYDi{i} = Re07_zdel99{myIND}.*delta99{i}(myIND)./delta_ibl{i}(myIND);
        
        ii = find(thisYD{i} >= 1.2,1);
        thisYDi{i} = thisYDi{i}(1:ii);

        wake_ibl{i} = defectLaw(kappa,smoothPI,thisYDi{i});
        wake{i} = defectLaw(kappa,smoothPI,thisYD{i});
    elseif i == 3
        thisYD{i} = Re14_zdel99{end};
        thisYDi{i} = Re14_zdel99{myIND}.*delta99{i}(myIND)./delta_ibl{i}(myIND);
        
        ii = find(thisYD{i} >= 1.2,1);
        thisYDi{i} = thisYDi{i}(1:ii);

        wake_ibl{i} = defectLaw(kappa,smoothPI,thisYDi{i});
        wake{i} = defectLaw(kappa,smoothPI,thisYD{i});
    elseif i == 2
        thisYD{i} = Re10_zdel99{end};
        thisYDi{i} = Re10_zdel99{myIND}.*delta99{i}(myIND)./delta_ibl{i}(myIND);
        
        ii = find(thisYD{i} >= 1.2,1);
        thisYDi{i} = thisYDi{i}(1:ii);

        wake_ibl{i} = defectLaw(kappa,smoothPI,thisYDi{i});
        wake{i} = defectLaw(kappa,smoothPI,thisYD{i});
    else
        thisYD{i} = Re21_zdel99{end};
        thisYDi{i} = Re21_zdel99{myIND}.*delta99{i}(myIND)./delta_ibl{i}(myIND);
        
        ii = find(thisYD{i} >= 1.2,1);
        thisYDi{i} = thisYDi{i}(1:ii);

        wake_ibl{i} = defectLaw(kappa,smoothPI,thisYDi{i});
        wake{i} = defectLaw(kappa,smoothPI,thisYD{i});
    end
end


for i = 1:3
    
    myIND = ks_theseLengths(i);
    
    if i == 1
        ks_thisYD{i} = ks_16_zdel99{end};
        ks_thisYDi{i} = ks_16_zdel99{myIND}.*ks_delta99{i}(myIND)./ks_delta_ibl{i}(myIND);
        
        ii = find(ks_thisYD{i} >= 1.2,1);
        ks_thisYDi{i} = ks_thisYDi{i}(1:ii);

        ks_wake_ibl{i} = defectLaw(kappa,smoothPI,ks_thisYDi{i});
        ks_wake{i} = defectLaw(kappa,smoothPI,ks_thisYD{i});
    elseif i == 2
        ks_thisYD{i} = ks_23_zdel99{end};
        ks_thisYDi{i} = ks_23_zdel99{myIND}.*ks_delta99{i}(myIND)./ks_delta_ibl{i}(myIND);
        
        ii = find(ks_thisYD{i} >= 1.2,1);
        ks_thisYDi{i} = ks_thisYDi{i}(1:ii);

        ks_wake_ibl{i} = defectLaw(kappa,smoothPI,ks_thisYDi{i});
        ks_wake{i} = defectLaw(kappa,smoothPI,ks_thisYD{i});
    else
        ks_thisYD{i} = ks_11_zdel99{end};
        ks_thisYDi{i} = ks_11_zdel99{myIND}.*ks_delta99{i}(myIND)./ks_delta_ibl{i}(myIND);
        
        ii = find(ks_thisYD{i} >= 1.2,1);
        ks_thisYDi{i} = ks_thisYDi{i}(1:ii);

        ks_wake_ibl{i} = defectLaw(kappa,smoothPI,ks_thisYDi{i});
        ks_wake{i} = defectLaw(kappa,smoothPI,ks_thisYD{i});
    end
end

    
%% Plot Defects with Defect Laws 


close all;

figure();

tiledlayout(2,4);

%%%%%%% Top: Classic Defect

p1 = nexttile;
for i = 1:theseLengths(1)
    semilogx(Re07_zdel99{i},Re07_UvelDef{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_7k_Colors(i)); hold on
end
semilogx(thisYD{1},wake{1},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re07ks16','FontSize',24);
ylabel('$(U_\infty - U)/u_{\tau,2}$','FontSize',28)

p2 = nexttile;
for i = 1:theseLengths(2)
    semilogx(Re10_zdel99{i},Re10_UvelDef{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_10k_Colors(i)); hold on
end
semilogx(thisYD{2},wake{2},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re10ks16','FontSize',24);

p3 = nexttile;
for i = 1:theseLengths(3)
    semilogx(Re14_zdel99{i},Re14_UvelDef{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_14k_Colors_1(i)); hold on
end
semilogx(thisYD{3},wake{3},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re14ks16','FontSize',24);

p4 = nexttile;
for i = 1:theseLengths(4)
    semilogx(Re21_zdel99{i},Re21_UvelDef{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_21k_Colors(i)); hold on
end
semilogx(thisYD{4},wake{4},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re21ks16','FontSize',24);



%%%%%%%% Bottom IBL Scaled Defect Laws
p5 = nexttile;
for i = 1:theseLengths(1)
    thisZ = Re07_zdel99{i};
    semilogx(thisZ.*delta99{1}(i)./delta_ibl{1}(i),...
        Re07_velDefect{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_7k_Colors(i)); hold on
end
semilogx(thisYDi{1},wake_ibl{1},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);
ylabel('$(U_i - \langle U \rangle)/u_{\tau,2}$','FontSize',28);

p6 = nexttile;
for i = 1:theseLengths(2)
    thisZ = Re10_zdel99{i};
    semilogx(thisZ.*delta99{2}(i)./delta_ibl{2}(i),...
        Re10_velDefect{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_10k_Colors(i)); hold on
end
semilogx(thisYDi{2},wake_ibl{2},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);

p5 = nexttile;
for i = 1:theseLengths(3)
    thisZ = Re14_zdel99{i};
    semilogx(thisZ.*delta99{3}(i)./delta_ibl{3}(i),...
        Re14_velDefect{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_14k_Colors_1(i)); hold on
end
semilogx(thisYDi{3},wake_ibl{3},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);
ylabel('$(U_i - \langle U \rangle)/u_{\tau,2}$','FontSize',28);

p8 = nexttile;
for i = 1:theseLengths(4)
    thisZ = Re21_zdel99{i};
    semilogx(thisZ.*delta99{4}(i)./delta_ibl{4}(i),...
        Re21_velDefect{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_21k_Colors(i)); hold on
end
semilogx(thisYDi{4},wake_ibl{4},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);


%% Plot Defects with Defect Laws Group ks

close all;

figure();
tiledlayout(2,3);

%%%%%%% Top: Classic Defect

p1 = nexttile;
for i = 1:ks_theseLengths(1)
    semilogx(ks_16_zdel99{i},ks_16_UvelDef{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks16_Colors(i)); hold on
end
semilogx(ks_thisYD{1},ks_wake{1},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re14ks16','FontSize',24);
ylabel('$(U_\infty - U)/u_{\tau,2}$','FontSize',28)

p2 = nexttile;
for i = 1:ks_theseLengths(2)
    semilogx(ks_23_zdel99{i},ks_23_UvelDef{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks23_Colors(i)); hold on
end
semilogx(ks_thisYD{2},ks_wake{2},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re15ks23','FontSize',24);

p3 = nexttile;
for i = 1:ks_theseLengths(3)
    semilogx(ks_11_zdel99{i},ks_11_UvelDef{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks11_Colors(i)); hold on
end
semilogx(ks_thisYD{3},ks_wake{3},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re14ks11','FontSize',24);




%%%%%%%% Bottom IBL Scaled Defect Laws
p5 = nexttile;
for i = 1:ks_theseLengths(1)
    thisZ = ks_16_zdel99{i};
    semilogx(thisZ.*ks_delta99{1}(i)./ks_delta_ibl{1}(i),...
        ks_16_velDefect{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks16_Colors(i)); hold on
end
semilogx(ks_thisYDi{1},ks_wake_ibl{1},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);
ylabel('$(U_i - \langle U \rangle)/u_{\tau,2}$','FontSize',28);

p6 = nexttile;
for i = 1:ks_theseLengths(2)
    thisZ = ks_23_zdel99{i};
    semilogx(thisZ.*ks_delta99{2}(i)./ks_delta_ibl{2}(i),...
        ks_23_velDefect{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks23_Colors(i)); hold on
end
semilogx(ks_thisYDi{2},ks_wake_ibl{2},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);

p5 = nexttile;
for i = 1:ks_theseLengths(3)
    thisZ = ks_11_zdel99{i};
    semilogx(thisZ.*ks_delta99{3}(i)./ks_delta_ibl{3}(i),...
        ks_11_velDefect{i},'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks11_Colors(i)); hold on
end
semilogx(ks_thisYDi{3},ks_wake_ibl{3},'k--','LineWidth',3);
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);
ylabel('$(U_i - \langle U \rangle)/u_{\tau,2}$','FontSize',28);



%% ZS Scaling

% Usual Values
for j = 1:4
    
    for i = 1:theseLengths(j)
        
        if j == 1
            this_i = find(Re07_zdel99{i} >= 1.0, 1);
            this_z = Re07_zdel99{i}.*delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (Re07_U{i}./Uinfty{j}(i));
            this_integrand = this_integrand(1:this_i);

        elseif j == 2
            this_i = find(Re10_zdel99{i} >= 1.0, 1);
            this_z = Re10_zdel99{i}.*delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (Re10_U{i}./Uinfty{j}(i));
            this_integrand = this_integrand(1:this_i);

        elseif j == 3
            this_i = find(Re14_zdel99{i} >= 1.0, 1);
            this_z = Re14_zdel99{i}.*delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (Re14_U{i}./Uinfty{j}(i));
            this_integrand = this_integrand(1:this_i);

        else
            this_i = find(Re21_zdel99{i} >= 1.0, 1);
            this_z = Re21_zdel99{i}.*delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (Re21_U{i}./Uinfty{j}(i));
            this_integrand = this_integrand(1:this_i);

        end
        
        delta_star{j}(i) = trapz(this_z,this_integrand);

        u0{j}(i) = Uinfty{j}(i)*(delta_star{j}(i)/delta99{j}(i));

    end
end


%%%%%%% IBL Based ZS Now
for j = 1:4
    
    for i = 1:theseLengths(j)
        
        if j == 1
            thisZ = Re07_zdel99{i};
            this_zibl = thisZ.*delta99{j}(i)./delta_ibl{j}(i);

            this_i = find(this_zibl >= 1.0, 1);
            this_z = Re07_zdel99{i}.*delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (Re07_U{i}./Re07_Udelta_ibl(i));
            this_integrand = this_integrand(1:this_i);
            
            delta_i_star{j}(i) = trapz(this_z,this_integrand);

            u0_i{j}(i) = Re07_Udelta_ibl(i)*(delta_i_star{j}(i)/delta_ibl{j}(i));

        elseif j == 2
            thisZ = Re10_zdel99{i};
            this_zibl = thisZ.*delta99{j}(i)./delta_ibl{j}(i);

            this_i = find(this_zibl >= 1.0, 1);
            this_z = Re10_zdel99{i}.*delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (Re10_U{i}./Re10_Udelta_ibl(i));
            this_integrand = this_integrand(1:this_i);
            
            delta_i_star{j}(i) = trapz(this_z,this_integrand);

            u0_i{j}(i) = Re10_Udelta_ibl(i)*(delta_i_star{j}(i)/delta_ibl{j}(i));

        elseif j == 3
            thisZ = Re14_zdel99{i};
            this_zibl = thisZ.*delta99{j}(i)./delta_ibl{j}(i);

            this_i = find(this_zibl >= 1.0, 1);
            this_z = Re14_zdel99{i}.*delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (Re14_U{i}./Re14_Udelta_ibl(i));
            this_integrand = this_integrand(1:this_i);
            
            delta_i_star{j}(i) = trapz(this_z,this_integrand);

            u0_i{j}(i) = Re14_Udelta_ibl(i)*(delta_i_star{j}(i)/delta_ibl{j}(i));

        else
            thisZ = Re21_zdel99{i};
            this_zibl = thisZ.*delta99{j}(i)./delta_ibl{j}(i);

            this_i = find(this_zibl >= 1.0, 1);
            this_z = Re21_zdel99{i}.*delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (Re21_U{i}./Re21_Udelta_ibl(i));
            this_integrand = this_integrand(1:this_i);
            
            delta_i_star{j}(i) = trapz(this_z,this_integrand);

            u0_i{j}(i) = Re21_Udelta_ibl(i)*(delta_i_star{j}(i)/delta_ibl{j}(i));

        end
        
        
    end
end

%% ZS Scaling Group Ks

% Usual Values
for j = 1:3
    
    for i = 1:ks_theseLengths(j)
        
        if j == 1
            this_i = find(ks_16_zdel99{i} >= 1.0, 1);
            this_z = ks_16_zdel99{i}.*ks_delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (ks_16_U{i}./ks_Uinfty{j}(i));
            this_integrand = this_integrand(1:this_i);

        elseif j == 2
            this_i = find(ks_23_zdel99{i} >= 1.0, 1);
            this_z = ks_23_zdel99{i}.*ks_delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (ks_23_U{i}./ks_Uinfty{j}(i));
            this_integrand = this_integrand(1:this_i);

        else
            this_i = find(ks_11_zdel99{i} >= 1.0, 1);
            this_z = ks_11_zdel99{i}.*ks_delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (ks_11_U{i}./ks_Uinfty{j}(i));
            this_integrand = this_integrand(1:this_i);

        end
        
        ks_delta_star{j}(i) = trapz(this_z,this_integrand);

        ks_u0{j}(i) = ks_Uinfty{j}(i)*(ks_delta_star{j}(i)/ks_delta99{j}(i));

    end
end


%%%%%%% IBL Based ZS Now
for j = 1:3
    
    for i = 1:ks_theseLengths(j)
        
        if j == 1
            thisZ = ks_16_zdel99{i};
            this_zibl = thisZ.*ks_delta99{j}(i)./ks_delta_ibl{j}(i);

            this_i = find(this_zibl >= 1.0, 1);
            this_z = ks_16_zdel99{i}.*ks_delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (ks_16_U{i}./ks_16_Udelta_ibl(i));
            this_integrand = this_integrand(1:this_i);
            
            ks_delta_i_star{j}(i) = trapz(this_z,this_integrand);

            ks_u0_i{j}(i) = ks_16_Udelta_ibl(i)*(ks_delta_i_star{j}(i)/ks_delta_ibl{j}(i));

        elseif j == 2
            thisZ = ks_23_zdel99{i};
            this_zibl = thisZ.*ks_delta99{j}(i)./ks_delta_ibl{j}(i);

            this_i = find(this_zibl >= 1.0, 1);
            this_z = ks_23_zdel99{i}.*ks_delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (ks_23_U{i}./ks_23_Udelta_ibl(i));
            this_integrand = this_integrand(1:this_i);
            
            ks_delta_i_star{j}(i) = trapz(this_z,this_integrand);

            ks_u0_i{j}(i) = ks_23_Udelta_ibl(i)*(ks_delta_i_star{j}(i)/ks_delta_ibl{j}(i));

        else
            thisZ = ks_11_zdel99{i};
            this_zibl = thisZ.*ks_delta99{j}(i)./ks_delta_ibl{j}(i);

            this_i = find(this_zibl >= 1.0, 1);
            this_z = ks_11_zdel99{i}.*ks_delta99{j}(i);
            this_z = this_z(1:this_i);

            this_integrand = 1 - (ks_11_U{i}./ks_11_Udelta_ibl(i));
            this_integrand = this_integrand(1:this_i);
            
            ks_delta_i_star{j}(i) = trapz(this_z,this_integrand);

            ks_u0_i{j}(i) = ks_11_Udelta_ibl(i)*(ks_delta_i_star{j}(i)/ks_delta_ibl{j}(i));

        end
        
        
    end
end

%% Plot ZS Scaling

close all;

figure();
tiledlayout(2,4);


%%%%% Top Row ZS Scaling with Outer Scales
p1 = nexttile;
for i = 1:theseLengths(1)
    thisZS = (Uinfty{1}(i) - Re07_U{i})./u0{1}(i);
    
    semilogx(Re07_zdel99{i},thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_7k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re07ks16','FontSize',28);
ylabel('$(U_\infty - \langle U \rangle)/U_\infty\delta^*/\delta$',...
    'FontSize',28);

p2 = nexttile;
for i = 1:theseLengths(2)
    thisZS = (Uinfty{2}(i) - Re10_U{i})./u0{2}(i);
    
    semilogx(Re10_zdel99{i},thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_10k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re10ks16','FontSize',28);

p3 = nexttile;
for i = 1:theseLengths(3)
    thisZS = (Uinfty{3}(i) - Re14_U{i})./u0{3}(i);
    
    semilogx(Re14_zdel99{i},thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_14k_Colors_1(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re14ks16','FontSize',28);

p4 = nexttile;
for i = 1:theseLengths(4)
    thisZS = (Uinfty{4}(i) - Re21_U{i})./u0{4}(i);
    
    semilogx(Re21_zdel99{i},thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_21k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re21ks16','FontSize',28);

%%%%%%%% Bottom Row ZS Scaling with IBL Parameters
p5 = nexttile;
for i = 1:theseLengths(1)
    thisZS = (Re07_Udelta_ibl(i) - Re07_U{i})./u0_i{1}(i);
    thisZ = Re07_zdel99{i};
    this_zibl = thisZ.*delta99{1}(i)./delta_ibl{1}(i);
    
    semilogx(this_zibl,thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_7k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);
ylabel('$(U_i - \langle U \rangle )/U_i\delta_i^*/\delta_i$','FontSize',28);

p6 = nexttile;
for i = 1:theseLengths(2)
    thisZS = (Re10_Udelta_ibl(i) - Re10_U{i})./u0_i{2}(i);
    thisZ = Re10_zdel99{i};
    this_zibl = thisZ.*delta99{2}(i)./delta_ibl{2}(i);
    
    semilogx(this_zibl,thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_10k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);

p7 = nexttile;
for i = 1:theseLengths(3)
    thisZS = (Re14_Udelta_ibl(i) - Re14_U{i})./u0_i{3}(i);
    thisZ = Re14_zdel99{i};
    this_zibl = thisZ.*delta99{3}(i)./delta_ibl{3}(i);
    
    semilogx(this_zibl,thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_14k_Colors_1(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);

p8 = nexttile;
for i = 1:theseLengths(4)
    thisZS = (Re21_Udelta_ibl(i) - Re21_U{i})./u0_i{4}(i);
    thisZ = Re21_zdel99{i};
    this_zibl = thisZ.*delta99{4}(i)./delta_ibl{4}(i);
    
    semilogx(this_zibl,thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_21k_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);

%% Plot ZS Scaling Group ks

close all;

figure();
tiledlayout(2,3);


%%%%% Top Row ZS Scaling with Outer Scales
p1 = nexttile;
for i = 1:ks_theseLengths(1)
    thisZS = (ks_Uinfty{1}(i) - ks_16_U{i})./ks_u0{1}(i);
    
    semilogx(ks_16_zdel99{i},thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks16_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re14ks16','FontSize',28);
ylabel('$(U_\infty - \langle U \rangle)/U_\infty\delta^*/\delta$',...
    'FontSize',28);

p2 = nexttile;
for i = 1:ks_theseLengths(2)
    thisZS = (ks_Uinfty{2}(i) - ks_23_U{i})./ks_u0{2}(i);
    
    semilogx(ks_23_zdel99{i},thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks23_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re15ks23','FontSize',28);

p3 = nexttile;
for i = 1:ks_theseLengths(3)
    thisZS = (ks_Uinfty{3}(i) - ks_11_U{i})./ks_u0{3}(i);
    
    semilogx(ks_11_zdel99{i},thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks11_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlabel('$z/\delta$','FontSize',28);
title('Re14ks11','FontSize',28);


%%%%%%%% Bottom Row ZS Scaling with IBL Parameters
p5 = nexttile;
for i = 1:ks_theseLengths(1)
    thisZS = (ks_16_Udelta_ibl(i) - ks_16_U{i})./ks_u0_i{1}(i);
    thisZ = ks_16_zdel99{i};
    this_zibl = thisZ.*ks_delta99{1}(i)./ks_delta_ibl{1}(i);
    
    semilogx(this_zibl,thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks16_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);
ylabel('$(U_i - \langle U \rangle )/U_i\delta_i^*/\delta_i$','FontSize',28);

p6 = nexttile;
for i = 1:ks_theseLengths(2)
    thisZS = (ks_23_Udelta_ibl(i) - ks_23_U{i})./ks_u0_i{2}(i);
    thisZ = ks_23_zdel99{i};
    this_zibl = thisZ.*ks_delta99{2}(i)./ks_delta_ibl{2}(i);
    
    semilogx(this_zibl,thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks23_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);

p7 = nexttile;
for i = 1:ks_theseLengths(3)
    thisZS = (ks_11_Udelta_ibl(i) - ks_11_U{i})./ks_u0_i{3}(i);
    thisZ = ks_11_zdel99{i};
    this_zibl = thisZ.*ks_delta99{3}(i)./ks_delta_ibl{3}(i);
    
    semilogx(this_zibl,thisZS,'ko','MarkerSize',8,...
        'MarkerFaceColor',Li_ks11_Colors(i)); hold on
end
set(gca,'FontSize',20);
xlim([0 1]);
xlabel('$z/\delta_i$','FontSize',28);


%% Functions

function wake = defectLaw(kappa,myPI,yd)
    wake =  (1/kappa)*( -1*log(yd) + myPI*(2 - 2*(sin((pi()/2)*yd).^2)));
end

%% End
