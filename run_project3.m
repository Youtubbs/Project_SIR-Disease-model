% Main script to model the spread of a virus and the impact of various interventions

% Define parameters
beta = 0.02;     % Transmission rate
gamma = 0.1;     % Recovery rate
sigma = 0.01;    % Loss of immunity rate
mu = 0.00115;    % Fatality rate
alpha = 0.02;    % Rate of returning to susceptible after losing immunity

S0 = 1950;       % Initial susceptible population
I0 = 50;         % Initial infected population
R0 = 0;          % Initial recovered population
D0 = 0;          % Initial dead population
Q0 = 0;          % Initial quarantined population

% Time span for simulation
tspan = [0 365*3];

% No quarantine, no vaccination model
[t, Y] = ode45(@(t, Y) noQuarantineNoVaccination(t, Y, beta, gamma, mu), tspan, [S0; I0; R0; D0]);
stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'No Quarantine, No Vaccination');

% Quarantine, no vaccination model
[t, Y] = ode45(@(t, Y) quarantineNoVaccination(t, Y, beta, gamma, mu, alpha), tspan, [S0; I0; R0; D0; Q0]);
stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased', 'Quarantined'}, 'Quarantine, No Vaccination');

% No quarantine, with vaccination model
[t, Y] = ode45(@(t, Y) noQuarantineVaccination(t, Y, beta, gamma, mu, alpha), tspan, [S0; I0; R0; D0]);
stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased'}, 'No Quarantine, With Vaccination');

% Quarantine and vaccination model
[t, Y] = ode45(@(t, Y) quarantineVaccination(t, Y, beta, gamma, mu, alpha), tspan, [S0; I0; R0; D0; Q0]);
stackedPlots(Y', {'Susceptible', 'Infected', 'Recovered', 'Deceased', 'Quarantined'}, 'Quarantine and Vaccination');