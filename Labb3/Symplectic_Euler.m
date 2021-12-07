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
    for i = 1:steps
        [p_prim_1, p_prim_2] = keplerproblem(q_1(i), q_2(i));
        p_1(i+1) = p_1(i) + p_prim_1*h;
        p_2(i+1) = p_2(i) + p_prim_2*h;
        q_1(i+1) = q_1(i) + p_1(i)*h;
        q_2(i+1) = q_2(i) + p_2(i)*h;
    end
    p_1(i+1) = p_1(i) + p_prim_1*h;
    p_2(i+1) = p_2(i) + p_prim_2*h;
    q_1(i+1) = q_1(i) + p_1(i+1)*h; 
    q_2(i+1) = q_2(i) + p_2(i+1)*h;
end

plot(q_1, q_2)
