clear all;
close all

load("s2.mat")

plot(time_vector2,mean(a_ios,2),'LineWidth',3)
hold on
plot(time_vector2,p1io,'LineWidth',3)

         ylabel('%\Delta OD')
    % Shared x-axis, from -2 to 6 seconds
    xlabel('Time (s)');
      axis tight
   xlim([-1, 6]);

    hold off;
 
saveas(gcf, 'IOS_phantom.eps', 'epsc')
saveas(gcf, 'IOS_phantom.png')
saveas(gcf, 'IOS_phantom.fig')
exportgraphics(gca,'IOS_phantom.eps')

figure
plot(time_vector,a./max(a),'LineWidth',3)
hold on
plot(time_vector,b./max(b),'LineWidth',3)

         ylabel('%\Delta CBF')
    % Shared x-axis, from -2 to 6 seconds
    xlabel('Time (s)');
      axis tight
   xlim([-1, 6]);

    hold off;
 
saveas(gcf, 'lsci_phantom.eps', 'epsc')
saveas(gcf, 'lsci_phantom.png')
saveas(gcf, 'lsci_phantom.fig')
exportgraphics(gca,'lsci_phantom.eps')