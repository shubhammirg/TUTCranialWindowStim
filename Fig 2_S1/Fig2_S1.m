%TUT Stim Figure 2 Codes
%Kothpalli Lab - Shubham Mirg, Kathiravan Ramiah
%Comment out eps and emf file formats as needed for sections below
clear aline_p
close all
fntsz=21; % Font size
%% 3x3 pressure profile
pa=[];
pa2=[];
line_p=45;
figure(5)
load("33pres.mat")
pa=frfdata(6:end-7, 1:end-4)./4.75e-8*1e-3;
pa2=interp2(pa);
pa2_max=max(max(pa2));
pa2(pa2<=0.3*max(max(pa2)))=0; %% Thresholding
tmp_1=pa2./pa2_max;
I=imagesc(tmp_1);
axis off;
cmap = colormap(jet) ; %Create Colormap
cbh = colorbar ; %Create Colorbar
cbh.Limits=[0 max(max(tmp_1))];
t=get(cbh,'Limits');
set(cbh,'Ticks',linspace(t(1),t(2),2))
 cbh.TickLabels = [0 max(max(tmp_1))] ;
 cbh.FontSize=fntsz;
 cbh.FontName='Times';
 ylabel(cbh,'Normalized Pressure','FontSize',fntsz,'Rotation',270,'FontName','Times')
 hold on
 line([5,25], [74,74],'LineWidth',2,'Color', 'w');
  line([1,length(pa2)], [line_p,line_p],'LineWidth',4,'Color', 'w', 'LineStyle','--');
 str = [num2str(20*dx/2)];
text(8,70,[str ' mm'],'Color','white','FontSize',fntsz,'FontName','Times')
 ax=gca;
%exportgraphics(ax,'33pres.eps',Colorspace='rgb')
exportgraphics(ax,'33pres.png',Colorspace='rgb')
%exportgraphics(ax,'33pres.emf',Colorspace='rgb')
savefig(gcf,'33pres')
%% 3X3 surface profile
figure(6)
tmp2=pa2(line_p,:)/pa2_max;
xax=linspace(0,length(tmp2)*dx/2, length(tmp2));
plot(xax, tmp2,LineWidth=4,Color='k');
axis tight
ylim([0 1]);
xticks([min(xax) max(xax)]);
yticks([0 1]);
ax = gca; 
ax.FontSize = fntsz;
ax.FontName='Times';
xlabel('Distance (mm)','FontSize',fntsz) ;
ylabel('Normalized Pressure','FontSize',fntsz) ;
 ax=gca;
%% 3x3 freq profile

figure(7)
load("33freq.mat")
pressure_norm=(pressure(21:end)./max(pressure(21:end)));
plot(f(21:end), pressure_norm,LineWidth=4,Color='k');
axis tight
ylim([-inf inf]);
xticks([min(f(21:end)) max(f)]);
yticks([min(pressure_norm) max(pressure_norm)]);
ax = gca; 
ax.FontSize = fntsz;
ax.FontName='Times';
xlabel('Frequency (MHz)','FontSize',fntsz) ;
ylabel('Normalized Pressure','FontSize',fntsz) ;
 ax=gca;
%exportgraphics(ax,'33freq.eps',Colorspace='rgb')
exportgraphics(ax,'33freq.png',Colorspace='rgb')
%exportgraphics(ax,'33freq.emf',Colorspace='rgb')
savefig(gcf,'33freq')
%% h pressure isppa figure
figure(8)
VOL_GAIN=[];
load("33volt2.mat")

% load("33volt2.mat")
% VOL_GAIN=VOL(2:2:end)*0.32;
% % PRES2=PRES(2:2:end);
% VOL_GAIN=VOL(2:2:end);
% PRES2=PRES(2:2:end);
VOL_GAIN=press(:,1);
PRES2=mean(abs(press(:,7:11)/4.8e-2),2); %%4.8 mV/kPa 
PRES3=mean(abs(press(:,7:11)/4.8e-2),2)*7/10; %%4.8 mV/kPa 


er=errorbar(VOL_GAIN,mean(abs(press(:,7:11)/4.8e-2),2),std(abs(press(:,7:11)/4.8e-2),0,2),'LineWidth', 2, 'Color', 'k')

axis tight
ylim([-inf inf]);
xticks([min(VOL_GAIN) max(VOL_GAIN)]);
yticks([min(PRES2) max(PRES2)]);
ax = gca; 
ax.FontSize = fntsz;
ax.FontName='Times';
xlabel('Pre-Amp Voltage_p_p (mV)','FontSize',fntsz) ;
ylabel('Peak Negative Pressure (kPa)','FontSize',fntsz) ;
ax=gca;
%exportgraphics(ax,'33volt.eps',Colorspace='rgb')
exportgraphics(ax,'33volt.png',Colorspace='rgb')
%exportgraphics(ax,'33volt.emf',Colorspace='rgb')
savefig(gcf,'33volt')
%% 3x3 pressure profile with thinned skuline_p
pa=[];
pa2=[];
figure(9)
load("33pres_skull.mat")
pa=frfdata(6:end-7, 1:end-4)./4.75e-8*1e-3;
pa2=interp2(pa);
pa2_max_sk=max(max(pa2));
pa2(pa2<=0.3*pa2_max_sk)=0; %% Thresholding
tmp_1=pa2./pa2_max;
I=imagesc(tmp_1);
axis off;
cmap = colormap(jet) ; %Create Colormap
cbh = colorbar ; %Create Colorbar
cbh.Limits=[0 1];
t=get(cbh,'Limits');
set(cbh,'Ticks',linspace(t(1),t(2),2))
 cbh.TickLabels = [0 1] ;
 cbh.FontSize=fntsz;
 cbh.FontName='Times';
 ylabel(cbh,'Normalized Pressure','FontSize',fntsz,'Rotation',270,'FontName','Times')
 hold on
 line([5,25], [74,74],'LineWidth',2,'Color', 'w');
  line([1,length(pa2)], [line_p,line_p],'LineWidth',4,'Color', 'w', 'LineStyle','--');
 str = [num2str(20*dx/2)];
text(8,70,[str ' mm'],'Color','white','FontSize',fntsz,'FontName','Times')
 ax=gca;
%exportgraphics(ax,'33pres_skull.eps',Colorspace='rgb')
exportgraphics(ax,'33pres_skull.png',Colorspace='rgb')
%exportgraphics(ax,'33pres_skull.emf',Colorspace='rgb')
savefig(gcf,'33pres_skull')
%% 3X3 surface profile
figure(6)
hold on
tmp2=pa2(line_p,:)/pa2_max;
xax=linspace(0,length(tmp2)*dx/2, length(tmp2));
plot(xax, tmp2,LineWidth=4,Color='r');
%ylim([-inf inf]);
%xticks([min(xax) max(xax)]);
%yticks([min(tmp2) max(tmp2)]);
ax = gca; 
ax.FontSize = fntsz;
ax.FontName='Times';
xlabel('Distance (mm)','FontSize',fntsz) ;
ylabel('Normalized Pressure','FontSize',fntsz) ;
legend("Without Skull", "With Skull",fontsize=fntsz)
 ax=gca;
%exportgraphics(ax,'33pres_prof.eps',Colorspace='rgb')
exportgraphics(ax,'33pres_prof.png',Colorspace='rgb')
%exportgraphics(ax,'33pres_prof.emf',Colorspace='rgb')
savefig(gcf,'33pres_prof')
%% Tissue attenuation
close all 
load('att_mean_value.mat')
figure(10)
mp=att_mean_value;
mp_norm=10*log(mp()./max(mp(1)));
xdep=[0 2.6 3.4 4.2];
att_theo=-9.84*xdep/10; %https://ieeexplore.ieee.org/abstract/document/8092756
plot(xdep, mp_norm,LineWidth=4,Color='k',Marker='o')
hold on 
plot(xdep, att_theo,LineWidth=4,Color='b')
axis tight
legend('Measured Tissue Attenuation', 'Experimental Tissue Attenuation', 'FontSize',fntsz-6,FontName='Times')
ylim([-inf inf]);
xticks([min(xdep) max(xdep)]);
 yticks([round(min(mp_norm),1) max(mp_norm)]);
ax = gca; 
ax.FontSize = fntsz;
ax.FontName='Times';
xlabel('Brain Tissue Thickness (mm)','FontSize',fntsz) ;
ylabel('Attenuation (dB)','FontSize',fntsz) ;
ax=gca;
%exportgraphics(ax,'Acoustic_attenuation.eps',Colorspace='rgb')
exportgraphics(ax,'Acoustic_attenuation.png',Colorspace='rgb')
%exportgraphics(ax,'Acoustic_attenuation.emf',Colorspace='rgb')
savefig(gcf,'Acoustic_attenuation')