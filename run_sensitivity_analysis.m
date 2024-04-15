function run_sensitivity_analysis(sens_parameters)
    beta = sens_parameters(1); % Transmission rate (interference parameter)
    gamma = sens_parameters(2); % Recovery rate
    delta = sens_parameters(3); % Fatality rate
    epsilon = sens_parameters(4); % Waning Immunity rate
    q = sens_parameters(5); % Quarantine effectiveness
    v = sens_parameters(6); % Vaccination rate

    % Initial conditions (percentages)
    S0 = sens_parameters(7);
    I0 = sens_parameters(8);
    R0 = sens_parameters(9);
    D0 = sens_parameters(10);

    % Time span for simulation
    tspan = [sens_parameters(11), sens_parameters(12)];

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
            gamma_adj = gamma; %* (1 + variation/100);
            delta_adj = delta * (1 + variation/100);
            epsilon_adj = epsilon * (1 + variation/100);
            q_adj = q; %* (1 + variation/100);
            v_adj = v; %* (1 + variation/100);

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