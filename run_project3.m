function run_project3
    % Parameters
    beta = 0.02; % Transmission rate (interference parameter)
    gamma = 0.10; % Recovery rate
    delta = 0.00115; % Fatality rate
    q = 0.5; % Quarantine effectiveness
    v = 0.1; % Vaccination rate

    % Initial conditions (percentages)
    S0 = 99;
    I0 = 1;
    R0 = 0;
    D0 = 0;
    
    % Time span for simulation
    tspan = [0 365*3];

    % No quarantine, no vaccination model
    [t, Y] = ode45(@(t, Y) modelNoQuarantineNoVaccination(t, Y, beta, gamma, delta), tspan, [S0; I0; R0; D0]);
    stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'No Quarantine, No Vaccination');

    % Quarantine, no vaccination model
    [t, Y] = ode45(@(t, Y) modelQuarantineNoVaccination(t, Y, beta, gamma, delta, q), tspan, [S0; I0; R0; D0]);
    stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'Quarantine, No Vaccination');

    % No quarantine, with vaccination model
    [t, Y] = ode45(@(t, Y) modelNoQuarantineVaccination(t, Y, beta, gamma, delta, v), tspan, [S0; I0; R0; D0]);
    stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'No Quarantine, With Vaccination');

    % Quarantine and vaccination model
    [t, Y] = ode45(@(t, Y) modelQuarantineVaccination(t, Y, beta, gamma, delta, q, v), tspan, [S0; I0; R0; D0]);
    stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'Quarantine and Vaccination');
end

function [shandle, chandle] = stackedPlots(A, labels, plotTitle)
    [m,n] = size(A);
    C = cumsum(A, 1);
    color_str = 'brgcmky';

    ind = 0:n-1;
    xx = [ind, fliplr(ind)];

    shandle = figure;
    hold off;

    ww = zeros(1,n);
    for func = 1:m
        yy = C(func,:);
        plot(ind, yy, color_str(mod(func-1, length(color_str))+1), 'HandleVisibility', 'off');
        inbetween = [ww, fliplr(yy)];
        fill(xx, inbetween, color_str(mod(func-1, length(color_str))+1));
        hold on;
        ww = yy;
    end
    xlim([ind(1), ind(end)]);
    ylim([0, max(max(C))]);
    title(plotTitle);
    legend(labels, 'Location', 'best');

    chandle = figure;
    hold off;

    for func = 1:m
        yy = A(func,:);
        plot(ind, yy, color_str(mod(func-1, length(color_str))+1), 'LineWidth', 2);
        hold on;
    end

    xlim([ind(1), ind(end)]);
    ylim([0, max(max(A))]);
    title(plotTitle);
    legend(labels, 'Location', 'best');
end
