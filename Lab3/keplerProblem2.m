function [N] = keplerProblem2(p1, p2, q1, q2)
    %Formeln nedan är keplerproblemet, och är given i uppgiften
    p1 = p1;
    p2 = p2;
    pPrim1 = (-q1/(((q1^2)+(q2^2))^(3/2)));
    pPrim2 = (-q2/(((q1^2)+(q2^2))^(3/2)));
    N = [p1; p2; pPrim1; pPrim2];
end
