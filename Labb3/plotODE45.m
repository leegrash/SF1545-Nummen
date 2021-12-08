function plotODE45
    %Begynnelsevärden
    h = 0.5;

    tend = 2500;

    q = [1-h; 0];
    p = [0;sqrt((1+h)/(1-h))];
    y0 = [q(1);q(2);p(1);p(2)];

    [t,y] = ode45(@ODEFun,[0 tend],y0);

    figure(1)
    plot(y(:,1),y(:,2))
end
