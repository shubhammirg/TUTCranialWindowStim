%Kothapalli Lab - Shubham Mirg, Kathiravan Ramiah
% Data Repository: 10.5281/zenodo.14876675, Code Repository:https://github.com/shubhammirg/TUTCranialWindowStim/tree/main
%% Maps and videos
% %% Load Data and Initialize
close all
clear all
figure
load("ios_vid.mat")
fr=10;
t2 = linspace(-2, 6, size(z3,3));
% Create Video Writer for \Delta OD
video1 = VideoWriter('Delta_OD.avi', 'Motion JPEG AVI');
video1.FrameRate = 5; % Set frame rate to 10 FPS
open(video1);

% Process and Save \Delta OD Video
for j = 1:size(z3,3)
        a(:,:) = -log(double(z3(:,:,j)) ./ mean(z3(:,:,1:2*fr), 3)); 
      

    sd_mean_ios(:,:,j) = a;
    img = interp2(imgaussfilt(sd_mean_ios(:,:,j), 1.5));
    
    imagesc(img)
    
    colormap("parula")

    caxis([-0.02 0.04])
  if t2(j)>=0 && t2(j)<=0.25

            title(['Ultrasound on, time =' num2str(t2(j))],'Color','g','FontSize',24)
    else 
       title(['Ultrasound off, time =' num2str(t2(j))],'Color','r','FontSize',24)

  end    
  c=colorbar;
    c.FontSize=20;
  ylabel(c, '\Delta OD','FontSize',20)
    axis image
    axis off
    drawnow()
    
    % Capture and Write Frame to Video
    frame = getframe(gcf);
    writeVideo(video1, frame);
  
end
close(video1);
disp('Delta OD video saved.');

%% Second Part - CBF Video
figure
load('lsci_vid.mat')

fr = 27.39;
cfr = 10;

data = interp2(imgaussfilt(mean(z4(:,:,cfr:cfr+20),3),1.5));
minValue = min(data(:));
maxValue = max(data(:));
centerValue = mean(data(:)) * 1.5;  

% Define a colorblind-friendly colormap
nColors = 256;
nBelow = round((centerValue - minValue) / (maxValue - minValue) * nColors);
nAbove = nColors - nBelow;
cmapBelow = [linspace(0, 1, nBelow)', linspace(0, 1, nBelow)', ones(nBelow, 1)];
cmapAbove = [ones(nAbove, 1), linspace(1, 0, nAbove)', linspace(1, 0, nAbove)'];
cmap = [cmapBelow; cmapAbove];




% Create Video Writer for CBF
video2 = VideoWriter('CBF.avi', 'Motion JPEG AVI');
video2.FrameRate = 27.39/2; % Set frame rate to 10 FPS
open(video2);
% Process and Save CBF Video
for j = 1:size(z4,3)
    x = 1;

        a_lsc(:,:) = z4(:,:,j);

    sd_mean(:,:,j) = a_lsc;

end
sd_mean2 = movmean(sd_mean, 10, 3);
t1 = linspace(-2, 6, size(sd_mean2,3));

for j = 1:size(sd_mean,3)
    imagesc(interp2(imgaussfilt(sd_mean2(:,:,j), 1.5)))
    colorbar;
    colormap(cmap);
    caxis([300 9333]);
    if floor(t1(j) * 10) / 10>=0 && floor(t1(j) * 10) / 10<=0.25

            title(['Ultrasound on, time =' num2str(floor(t1(j) * 10) / 10)],'Color','g', ...
                'FontSize',24)
    else 
       title(['Ultrasound off, time =' num2str(floor(t1(j) * 10) / 10)],'Color','r','FontSize',24)

    end
     c=colorbar;
    c.FontSize=20;
    c.Ticks = [300 9333];
    c.TickLabels={'Low','High'};
    ylabel(c, 'CBF','FontSize',24)
    axis image
    axis off
    drawnow()
    
    % Capture and Write Frame to Video
    frame = getframe(gcf);
    writeVideo(video2, frame);
end
close(video2);
disp('CBF video saved.');
%% Traces

load('lsci.mat') %load processed LSCI data

p1=(mean(a2, 2)');
p1std=std(a2, 0, 2)';
  time_vector = (0:size(a2,1)-1) / 27.39 - 2;  % Adjust as needed
    Xvals = [time_vector, fliplr(time_vector)];
    Yvals = [p1 + p1std, fliplr(p1 - p1std)];
load('iosi.mat')
p1io=mean(b, 2)';
   p1stdio=std(b, 0, 2)';
    time_vector2 = (0:size(b,1)-1) / 10 - 2;  % Adjust as needed

    Xvals2 = [time_vector2, fliplr(time_vector2)];
    Yvals2 = [ p1io + p1stdio, fliplr( p1io - p1stdio)];
   

close all
yyaxis left
    fill(Xvals, Yvals, [0.8 0.8 1], 'EdgeColor','none', 'FaceAlpha', 0.5); 
    hold on;
    plot(time_vector, p1, 'b', 'LineWidth', 2);
    ylabel('\Delta CBF/CBF % (LSCI)');
    set(gca, 'YColor', 'b');

  ylim([-13, 20]*0.7);
    % Right axis: IOS
    yyaxis right
    fill(Xvals2, Yvals2, [1 0.8 0.8], 'EdgeColor','none', 'FaceAlpha', 0.5);
    hold on;
    plot(time_vector2, p1io, 'r', 'LineWidth', 2);
    ylabel('\Delta OD (IOS)');
    set(gca, 'YColor', 'r');
   axis tight
     ylim([-0.013, 0.02]*1.2);
    % Shared x-axis, from -2 to 6 seconds
    xlabel('Time (s)');
    xlim([-1, 4]);

    hold off;
 
%saveas(gcf, 'Combplot.eps', 'epsc')
saveas(gcf, 'Combplot.png')
%saveas(gcf, 'Combplot.fig')
exportgraphics(gca,'Combplot2.eps')

%%
% Generate example data

fs = 10;
p1=(mean(a2, 2)');

% Sampling frequency (Hz)

    figure(2)
 s1=p1io';
  s2=p1';
s3=movmean(resample(s2,100,274),3)
s4=s1(1:size(s3,1))*500 %% Rescale the plot
t = (0:1/fs:size(s3,1)/fs-1/fs)-2;                % Time vector (10 seconds)
signal1 = s3
signal2 = s4
% Signal 2 (uncorrelated, then correlated with lag)

% Parameters for moving window
window_size =1;              % Window size in seconds
step_size = 0.1;              % Step size in seconds
window_samples = window_size * fs;
step_samples = step_size * fs;

% Initialize variables
n_windows = floor((length(t) - window_samples) / step_samples) + 1;
corr_values = nan(1, n_windows);
window_times = nan(1, n_windows);
lag_times = nan(1, n_windows);

for i = 1:n_windows
    % Define window range
    idx_start = (i-1) * step_samples + 1;
    idx_end = idx_start + window_samples - 1;
    if idx_end > length(signal1), break; end
    
    % Extract window data
    segment1 = signal1(idx_start:idx_end);
    segment2 = signal2(idx_start:idx_end);
    
    % Compute cross-correlation and find lag
    [xc, lags] = xcorr(segment1, segment2, 'coeff');
    [max_corr, max_idx] = max(xc);
    lag_samples = lags(max_idx);
    
    % Store results
    corr_values(i) = max_corr;
    window_times(i) = mean(t(idx_start:idx_end));
    lag_times(i) = lag_samples / fs; % Convert lag to seconds
end

% Plot the original signals
plot(window_times, corr_values, '-o','LineWidth',3,'Color','k','MarkerSize',15);
title('Moving Window Correlation');
xlabel('Time (s)');
ylabel('Correlation Coefficient');
ylim([0, 1]);
xlim([-1, 4]);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1])
saveas(gcf, 'Correlation.eps', 'epsc')
saveas(gcf, 'Correlation.png')
saveas(gcf, 'Correlation.fig')
%%
figure
%yyaxis right
plot(window_times, lag_times, '-o','LineWidth',3,'Color','k','MarkerSize',20);
%title('Moving Window Correlation');
xlabel('Time (s)');
ylabel('Lag Time (s)');
%ylim([0, 1]);
xlim([-1, 4]);
% yyaxis left
% plot(window_times, corr_values, '-o','LineWidth',3,'Color','k','MarkerSize',5);

set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1])
saveas(gcf, 'lag.eps', 'epsc')
saveas(gcf, 'lag.png')
saveas(gcf, 'lag.fig')
%%
figure
subplot(3, 1, 1);
plot(t, signal1, 'b', t, signal2, 'r');
title('Original Signals');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Signal 1', 'Signal 2');
xlim([-1, 4]);
% Plot the moving correlation
subplot(3, 1, 2);
plot(window_times, corr_values, '-o');
title('Moving Window Correlation');
xlabel('Time (s)');
ylabel('Correlation Coefficient');
ylim([-1, 1]);
grid on;
xlim([-1, 4]);
% Plot the lag over time
subplot(3, 1, 3);
plot(window_times, lag_times, '-o');
title('Lag Over Time');
xlabel('Time (s)');
ylabel('Lag (s)');
grid on;
xlim([-1, 4]);
