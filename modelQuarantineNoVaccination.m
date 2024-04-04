function dYdt = modelQuarantineNoVaccination(t, Y, beta, gamma, delta, q)
    S = Y(1);
    I = Y(2);
    R = Y(3);
    % D = Y(4); % Unused in calculations, only for completeness

    dSdt = -beta * q * S * I;
    dIdt = beta * q * S * I - gamma * I - delta * I;
    dRdt = gamma * I;
    dDdt = delta * I;

    dYdt = [dSdt; dIdt; dRdt; dDdt];
end