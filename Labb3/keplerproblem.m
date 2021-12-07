%funktionen f�r Keplerproblemet
function [p_prim_1, p_prim_2] = keplerproblem(q_1, q_2)
%Formeln nedan �r keplerproblemet, och �r given i uppgiften
    p_prim_1 = -q_1/(((q_1^2)+(q_2^2))^(3/2));
    p_prim_2 = -q_2/(((q_1^2)+(q_2^2))^(3/2));
end