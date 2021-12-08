function [N] = keplerProblem2(t, p_1, p_2, q_1, q_2)
    %Formeln nedan är keplerproblemet, och är given i uppgiften
    p_1 = p_1;
    p_2 = p_2;
    p_prim_1 = (-q_1/(((q_1^2)+(q_2^2))^(3/2)));
    p_prim_2 = (-q_2/(((q_1^2)+(q_2^2))^(3/2)));
    N = [p_1; p_2; p_prim_1; p_prim_2];
end
