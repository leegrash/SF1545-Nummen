clear all
close all

%H�r definieras stegl�ngd ("h") och antal steg ("steps")
h = 0.0005;
steps = 500000;

%H�r skapas matriser f�r p och q vektorerna
p = zeros(2, steps);
q = zeros(2, steps);
p_prim = zeros(2, steps);

%H�r definieras begynnelsev�rden
a = 0.5; %excentriteten
p(1,1) = 0; %startv�rde p1
p(2,1) = sqrt((1+a)/(1-a)); %startv�rde p2
q(1,1) = 1-a; %startv�rde q1
q(2,1) = 0; %startv�rde q2


%H�r skapas Fram�t Euler funktionen
for i = 1:steps-1
    [p_prim(1, i), p_prim(2, i)] = keplerproblem(q(1, i), q(2, i));
 
    p(:, i+1) = p(:, i) + p_prim(:, i)*h; 
    q(:, i+1) = q(:, i) + p(:, i)*h;
end

plot(q(1,:), q(2,:))

