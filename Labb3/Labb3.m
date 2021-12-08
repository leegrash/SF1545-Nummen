function Labb3
    clear all
    close all
    
    %forwardEuler()
    backwardEuler()
    %midPointMethod()
    %symplecticEuler()
end

function forwardEuler
    %Här definieras steglängd ("h") och antal steg ("steps")
    h = 0.0005;
    steps = 500000;

    %Här skapas matriser för p och q vektorerna
    p = zeros(2, steps);
    q = zeros(2, steps);
    p_prim = zeros(2, steps);

    %Här definieras begynnelsevärden
    a = 0.5; %excentriteten
    p(1,1) = 0; %startvärde p1
    p(2,1) = sqrt((1+a)/(1-a)); %startvärde p2
    q(1,1) = 1-a; %startvärde q1
    q(2,1) = 0; %startvärde q2


    %Här skapas Framåt Euler funktionen
    for i = 1:steps-1
        [p_prim(1, i), p_prim(2, i)] = keplerproblem(q(1, i), q(2, i));

        p(:, i+1) = p(:, i) + p_prim(:, i)*h; 
        q(:, i+1) = q(:, i) + p(:, i)*h;
    end

    plot(q(1,:), q(2,:))
    axis equal
    energy(p(1,:),p(2,:),q(1,:),q(2,:), h, steps)
end

function backwardEuler
    %Här definieras steglängd ("h"), antal steg ("steps") 
    % samt tolerans ("tol")
    h = 0.0005;
    steps = 350000;
    
    %Här skapas matriser för p och q vektorerna
    p = zeros(2, steps);
    q = zeros(2, steps);
    
    %Här definieras begynnelsevärden
    a = 0.5; %excentriteten
    p(1,1) = 0; %startvärde p1
    p(2,1) = sqrt((1+a)/(1-a)); %startvärde p2
    q(1,1) = 1-a; %startvärde q1
    q(2,1) = 0; %startvärde q2  
    
    %M = zeros(4, steps); %En matris för alla värden p och q
    %M(:, 1) = [q(1, 1), q(2, 1), p(1, 1), p(2, 1)];

    %Bakåt Euler funktion
    for i = 1:steps-1
        p_next = p(:, i) + keplerproblem(q(1), q(2))*h;
        q_next = q(:, i) + p(:, i)*h;
        %M_new = M(:, i) + keplerproblem2(M(3), M(4), M(1), M(2), h);

        %Notera att fixpunktsmetoden används
        for j = 1:20   
            p_next = p(:, i) + keplerproblem(q_next(1), q_next(2))*h;
            q_next = q(:, i) + p_next*h;
            %M_new = M(:, i) + keplerproblem2(M_new(3), M_new(4), M_new(1), M_new(2), h);
        end

        p(:, i+1) = p_next;
        q(:, i+1) = q_next;
    end

    %Plottar q-vektorn (planetbanan)
    plot(q(1,:), q(2,:))
    axis equal
    
    %energy(p_1, p_2, q_1, q_2, h, steps);
end

function midPointMethod
    %Startvärden
    steps = 350000; % Antal steg
    h = 0.0005; % Steglängd
    q = zeros(2, steps);
    p = zeros(2, steps);
    
    % Begynnelsevärden
    a = 0.5;
      
    q(:, 1) = [1-a; 0];
    p(:, 1) = [0; sqrt((1+a)/(1-a))];
    
    %q1 = 1-a;
    %q2 = 0;
    %p1 = 0;
    %p2 = sqrt((1+a)/(1-a));
    
    data = zeros(4,steps);
    data(:,1) = [q(1);q(2);p(1);p(2)];
    f = @(a,b,c,d) [h*c;h*d;h*(-a/(((a^2)+(b^2))^(3/2)));h*(-b/(((a^2)+(b^2))^(3/2)))];
    
    %Mittpunkt med fixpunktmetoden
    tol = 10^-9; % fixspunktstolerans
    
    for i=1:steps-1
        % Vi gissar på värdet från framåt euler till fixpunktsmetoden
        fix = data(:,i) + f(data(1,i),data(2,i),data(3,i),data(4,i)); 
        while max(abs(data(:,i)+f(((fix(1)+data(1,i))*(1/2)),((fix(2)+data(2,i))*(1/2)),((fix(3)+data(3,i))*(1/2)),((fix(4)+data(4,i))*(1/2))) - fix)) > tol
            fix = data(:,i) + f(((fix(1)+data(1,i))*(1/2)),((fix(2)+data(2,i))*(1/2)),((fix(3)+data(3,i))*(1/2)),((fix(4)+data(4,i))*(1/2)));
        end
        data(:,i+1) = fix;
    end
    
    q(1, :) = data(1,:);
    q(2, :) = data(2,:);
    figure(3)
    plot(q(1, :),q(2, :))
    axis equal
end

function symplecticEuler
    %Här definieras steglängd ("h") och antal steg ("steps")
    h = 0.0005;
    steps = 500000;


    %Här skapas matriser för p och q vektorerna
    p = zeros(2, steps);
    q = zeros(2, steps);
    p_prim = zeros(2, steps);

    %Här definieras begynnelsevärden
    a = 0.5; %excentriteten
    p(1,1) = 0; %startvärde p1
    p(2,1) = sqrt((1+a)/(1-a)); %startvärde p2
    q(1,1) = 1-a; %startvärde q1
    q(2,1) = 0; %startvärde q2


    %Här skapas den Symplektiska-Euler funktionen

    for i=1:steps-1
        [p_prim(1, i), p_prim(2, i)] = keplerproblem(q(1, i), q(2, i));

        p(:, i+1) = p(:, i) + p_prim(:, i)*h; 
        q(:, i+1) = q(:, i) + p(:, i+1)*h;
    end

    plot(q(1,:), q(2,:))
    energy(p(1,:),p(2,:),q(1,:),q(2,:), h, steps)
end

%funktionen för Keplerproblemet
function [p_prim_1, p_prim_2] = keplerproblem(q_1, q_2)
%Formeln nedan är keplerproblemet, och är given i uppgiften
    p_prim_1 = -q_1/(((q_1^2)+(q_2^2))^(3/2));
    p_prim_2 = -q_2/(((q_1^2)+(q_2^2))^(3/2));
end

%funktion för energi
function energy(p_1, p_2, q_1, q_2, h, steps)
    figure
    f = @(p_1, p_2, q_1, q_2) 1/2*(p_1.^2 + p_2.^2)-1./sqrt(q_1.^2+q_2.^2);
    
    t = h:h:h*steps;
    
    points = f(p_1, p_2, q_1, q_2);
    
    plot(t, points)
end

