function dYdt = modelNoQuarantineVaccination(t, Y, beta, gamma, delta, epsilon, v)
    S = Y(1);
    I = Y(2);
    R = Y(3);
    % D = Y(4); % Unused in calculations, only for completeness

    dSdt = -beta * S * I - v * S + epsilon * R;
    dIdt = beta * S * I - gamma * I - delta * I;
    dRdt = gamma * I + v * S - epsilon * R;
    dDdt = delta * I;

    dYdt = [dSdt; dIdt; dRdt; dDdt];
end