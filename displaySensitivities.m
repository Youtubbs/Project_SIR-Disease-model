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