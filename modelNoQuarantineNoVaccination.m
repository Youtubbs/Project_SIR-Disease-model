function dYdt = modelNoQuarantineNoVaccination(t, Y, beta, gamma, delta)
    S = Y(1);
    I = Y(2);
    R = Y(3);
    % D = Y(4); % Unused in calculations, only for completeness

    dSdt = -beta * S * I;
    dIdt = beta * S * I - gamma * I - delta * I;
    dRdt = gamma * I;
    dDdt = delta * I;

    dYdt = [dSdt; dIdt; dRdt; dDdt];
end
