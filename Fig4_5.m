%Kothapalli Lab - Shubham Mirg, Kathiravan Ramiah
% Data Repository: 10.5281/zenodo.14876675, Code Repository:https://github.com/shubhammirg/TUTCranialWindowStim/tree/main

%% Here I take averages of selected rois if more than 1 for each mice and then detrend 

clear all
close all
load('lsci_com.mat')


fr=27.4
time_vector2=(0:1/fr:(size(comdata,1)/fr-1/fr)) -2

% DUTY CYCLE
figure(5)
roi=[5 7 4 ]
t1=3.2 %analysis at 1.2 second after stimulus
t2=4.4


for exp=1:1:size(comdata,3)
     for jj=1:1:size(comdata,4)
             %comdata2(:,exp,jj)=filtfilt(b6,a6, movmean(detrend(squeeze(mean(comdata(:,roi,exp,jj),2))),1));
             comdata2(:,exp,jj)=movmean(detrend(squeeze(mean(comdata(:,:,exp,jj),2))),10);
     end
end
subplot(431)
i=1;
movavg=1;
    for exp= [13:17]
   
      tmpvar=movmean(squeeze(mean(comdata2(:,exp,:),3)),movavg);
      tmpvarstd=squeeze(std(comdata2(:,exp,:),0,3))

      plot(time_vector2, tmpvar,'LineWidth',2)
  
      tmpvar2=squeeze(comdata2(floor(t1*fr):floor(t2*fr),exp,:))
      tmpvartime=squeeze((time_vector2(floor(t1*fr):floor(t2*fr))))
        a(i,:)= max(tmpvar2,[],1)
      b(i,:)=trapz(tmpvartime, (tmpvar2));
      
       hold on;
       i=i+1
    end
    legend('10%','20%','30%','40%','50%')
     xlim([-1 6])
xlabel('Time(s)')
      ylabel('%\Delta CBF (LSCI)')
floor(t1*fr):floor(t2*fr)

% PRF
subplot(434)
i=1
   for exp= [18:21, 17]
     
    tmpvar=movmean(squeeze(mean(comdata2(:,exp,:),3)),movavg);
      tmpvarstd=squeeze(std(comdata2(:,exp,:),0,3))

      plot(time_vector2, tmpvar,'LineWidth',2)
     % x_values = [time_vector, fliplr(time_vector)];
     %    y_values = [tmpvar+ tmpvarstd, fliplr(tmpvar-tmpvarstd)];
     %                  fill(x_values, y_values, [0.8 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.1);
      tmpvar2=squeeze(comdata2(floor(t1*fr):floor(t2*fr),exp,:))
       tmpvartime=squeeze((time_vector2(floor(t1*fr):floor(t2*fr))))
      a2(i,:)= max(tmpvar2,[],1)
      b2(i,:)=trapz(tmpvartime, (tmpvar2));
     axis tight
       hold on;
       i=i+1
    end
    
    legend
     xlim([-1 6])
    legend('100 Hz','300 Hz','500 Hz','700 Hz','1000 Hz')
xlabel('Time(s)')
      ylabel('%\Delta CBF (LSCI)')
% TST
subplot(437)
i=1;
    for exp= [28,24:27, 17]
     
     tmpvar=movmean(squeeze(mean(comdata2(:,exp,:),3)),movavg);
      tmpvarstd=squeeze(std(comdata2(:,exp,:),0,3))

      plot(time_vector2, tmpvar,'LineWidth',2)
     % x_values = [time_vector, fliplr(time_vector)];
     %    y_values = [tmpvar+ tmpvarstd, fliplr(tmpvar-tmpvarstd)];
     %                  fill(x_values, y_values, [0.8 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.1);
      tmpvar2=squeeze(comdata2(floor(t1*fr):floor(t2*fr),exp,:))
       tmpvartime=squeeze((time_vector2(floor(t1*fr):floor(t2*fr))))
      a3(i,:)= max(tmpvar2,[],1)
      b3(i,:)=trapz(tmpvartime, (tmpvar2));
     axis tight
       hold on;
       i=i+1
    end
    legend('25 ms', '50 ms','100 ms','150 ms','200 ms', '250 ms' )
     xlim([-1 6])
xlabel('Time(s)')
      ylabel('%\Delta CBF (LSCI)')
% AMP
i=1
subplot(4,3,10)
for exp= [32:-1:29, 17]
     
     tmpvar=movmean(squeeze(mean(comdata2(:,exp,:),3)),movavg);
      tmpvarstd=squeeze(std(comdata2(:,exp,:),0,3))

      plot(time_vector2, tmpvar,'LineWidth',2)
     % x_values = [time_vector, fliplr(time_vector)];
     %    y_values = [tmpvar+ tmpvarstd, fliplr(tmpvar-tmpvarstd)];
     %                  fill(x_values, y_values, [0.8 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.1);
      tmpvar2=squeeze(comdata2(floor(t1*fr):floor(t2*fr),exp,:))
       tmpvartime=squeeze((time_vector2(floor(t1*fr):floor(t2*fr))))
      a4(i,:)= max(tmpvar2,[],1)
      b4(i,:)=trapz(tmpvartime, (tmpvar2));
     axis tight
       hold on;
       i=i+1
    end
    legend('200 mV','250 mV','300 mV', '350 mV','400 mV')
      xlim([-1 6])
      xlabel('Time(s)')
      ylabel('%\Delta CBF (LSCI)')

 x = ["10%","20%","30%","40%","50%"];
subplot(432)
bar(mean(a,2)) 
 set(gca, 'XTickLabel',x)
hold on
title("Peak Change")

er=errorbar( mean(a,2), (std(a,0,2))./sqrt(size(a,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(435)
x=["100 Hz","300 Hz","500 Hz","700 Hz","1000 Hz"]
bar(mean(a2,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(a2,2), (std(a2,0,2))./sqrt(size(a2,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,8)
x=["25 ms", "50 ms","100 ms","150 ms","200 ms", "250 ms" ]
bar(mean(a3,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(a3,2), (std(a3,0,2))./sqrt(size(a3,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,11)
x=["200 mV","250 mV","300 mV", "350 mV","400 mV"]
bar(mean(a4,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(a4,2), (std(a4,0,2))./sqrt(size(a4,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  


 x = ["10%","20%","30%","40%","50%"];
subplot(433)
bar(mean(b,2)) 
 set(gca, 'XTickLabel',x)
hold on
title("Area under curve")
er=errorbar( mean(b,2), (std(b,0,2))./sqrt(size(b,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,6)
x=["100 Hz","300 Hz","500 Hz","700 Hz","1000 Hz"]
bar(mean(b2,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(b2,2), (std(b2,0,2))./sqrt(size(b2,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,9)
x=["25 ms", "50 ms","100 ms","150 ms","200 ms", "250 ms" ]
bar(mean(b3,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(b3,2), (std(b3,0,2))./sqrt(size(b3,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,12)
x=["200 mV","250 mV","300 mV", "350 mV","400 mV"]
bar(mean(b4,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(b4,2), (std(b4,0,2))./sqrt(size(b4,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1])
%saveas(gcf, 'LSCI_Analysis_Combined.eps', 'epsc')
saveas(gcf, 'LSCI_Analysis_Combined.png')
%% 


load("ios_com.mat")
time_vector2=[];


%roi=[7, 10,4];
comdata2=[];
% DUTY CYCLE
figure(6)

fr=10
time_vector2=linspace(-2,(size(comdata,1)/fr-1/fr)-2,size(comdata,1));
subplot(431)
i=1;
for exp=1:1:size(comdata,3)
     for jj=1:1:size(comdata,4)
             comdata2(:,exp,jj)=(detrend(squeeze(mean(comdata(:,:,exp,jj),2))));
     end
end
    for exp= [13:17]
     
      tmpvar=(squeeze(mean(comdata2(:,exp,:),3)));
      tmpvarstd=squeeze(std(comdata2(:,exp,:),0,3))

      plot(time_vector2, tmpvar,'LineWidth',2)
     % x_values = [time_vector, fliplr(time_vector)];
     %    y_values = [tmpvar+ tmpvarstd, fliplr(tmpvar-tmpvarstd)];
     %                  fill(x_values, y_values, [0.8 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.1);
      tmpvar2=squeeze(comdata2(floor(t1*fr):floor(t2*fr),exp,:))
       tmpvartime=squeeze((time_vector2(floor(t1*fr):floor(t2*fr))))
      ai(i,:)= max(tmpvar2,[],1)
      bi(i,:)=trapz(tmpvartime, (tmpvar2));
     axis tight
       hold on;
       i=i+1
    end
    legend('10%','20%','30%','40%','50%')
     xlim([-1 6])
xlabel('Time(s)')
      ylabel('\Delta OD (IOSI)')
floor(t1*fr):floor(t2*fr)

% PRF
subplot(434)
i=1
   for exp= [18:21, 17]
     
      tmpvar=(squeeze(mean(comdata2(:,exp,:),3)));
      tmpvarstd=squeeze(std(comdata2(:,exp,:),0,3))

      plot(time_vector2, tmpvar,'LineWidth',2)
     % x_values = [time_vector, fliplr(time_vector)];
     %    y_values = [tmpvar+ tmpvarstd, fliplr(tmpvar-tmpvarstd)];
     %                  fill(x_values, y_values, [0.8 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.1);
      tmpvar2=squeeze(comdata2(floor(t1*fr):floor(t2*fr),exp,:))
       tmpvartime=squeeze((time_vector2(floor(t1*fr):floor(t2*fr))))
      ai2(i,:)= max(tmpvar2,[],1)
      bi2(i,:)=trapz(tmpvartime, (tmpvar2));
     axis tight
       hold on;
       i=i+1
    end
    
    legend
     xlim([-1 6])
    legend('100 Hz','300 Hz','500 Hz','700 Hz','1000 Hz')
xlabel('Time(s)')
      ylabel('\Delta OD (IOSI)')
% TST
subplot(437)
i=1;
    for exp= [28,24:27, 17]
     
      tmpvar=(squeeze(mean(comdata2(:,exp,:),3)));
      tmpvarstd=squeeze(std(comdata2(:,exp,:),0,3))

      plot(time_vector2, tmpvar,'LineWidth',2)
     % x_values = [time_vector, fliplr(time_vector)];
     %    y_values = [tmpvar+ tmpvarstd, fliplr(tmpvar-tmpvarstd)];
     %                  fill(x_values, y_values, [0.8 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.1);
      tmpvar2=squeeze(comdata2(floor(t1*fr):floor(t2*fr),exp,:))
       tmpvartime=squeeze((time_vector2(floor(t1*fr):floor(t2*fr))))
      ai3(i,:)= max(tmpvar2,[],1)
      bi3(i,:)=trapz(tmpvartime, (tmpvar2));
     axis tight
       hold on;
       i=i+1
    end
    legend('25 ms', '50 ms','100 ms','150 ms','200 ms', '250 ms' )
     xlim([-1 6])
xlabel('Time(s)')
  ylabel('\Delta OD (IOSI)')
% AMP
i=1
subplot(4,3,10)
for exp= [32:-1:29, 17]
     
      tmpvar=(squeeze(mean(comdata2(:,exp,:),3)));
      tmpvarstd=squeeze(std(comdata2(:,exp,:),0,3))

      plot(time_vector2, tmpvar,'LineWidth',2)
     % x_values = [time_vector, fliplr(time_vector)];
     %    y_values = [tmpvar+ tmpvarstd, fliplr(tmpvar-tmpvarstd)];
     %                  fill(x_values, y_values, [0.8 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.1);
      tmpvar2=squeeze(comdata2(floor(t1*fr):floor(t2*fr),exp,:))
       tmpvartime=squeeze((time_vector2(floor(t1*fr):floor(t2*fr))))
      ai4(i,:)= max(tmpvar2,[],1)
      bi4(i,:)=trapz(tmpvartime, (tmpvar2));
     axis tight
       hold on;
       i=i+1
    end
    legend('200 mV','250 mV','300 mV', '350 mV','400 mV')
      xlim([-1 6])
      xlabel('Time(s)')
      ylabel('\Delta OD (IOSI)')

 x = ["10%","20%","30%","40%","50%"];
 subplot(432)
bar(mean(ai,2)) 
 set(gca, 'XTickLabel',x)
hold on
title("Peak Change")

er=errorbar( mean(ai,2), (std(ai,0,2))./sqrt(size(ai,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(435)
x=["100 Hz","300 Hz","500 Hz","700 Hz","1000 Hz"]
bar(mean(ai2,2)) 
 set(gca, 'XTickLabel',x) 
hold on

er=errorbar( mean(ai2,2), (std(ai2,0,2))./sqrt(size(ai2,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,8)
x=["25 ms", "50 ms","100 ms","150 ms","200 ms", "250 ms" ]
bar(mean(ai3,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(ai3,2), (std(ai3,0,2))./sqrt(size(ai3,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,11)
x=["200 mV","250 mV","300 mV", "350 mV","400 mV"]
bar(mean(ai4,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(ai4,2), (std(ai4,0,2))./sqrt(size(ai4,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  


 x = ["10%","20%","30%","40%","50%"];
subplot(433)
bar(mean(bi,2)) 
 set(gca, 'XTickLabel',x)
hold on
title("Area under curve")
er=errorbar( mean(bi,2), (std(bi,0,2))./sqrt(size(bi,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,6)
x=["100 Hz","300 Hz","500 Hz","700 Hz","1000 Hz"]
bar(mean(bi2,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(bi2,2), (std(bi2,0,2))./sqrt(size(bi2,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,9)
x=["25 ms", "50 ms","100 ms","150 ms","200 ms", "250 ms" ]
bar(mean(bi3,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(bi3,2), (std(bi3,0,2))./sqrt(size(bi3,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
subplot(4,3,12)
x=["200 mV","250 mV","300 mV", "350 mV","400 mV"]
bar(mean(bi4,2)) 
 set(gca, 'XTickLabel',x)
hold on

er=errorbar( mean(bi4,2), (std(bi4,0,2))./sqrt(size(bi4,2)))

er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1])
%saveas(gcf, 'IOS_Analysis_Combined.eps', 'epsc')
saveas(gcf, 'IOS_Analysis_Combined.png')