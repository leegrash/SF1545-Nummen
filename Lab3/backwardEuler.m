function backwardEuler
    %Här definieras steglängd ("h"), antal steg ("steps") 
    h = 0.0005;
    steps = 350000;

    %Här skapas matriser för p och q vektorerna
    p = ones(2, steps);
    q = ones(2, steps);

    %Här definieras begynnelsevärden
    a = 0.5; %excentriteten
    p(1,1) = 0; %startvärde p1
    p(2,1) = sqrt((1+a)/(1-a)); %startvärde p2
    q(1,1) = 1-a; %startvärde q1
    q(2,1) = 0; %startvärde q2  


    %Bakåt Euler funktion
    for i = 1:steps-1     
        %Notera att fixpunktsmetoden används
        for j = 1:20
            [pPrim(1, i), pPrim(2, i)] = keplerProblem1(q(1, i+1), q(2, i+1));

            p(:, i+1) = p(:, i) + pPrim(:, i)*h;
            q(:, i+1) = q(:, i) + p(:, i+1)*h;
        end
    end

    %Plottar q-vektorn (planetbanan)
    plot(q(1,:), q(2,:))
    axis equal

    plotEnergy(p(1, :), p(2, :), q(1, :), q(2, :), h, steps);
end
