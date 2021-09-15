function Labb1()
   m = input("How many cars? ");
   h = input("h? ");
   iterations = 41;
   % Labb1a()
   %Labb1b(m,h,5,iterations)
   %Labb1b(m,h,25,iterations)
   Labb1c(m ,h,25,iterations)
end

function Labb1a()
    x = -200:400;
    y = arrayfun(@f, x);
    
    plot(x, y)
    xlim([-100, 400])
    ylim([-50, 50])
end

function y = f(x)
    %x
    if x <= 0
        y = 0;
        %"spår 1"
    elseif 0 < x && x < 75
        y = x/3;
       % "spår 2"
    else 
        y = 25;
       % "spår 3"
    end
    
end

function carPos = Labb1b(m ,h , vel,iterations)
  
  carPos = zeros(m , iterations); %placement of cars from 1 to m at time 0 to 40
  carVel = zeros(m , iterations); %speed of cars from 1 to m at time 0 to 40
  t = 1;
  carVel(m , t) = g(vel);
  t = t+1;
  while t <= iterations
    carVel(m , t) = g(vel);
    carPos(m , t) = carPos(m , (t-1)) + h * carVel(m , t-1);
    for i = m-1:-1:1
        carPos(i , t) = carPos(i , (t-1)) + h * carVel(i , t-1);
        carVel(i , t) = f(carPos(i+1 , t)-carPos(i , t));
    end
    t = t + 1;
  end  
  %carVel
end

function Labb1c(m ,h, vel,iterations)
    carPos = Labb1b(m ,h,vel);
    for t = 1:iterations
        plot(carPos(:,t) , zeros(1,m),'r*');
        axis([0 1000 -1 1])
        drawnow
        pause(h)
    end
end

function y = g(vel)
    y = vel;
end

