% Differential equations for quarantine and vaccination scenario
function dYdt = quarantineVaccination(t, Y, beta, gamma, mu, alpha)
    S = Y(1);
    I = Y(2);
    R = Y(3);
    D = Y(4);
    Q = Y(5);
    dSdt = -beta * S * I + alpha * Q;
    dIdt = beta * S * I - gamma * I - mu * I - alpha * I;
    dRdt = gamma * I - alpha * R;
    dDdt = mu * I;
    dQdt = alpha * I - alpha * Q;
    dYdt = [dSdt; dIdt; dRdt; dDdt; dQdt];
end