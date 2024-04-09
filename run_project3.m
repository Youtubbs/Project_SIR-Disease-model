function run_project3
    % Parameters
    beta = 0.02; % Transmission rate (interference parameter)
    gamma = 0.10; % Recovery rate
    delta = 0.00115; % Fatality rate
    epsilon = 0.01; % Waning Immunity rate
    q = 0.1; % Quarantine effectiveness
    v = 0.1; % Vaccination rate

    % Initial conditions (percentages)
    S0 = 99;
    I0 = 1;
    R0 = 0;
    D0 = 0;
    
    % Time span for simulation
    tspan = [0 300];

    % No quarantine, no vaccination model
    [t, Y] = ode45(@(t, Y) modelNoQuarantineNoVaccination(t, Y, beta, gamma, delta, epsilon), tspan, [S0; I0; R0; D0]);
    stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'No Quarantine, No Vaccination');

    % Display sensitivities for No quarantine, no vaccination model
    fprintf('Sensitivities for No Quarantine, No Vaccination Model:\n');
    displaySensitivities(t, Y, beta, gamma, delta, epsilon, q, v);

    % Quarantine, no vaccination model
    [t, Y] = ode45(@(t, Y) modelQuarantineNoVaccination(t, Y, beta, gamma, delta, epsilon, q), tspan, [S0; I0; R0; D0]);
    stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'Quarantine, No Vaccination');

    % Display sensitivities for Quarantine, no vaccination model
    fprintf('\nSensitivities for Quarantine, No Vaccination Model:\n');
    displaySensitivities(t, Y, beta, gamma, delta, epsilon, q, v);

    % No quarantine, with vaccination model
    [t, Y] = ode45(@(t, Y) modelNoQuarantineVaccination(t, Y, beta, gamma, delta, epsilon, v), tspan, [S0; I0; R0; D0]);
    stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'No Quarantine, With Vaccination');

    % Display sensitivities for No quarantine, with vaccination model
    fprintf('\nSensitivities for No Quarantine, With Vaccination Model:\n');
    displaySensitivities(t, Y, beta, gamma, delta, epsilon, q, v);

    % Quarantine and vaccination model
    [t, Y] = ode45(@(t, Y) modelQuarantineVaccination(t, Y, beta, gamma, delta, epsilon, q, v), tspan, [S0; I0; R0; D0]);
    stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'Quarantine and Vaccination');

    % Display sensitivities for Quarantine and vaccination model
    fprintf('\nSensitivities for Quarantine and Vaccination Model:\n');
    displaySensitivities(t, Y, beta, gamma, delta, epsilon, q, v);
end

function displaySensitivities(t, Y, beta, gamma, delta, epsilon, q, v)
    % Compute sensitivities
    sensitivities = findSensitivity(Y', beta, gamma, delta, epsilon, q, v);

    % Define sensitivity parameters
    sensitivityParameters = {'Beta', 'Gamma', 'Delta', 'Epsilon', 'Q', 'V'};

    % Display sensitivities in a table format
    sensitivityTable = table(sensitivityParameters', sensitivities.dSdt', sensitivities.dIdt', sensitivities.dRdt', sensitivities.dDdt');
    sensitivityTable.Properties.VariableNames = {'Sensitivity_Parameters', 'dSdt', 'dIdt', 'dRdt', 'dDdt'};

    disp(sensitivityTable);
end