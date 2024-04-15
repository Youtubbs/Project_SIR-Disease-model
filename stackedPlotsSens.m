function stackedPlotsSens(t, Y, modelName, variation, isStacked)
    labels = {'Susceptible', 'Infected', 'Recovered', 'Deceased'};
    color_str = 'brgcmky'; % Color string for different plot lines

    if isStacked
        % Stacked plot
        A = cumsum(Y, 1); % Cumulative sum for stacking
    else
        % Regular plot
        A = Y;
    end

    [m, n] = size(A);
    xx = [t', fliplr(t')]; % For area plot filling

    for func = 1:m
        yy = A(func, :);
        if isStacked
            % Stacked area plot
            if func == 1
                fill(xx, [zeros(1, length(t)), fliplr(yy)], color_str(func), 'LineStyle', 'none');
            else
                yy_below = A(func - 1, :);
                fill(xx, [yy_below, fliplr(yy)], color_str(func), 'LineStyle', 'none');
            end
        else
            % Regular line plot
            plot(t, yy, color_str(mod(func - 1, length(color_str)) + 1), 'LineWidth', 2);
        end
        hold on;
    end

    % Annotate the areas for Infected and Deceased if stacked
    if isStacked
        % Infected area between Infected and Susceptible
        infectedArea = trapz(t, A(2, :) - A(1, :));
        % Deceased area between Deceased and Recovered
        deceasedArea = trapz(t, A(4, :) - A(3, :));
        
        text(t(end), A(2, end), sprintf('Infected Area: %.2f', infectedArea), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
        text(t(end), A(4, end), sprintf('Deceased Area: %.2f', deceasedArea), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end

    xlim([t(1), t(end)]);
    ylim([0, max(max(A)) * 1.1]); % Add some margin on top
    title([modelName, ' Variation: ', num2str(variation), '%']);
    legend(labels, 'Location', 'best');
    hold off;
end
