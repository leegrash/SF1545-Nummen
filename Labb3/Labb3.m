function Labb3
    %forwardEuler()
    %backwardEuler()
    symplecticEuler()
end

function forwardEuler
    %Här definieras steglängd ("h") och antal steg ("steps")
    h = 0.0005;
    steps = 500000;

    %Här skapas matriser för svaren p_1, p_2, q_1 och q_2
    p_1 = zeros(1, steps);
    p_2 = zeros(1, steps);
    q_1 = zeros(1, steps);
    q_2 = zeros(1, steps);

    %Här definieras begynnelsevärden
    a = 0.5; %excentriteten
    p_1(1) = 0;
    p_2(1) = sqrt((1+a)/(1-a));
    q_1(1) = 1-a;
    q_2(1) = 0;


    %Här skapas Framåt Euler funktionen
    for i = 1:steps
        [p_prim_1, p_prim_2] = keplerproblem(q_1(i), q_2(i));
        p_1(i+1) = p_1(i) + p_prim_1*h;
        p_2(i+1) = p_2(i) + p_prim_2*h;
        q_1(i+1) = q_1(i) + p_1(i)*h;
        q_2(i+1) = q_2(i) + p_2(i)*h;
    end

    plot(q_1, q_2)
    axis equal
    
    energy(p_1, p_2, q_1, q_2, h, steps);
end

function backwardEuler
    %Här definieras steglängd ("h") och antal steg ("steps") och tol
    h = 0.0005;
    steps = 500000;
    tol = 1e-2;

    %Här skapas matriser för svaren p_1, p_2, q_1 och q_2
    p_1 = zeros(1, steps);
    p_2 = zeros(1, steps);
    q_1 = zeros(1, steps);
    q_2 = zeros(1, steps);

    %Här definieras begynnelsevärden
    a = 0.5; %excentriteten
    p_1(1) = 0;
    p_2(1) = sqrt((1+a)/(1-a));
    q_1(1) = 1-a;
    q_2(1) = 0;

    %Här skapas Framåt Euler funktionen
    for i = 1:steps
        p_1_next = p_1(i);
        p_2_next = p_2(i);
        q_1_next = q_1(i);
        q_2_next = q_2(i);
        
        for j = 1:100 
            [p_prim_1, p_prim_2] = keplerproblem(q_1(i), q_2(i));
            q_1_next = q_1(i) + p_1(i)*h;
            q_2_next = q_2(i) + p_2(i)*h;
            p_1_next = p_1(i) + p_prim_1*h;
            p_2_next = p_2(i) + p_prim_2*h;            
        end
        
        p_1(i+1) = p_1_next;
        p_2(i+1) = p_2_next;
        q_1(i+1) = q_1_next;
        q_2(i+1) = q_2_next;
        
    end

    plot(q_1, q_2)
    axis equal
    
    energy(p_1, p_2, q_1, q_2, h, steps);
end

function symplecticEuler
    clear all
    close all

    %Här definieras steglängd ("h") och antal steg ("steps")
    h = 0.0005;
    steps = 500000;

    %Här definieras begynnelsevärden
    a = 0.5; %excentriteten
    p_1(1) = 0;
    p_2(1) = sqrt((1+a)/(1-a));
    q_1(1) = 1-a;
    q_2(1) = 0;


    %Här skapas den Symplektiska-Euler funktionen

    for i=1:steps
        [p_prim_1, p_prim_2] = keplerproblem(q_1(i), q_2(i));
        p_1(i+1) = p_1(i) + p_prim_1*h;
        p_2(i+1) = p_2(i) + p_prim_2*h;
        q_1(i+1) = q_1(i) + p_1(i+1)*h; 
        q_2(i+1) = q_2(i) + p_2(i+1)*h;
    end

    plot(q_1, q_2)
    energy(p_1, p_2, q_1, q_2, h, steps);
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
    
    t = 0:h:h*steps;
    
    points = f(p_1, p_2, q_1, q_2);
    
    plot(t, points)
end
