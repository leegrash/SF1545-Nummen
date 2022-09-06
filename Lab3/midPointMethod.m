function midPointMethod
    %Startvärden
    steps = 500000; % Antal steg
    h = 0.0005; % Steglängd
    q = zeros(2, steps);
    p = zeros(2, steps);

    % Begynnelsevärden
    a = 0.5;

    q(:, 1) = [1-a; 0];
    p(:, 1) = [0; sqrt((1+a)/(1-a))];

    data = zeros(4,steps);
    data(:,1) = [q(1);q(2);p(1);p(2)];

    %Mittpunkt med fixpunktmetoden
    tol = 1e-9; % fixspunktstolerans

    for i=1:steps-1
        % Vi gissar på värdet från framåt euler till fixpunktsmetoden
        fix = data(:,i) + keplerProblem2(data(3,i), data(4,i), data(1,i), data(2,i))*h; 

        while max(abs(data(:,i) + keplerProblem2(((fix(3)+data(3,i))*(1/2)), ((fix(4)+data(4,i))*(1/2)), ((fix(1)+data(1,i))*(1/2)), ((fix(2)+data(2,i))*(1/2)))*h - fix)) > tol
            fix = data(:,i) + keplerProblem2(((fix(3)+data(3,i))*(1/2)), ((fix(4)+data(4,i))*(1/2)), ((fix(1)+data(1,i))*(1/2)), ((fix(2)+data(2,i))*(1/2)))*h;
        end

        data(:,i+1) = fix;
    end

    q(1, :) = data(1,:);
    q(2, :) = data(2,:);
    p(1, :) = data(3,:);
    p(2, :) = data(4,:);
    figure(3)
    plot(q(1, :),q(2, :))
    axis equal

    plotEnergy(p(1, :), p(2, :), q(1, :), q(2, :), h, steps);
end
