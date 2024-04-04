function dYdt = modelQuarantineVaccination(t, Y, beta, gamma, delta, q, v)
    S = Y(1);
    I = Y(2);
    R = Y(3);
    % D = Y(4); % Unused in calculations, only for completeness

    dSdt = -beta * q * S * I - v * S;
    dIdt = beta * q * S * I - gamma * I - delta * I;
    dRdt = gamma * I + v * S;
    dDdt = delta * I;

    dYdt = [dSdt; dIdt; dRdt; dDdt];
end