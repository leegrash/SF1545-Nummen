function plotEnergy(p1, p2, q1, q2, h, steps)
    figure
    f = @(p1, p2, q1, q2) 1/2*(p1.^2 + p2.^2)-1./sqrt(q1.^2+q2.^2);

    t = h:h:h*steps;

    points = f(p1, p2, q1, q2);

    plot(t, points)
end
