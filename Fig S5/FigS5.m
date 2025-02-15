%%
clear all
close all
load("figs5.mat")
col=['#0072BD'	'#D95319'	'#EDB120' '#77AC30']
col2=["#0072BD"	"#D95319"	"#EDB120" "#77AC30"]
[0.4940 0.1840 0.5560]
for i=1:1:4
b=squeeze(detrend(mean(b1(:,:,:,i),3)))
p1io=mean(b, 2)';
   p1stdio=std(b, 0, 2)'/sqrt(7);
    time_vector2 = (0:size(b,1)-1) / 10 - 2;  % Adjust as needed

    Xvals2 = [time_vector2, fliplr(time_vector2)];
    Yvals2 = [ p1io + p1stdio, fliplr( p1io - p1stdio)];
   



        hold on;
    plot(time_vector2, p1io, 'LineWidth', 2, 'Color', col2(i));
    fill(Xvals2, Yvals2, hex2rgb(char(col2(i))), 'EdgeColor','none', 'FaceAlpha', 0.2);

    ylabel('\Delta OD (IOS)');
    set(gca);
   axis tight
    % ylim([-0.013, 0.02]*1.2);
    % Shared x-axis, from -2 to 6 seconds
    xlabel('Time (s)');
    xlim([-1, 4]);

    hold on
end
legend('Awake','','1% Iso','', '1.5% Iso', '','3% Iso','')
 %%
saveas(gcf, 'Iso.eps', 'epsc')
saveas(gcf, 'Iso.png')
saveas(gcf, 'Iso.fig')
exportgraphics(gca,'Iso.eps')
