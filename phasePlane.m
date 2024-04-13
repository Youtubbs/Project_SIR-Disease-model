% Used this source as an aid in making this. :
% http://matlab.cheme.cmu.edu/2011/08/09/phase-portraits-of-a-system-of-odes/
function phasePlane(dxdt, dydt, x_bound, y_bound, solutions, x_name, y_name, num_arrows)
    if x_bound(1)>=x_bound(2) || y_bound(1)>=y_bound(2) || num_arrows<=0
        error('Please check inputs into phasePlane.')
    end

    % Declare symbolic variables
    syms x y

    % Arrows are put into a grid between ranges [x1,x2] and [y1,y2]. The
    % number of arrows per row/column is sqrt(num_arrows). 
    num_arrows_per_row = ceil(sqrt(num_arrows));
    
    % Convert symbolic expressions to functions
    dxdt_fun = matlabFunction(dxdt, 'Vars', [x, y]);
    dydt_fun = matlabFunction(dydt, 'Vars', [x, y]);

    % Create mesh grid for phase plane
    x_range = linspace(x_bound(1), x_bound(2), num_arrows_per_row);
    y_range = linspace(y_bound(1), y_bound(2), num_arrows_per_row);
    [X, Y] = meshgrid(x_range, y_range);

    % Compute vector field
    U = zeros(size(X));
    V = zeros(size(Y));
    for i = 1:numel(X)
        U(i) = dxdt_fun(X(i), Y(i));
        V(i) = dydt_fun(X(i), Y(i));
    end

    % Plot vector field with black arrows
    quiver(X, Y, U, V, 'k');
    hold on;
    grid on;

    % Solve for equilibrium points (where dxdt and dydt are both 0)
    [eqX, eqY] = solve([dxdt == 0, dydt == 0], [x, y], 'Real', true);
    eqX = double(eqX);
    eqY = double(eqY);

    % Plot equilibrium points
    plot(eqX, eqY, 'ro', 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k', 'MarkerSize', 8);

    % Plot solutions
    for i = 1:size(solutions, 1)
        % Solve ODEs for each initial condition
        [T, Ys] = ode45(@(t, Y) [dxdt_fun(Y(1), Y(2)); dydt_fun(Y(1), Y(2))], [0, num_arrows_per_row], solutions(i, :));
        plot(Ys(:,1), Ys(:,2), 'r');
    end
    
    xlim(x_bound);
    ylim(y_bound);
    xlabel(x_name);
    ylabel(y_name);
    title('Phase Plane');
    hold off;
end