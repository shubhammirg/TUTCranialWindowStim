%%Kothapalli Lab - Shubham Mirg, Kathiravan Ramiah
% Data Repository: 10.5281/zenodo.14876675, Code Repository:https://github.com/shubhammirg/TUTCranialWindowStim/tree/main

files = {'data1.xlsx', 'data2.xlsx', 'data3.xlsx', 'data4.xlsx'};
x_columns = [3, 2, 4, 1]; 
x_labels = {'TBD (\mu s)', 'PRF (Hz)', 'TST (ms)', 'PNP (kPa)'};
y_label = '\DeltaT (°C)';

for i = 1:length(files)
    filename = fullfile(files{i});
    data = readtable(filename);
    
    X = data{:, x_columns(i)};  
    deltaT = data{:, 5};  

    figure;
    plot(X, deltaT, '-ok', 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', 'k');
    axis tight
    ylim([0 1.4])
    for j = 1:length(X)
        text(X(j), deltaT(j), sprintf('%.1f', deltaT(j)), ...
            'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', ...
            'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
    end

    xlabel(x_labels{i});
    ylabel(y_label);
    title(sprintf(' %s vs. %s', y_label, x_labels{i}));
    grid off;
end
