function plotEnergy(p_1, p_2, q_1, q_2, h, steps)
    figure
    f = @(p_1, p_2, q_1, q_2) 1/2*(p_1.^2 + p_2.^2)-1./sqrt(q_1.^2+q_2.^2);

    t = h:h:h*steps;

    points = f(p_1, p_2, q_1, q_2);

    plot(t, points)
end
