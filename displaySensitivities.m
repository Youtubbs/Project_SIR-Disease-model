function displaySensitivities(model, beta, gamma, delta, epsilon, q, v)
    fprintf('\nSensitivities for %s Model:\n', model);
    sensitivities = findSensitivity(model, beta, gamma, delta, epsilon, q, v);
    
    sensitivityParameters = {'Beta', 'Gamma', 'Delta', 'Epsilon', 'Q', 'V'};
    sensitivityTable = array2table(sensitivities, 'RowNames', {'dSdt', 'dIdt', 'dRdt', 'dDdt'}, 'VariableNames', sensitivityParameters);
    
    disp(sensitivityTable);
end