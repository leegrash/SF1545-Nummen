function forwardEuler
    %Här definieras steglängd ("h") och antal steg ("steps")
    h = 0.0005;
    steps = 5000000;

    %Här skapas matriser för p och q vektorerna
    p = zeros(2, steps);
    q = zeros(2, steps);
    pPrim = zeros(2, steps);

    %Här definieras begynnelsevärden
    a = 0.5; %excentriteten
    p(1,1) = 0; %startvärde p1
    p(2,1) = sqrt((1+a)/(1-a)); %startvärde p2
    q(1,1) = 1-a; %startvärde q1
    q(2,1) = 0; %startvärde q2


    %Här skapas Framåt Euler funktionen
    for i = 1:steps-1
        [pPrim(1, i), pPrim(2, i)] = keplerProblem1(q(1, i), q(2, i));

        p(:, i+1) = p(:, i) + pPrim(:, i)*h; 
        q(:, i+1) = q(:, i) + p(:, i)*h;
    end

    plot(q(1,:), q(2,:))
    axis equal
    plotEnergy(p(1,:),p(2,:),q(1,:),q(2,:), h, steps)
end
