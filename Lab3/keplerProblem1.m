function [pPrim1, pPrim2] = keplerProblem1(q1, q2)
%Formeln nedan är keplerproblemet, och är given i uppgiften
    pPrim1 = -q1/(((q1^2)+(q2^2))^(3/2));
    pPrim2 = -q2/(((q1^2)+(q2^2))^(3/2));
end