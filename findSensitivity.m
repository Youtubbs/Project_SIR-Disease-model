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

    % Initialize the matrix for sensitivities
    sensitivities = sym(zeros(4, 6));
    params = [beta_s, gamma_s, delta_s, epsilon_s, q_s, v_s];

    for i = 1:length(params)
        sensitivities(1, i) = diff(dSdt, params(i)) * params(i) / dSdt;
        sensitivities(2, i) = diff(dIdt, params(i)) * params(i) / dIdt;
        sensitivities(3, i) = diff(dRdt, params(i)) * params(i) / dRdt;
        sensitivities(4, i) = diff(dDdt, params(i)) * params(i) / dDdt;
    end

    % Substitute numeric values for symbols
    sensitivities = subs(sensitivities, [S, I, R, beta_s, gamma_s, delta_s, epsilon_s, q_s, v_s], [100, 1, 0, beta, gamma, delta, epsilon, q, v]);
    sensitivities = double(sensitivities);
end