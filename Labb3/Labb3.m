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
    
    p_next = zeros(2, steps);
    q_next = zeros(2, steps);
    
    %M = zeros(4, steps); %En matris för alla värden p och q
    %M(:, 1) = [q(1, 1), q(2, 1), p(1, 1), p(2, 1)];

    %Bakåt Euler funktion
    for i = 1:steps-1
        p_next = p(:, i) + keplerproblem(q(1), q(2))*h;
        q_next = q(:, i) + p*h;
        %M_new = M(:, i) + keplerproblem2(M(3), M(4), M(1), M(2), h);

        %Notera att fixpunktsmetoden används
        for j = 1:20   
            p_next = p(:, i) + keplerproblem(q_next(1), q_next(2))*h;
            q_next = q(:, i) + p_next*h;
            %M_new = M(:, i) + keplerproblem2(M_new(3), M_new(4), M_new(1), M_new(2), h);
        end

        p(:, i+1) = p_next;
        q(:, i+1) = q_next;
        i
    end

    %Plottar q-vektorn (planetbanan)
    plot(q(1,:), q(2,:))
    
    %energy(p_1, p_2, q_1, q_2, h, steps);
end

function midPointMethod
    h = 0.001; % steglängd 
    s = 90000; 
    tol = 1e-10;
    u = zeros(4,s);
    
    % Begynnelsevärden
    a=0.5;
    u(:,1)=[1-a; 
        0; 
        0; 
        sqrt((1+a)/(1-a))];
    f = @(q1,q2,p1,p2,q3,q4,p3,p4) [1/2*(h*p1+h*p3);
        1/2*(h*p2+h*p4);
        h*(-1/2*(q1+q3)/((1/2*(q1+q3))^2+(1/2*(q2+q4))^2)^(3/2));
        h*(-1/2*(q2+q4)/((1/2*(q1+q3))^2+(1/2*(q2+q4))^2)^(3/2))];

    for i=2:s
        w = u(:,i-1);
        while max(abs(u(:,i-1) +f(w(1),w(2),w(3),w(4),u(1,i-1),u(2,i-1),u(3,i-1), u(4,i-1))-w))> tol
            w = u(:,i-1) + f(w(1),w(2),w(3),w(4),u(1,i-1),u(2,i-1),u(3,i-1),u(4,i-1));
        end
        u(:,i)=w;
    end
    q1=u(1,:);
    q2=u(2,:);
    plot(q1,q2)
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


%funktionen för Keplerproblemet
function [N] = keplerproblem2(p_1, p_2, q_1, q_2, h)
%Formeln nedan är keplerproblemet, och är given i uppgiften
    p_1 = p_1*h;
    p_2 = p_2*h;
    p_prim_1 = (-q_1/(((q_1^2)+(q_2^2))^(3/2)))*h;
    p_prim_2 = (-q_2/(((q_1^2)+(q_2^2))^(3/2)))*h;
    N = [p_1; p_2; p_prim_1; p_prim_2];
end
