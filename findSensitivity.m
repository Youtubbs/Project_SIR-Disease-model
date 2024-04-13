function sensitivities = findSensitivity(model, beta, gamma, delta, epsilon, q, v)
    syms beta_s gamma_s delta_s epsilon_s q_s v_s S I R

    switch model
        case 'NQNV'
            dSdt = -beta_s * S * I + epsilon_s * R;
            dIdt = beta_s * S * I - gamma_s * I - delta_s * I;
            dRdt = gamma_s * I - epsilon_s * R;
            dDdt = delta_s * I;
        case 'QNV'
            dSdt = -beta_s * q_s * S * I + epsilon_s * R;
            dIdt = beta_s * q_s * S * I - gamma_s * I - delta_s * I;
            dRdt = gamma_s * I - epsilon_s * R;
            dDdt = delta_s * I;
        case 'NQV'
            dSdt = -beta_s * S * I - v_s * S + epsilon_s * R;
            dIdt = beta_s * S * I - gamma_s * I - delta_s * I;
            dRdt = gamma_s * I + v_s * S - epsilon_s * R;
            dDdt = delta_s * I;
        case 'QV'
            dSdt = -beta_s * q_s * S * I - v_s * S + epsilon_s * R;
            dIdt = beta_s * q_s * S * I - gamma_s * I - delta_s * I;
            dRdt = gamma_s * I + v_s * S - epsilon_s * R;
            dDdt = delta_s * I;
    end

    params = [beta_s, gamma_s, delta_s, epsilon_s, q_s, v_s];
    % Prepare the expression substituion for initial condition values and parameter values
    subs_values = [100, 1, 1, beta, gamma, delta, epsilon, q, v];  % Set R to 1 to avoid division by zero issues

    % Calculate sensitivities and handle cases where the denominator is zero
    sensitivities = sym(zeros(4, length(params)));
    for i = 1:length(params)
        numeratorS = diff(dSdt, params(i)) * params(i);
        numeratorI = diff(dIdt, params(i)) * params(i);
        numeratorR = diff(dRdt, params(i)) * params(i);
        numeratorD = diff(dDdt, params(i)) * params(i);

        % Substitute numeric values for symbols
        sensitivities(1, i) = subs(numeratorS / dSdt, [S, I, R, beta_s, gamma_s, delta_s, epsilon_s, q_s, v_s], subs_values);
        sensitivities(2, i) = subs(numeratorI / dIdt, [S, I, R, beta_s, gamma_s, delta_s, epsilon_s, q_s, v_s], subs_values);
        sensitivities(3, i) = subs(numeratorR / dRdt, [S, I, R, beta_s, gamma_s, delta_s, epsilon_s, q_s, v_s], subs_values);
        sensitivities(4, i) = subs(numeratorD / dDdt, [S, I, R, beta_s, gamma_s, delta_s, epsilon_s, q_s, v_s], subs_values);
    end

    % Convert to double
    sensitivities = double(sensitivities);
end
