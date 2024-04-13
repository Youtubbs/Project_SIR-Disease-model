function [shandle, chandle] = stackedPlots(t, A, labels, plotTitle)
    [m,n] = size(A);
    C = cumsum(A, 1);
    color_str = 'brgcmky';

    xx = [t', fliplr(t')];

    shandle = figure;
    hold off;

    ww = zeros(1, n);
    for func = 1:m
        yy = C(func,:);
        plot(t, yy, color_str(mod(func-1, length(color_str))+1), 'HandleVisibility', 'off');
        inbetween = [ww, fliplr(yy)];
        fill(xx, inbetween, color_str(mod(func-1, length(color_str))+1));
        hold on;
        ww = yy;
    end
    xlim([t(1), t(end)]);
    ylim([0, max(max(C))]);
    title(plotTitle);
    legend(labels, 'Location', 'best');

    chandle = figure;
    hold off;

    for func = 1:m
        yy = A(func,:);
        plot(t, yy, color_str(mod(func-1, length(color_str))+1), 'LineWidth', 2);
        hold on;
    end

    xlim([t(1), t(end)]);
    ylim([0, max(max(A))]);
    title(plotTitle);
    legend(labels, 'Location', 'best');
end