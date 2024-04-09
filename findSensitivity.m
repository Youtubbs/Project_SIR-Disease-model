function sensitivity = findSensitivity(Y, beta, gamma, delta, epsilon, q, v)
    S = Y(1);
    I = Y(2);
    R = Y(3);
    
    % Sensitivity of dS/dt
    dSdt_beta = -S * I;
    dSdt_gamma = 0;
    dSdt_delta = 0;
    dSdt_epsilon = R;
    if q == 0
        dSdt_q = 0;
    else
        dSdt_q = -beta * S * I;
    end
    if v == 0
        dSdt_v = 0;
    else
        dSdt_v = -S;
    end

    % Sensitivity of dI/dt
    dIdt_beta = S * I;
    dIdt_gamma = -I;
    dIdt_delta = -I;
    dIdt_epsilon = 0;
    if q == 0
        dIdt_q = 0;
    else
        dIdt_q = beta * S * I;
    end
    dIdt_v = 0;

    % Sensitivity of dR/dt
    dRdt_beta = 0;
    dRdt_gamma = I;
    dRdt_delta = 0;
    dRdt_epsilon = -R;
    dRdt_q = 0;
    if v == 0
        dRdt_v = 0;
    else
        dRdt_v = S;
    end

    % Sensitivity of dD/dt
    dDdt_beta = 0;
    dDdt_gamma = 0;
    dDdt_delta = I;
    dDdt_epsilon = 0;
    dDdt_q = 0;
    dDdt_v = 0;

    sensitivity = struct('dSdt', [dSdt_beta, dSdt_gamma, dSdt_delta, dSdt_epsilon, dSdt_q, dSdt_v], ...
                         'dIdt', [dIdt_beta, dIdt_gamma, dIdt_delta, dIdt_epsilon, dIdt_q, dIdt_v], ...
                         'dRdt', [dRdt_beta, dRdt_gamma, dRdt_delta, dRdt_epsilon, dRdt_q, dRdt_v], ...
                         'dDdt', [dDdt_beta, dDdt_gamma, dDdt_delta, dDdt_epsilon, dDdt_q, dDdt_v]);
end
