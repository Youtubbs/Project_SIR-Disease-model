% Differential equations for no quarantine and vaccination scenario
function dYdt = noQuarantineVaccination(t, Y, beta, gamma, mu, alpha)
    S = Y(1);
    I = Y(2);
    R = Y(3);
    D = Y(4);
    dSdt = -beta * S * I;
    dIdt = beta * S * I - gamma * I - mu * I;
    dRdt = gamma * I - alpha * R;
    dDdt = mu * I;
    dYdt = [dSdt; dIdt; dRdt; dDdt];
end