function run_sensitivity_analysis
    beta = 0.02; % Transmission rate (interference parameter)
    gamma = 0.10; % Recovery rate
    delta = 0.00115; % Fatality rate
    epsilon = 0.01; % Waning Immunity rate
    q = 0.1; % Quarantine effectiveness
    v = 0.01; % Vaccination rate

    % Initial conditions (percentages)
    S0 = 99;
    I0 = 1;
    R0 = 0;
    D0 = 0;

    % Time span for simulation
    tspan = [0 80];

    % Variation range and step
    variation_range = -50:10:50;

    models = {
        @modelNoQuarantineNoVaccination, 
        @modelNoQuarantineVaccination, 
        @modelQuarantineNoVaccination, 
        @modelQuarantineVaccination
    };
    modelNames = {
        'NoQuarantineNoVaccination', 
        'NoQuarantineVaccination', 
        'QuarantineNoVaccination', 
        'QuarantineVaccination'
    };

    % Loop through each model
    for modelIdx = 1:length(models)
        model = models{modelIdx};
        modelName = modelNames{modelIdx};

        % Prepare the animation files
        filenameStacked = sprintf('%s_stacked_sensitivity.gif', modelName);
        filenameRegular = sprintf('%s_regular_sensitivity.gif', modelName);
        overlayFig = figure('visible', 'off');

        % Iterating over variation range
        for variation = variation_range
            % Adjust parameters accordingly
            beta_adj = beta * (1 + variation/100);
            gamma_adj = gamma * (1 + variation/100);
            delta_adj = delta * (1 + variation/100);
            epsilon_adj = epsilon * (1 + variation/100);
            q_adj = q * (1 + variation/100);
            v_adj = v * (1 + variation/100);

            % Solve ODE with adjusted parameters
            if modelIdx == 1
                [t, Y] = ode45(@(t, Y) model(t, Y, beta_adj, gamma_adj, delta_adj, epsilon_adj), tspan, [S0; I0; R0; D0]);
            elseif modelIdx == 2
                [t, Y] = ode45(@(t, Y) model(t, Y, beta_adj, gamma_adj, delta_adj, epsilon_adj, v_adj), tspan, [S0; I0; R0; D0]);
            elseif modelIdx == 3
                [t, Y] = ode45(@(t, Y) model(t, Y, beta_adj, gamma_adj, delta_adj, epsilon_adj, q_adj), tspan, [S0; I0; R0; D0]);
            else
                [t, Y] = ode45(@(t, Y) model(t, Y, beta_adj, gamma_adj, delta_adj, epsilon_adj, q_adj, v_adj), tspan, [S0; I0; R0; D0]);
            end

            % Plot for stacked GIF
            figStacked = figure('visible', 'off');
            stackedPlotsSens(t, Y', modelName, variation, true);
            saveGifFrame(figStacked, filenameStacked, variation == variation_range(1));

            % Plot for regular GIF
            figRegular = figure('visible', 'off');
            stackedPlotsSens(t, Y', modelName, variation, false);
            saveGifFrame(figRegular, filenameRegular, variation == variation_range(1));

            % Close figures to prevent buildup
            close(figStacked);
            close(figRegular);
        end
    end
end

function saveGifFrame(fig, filename, firstFrame)
    drawnow;
    frame = getframe(fig);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    if firstFrame
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf);
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append');
    end
end

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

    xlim([t(1), t(end)]);
    ylim([0, max(max(A)) * 1.1]); % Add some margin on top
    title([modelName, ' Variation: ', num2str(variation), '%']);
    legend(labels, 'Location', 'best');
    hold off;
end