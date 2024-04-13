function run_project3
    % Parameters
    beta = 0.02; % Transmission rate (interference parameter)
    gamma = 0.10; % Recovery rate
    delta = 0.00115; % Fatality rate
    epsilon = 0.01; % Waning Immunity rate
    q = 0.1; % Quarantine effectiveness
    v = 0.02; % Vaccination rate

    % Initial conditions (percentages)
    S0 = 99;
    I0 = 1;
    R0 = 0;
    D0 = 0;

    % Time span for simulation
    tspan = [0 160];

    sens_parameters = [beta, gamma, delta, epsilon, q, v, S0, I0, R0, D0, tspan];

    % No quarantine, no vaccination model
    [t, Y] = ode45(@(t, Y) modelNoQuarantineNoVaccination(t, Y, beta, gamma, delta, epsilon), tspan, [S0; I0; R0; D0]);
    stackedPlots(t, Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'No Quarantine, No Vaccination');
    displaySensitivities('NQNV', beta, gamma, delta, epsilon, q, v);

    % Quarantine, no vaccination model
    [t, Y] = ode45(@(t, Y) modelQuarantineNoVaccination(t, Y, beta, gamma, delta, epsilon, q), tspan, [S0; I0; R0; D0]);
    stackedPlots(t, Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'Quarantine, No Vaccination');
    displaySensitivities('QNV', beta, gamma, delta, epsilon, q, v);

    % No quarantine, with vaccination model
    [t, Y] = ode45(@(t, Y) modelNoQuarantineVaccination(t, Y, beta, gamma, delta, epsilon, v), tspan, [S0; I0; R0; D0]);
    stackedPlots(t, Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'No Quarantine, With Vaccination');
    displaySensitivities('NQV', beta, gamma, delta, epsilon, q, v);

    % Quarantine and vaccination model
    [t, Y] = ode45(@(t, Y) modelQuarantineVaccination(t, Y, beta, gamma, delta, epsilon, q, v), tspan, [S0; I0; R0; D0]);
    stackedPlots(t, Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'Quarantine and Vaccination');
    displaySensitivities('QV', beta, gamma, delta, epsilon, q, v);

    run_sensitivity_analysis(sens_parameters)

    clear all
end