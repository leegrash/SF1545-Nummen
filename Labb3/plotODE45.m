%Begynnelsevärden
h = 0.5;

tend = 2500;

q1 = 1-h;
q2 = 0;
p1 = 0;
p2 = sqrt((1+h)/(1-h));
y0 = [q1;q2;p1;p2];

[t,y] = ode45(@ODEFun,[0 tend],y0);

figure(1)
plot(y(:,1),y(:,2))