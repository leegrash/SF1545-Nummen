function Labb1()
   m = input("How many cars? ");
   h = input("h? ");
   % Labb1a()
   % Labb1b()
   Labb1c(m ,h)
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

function x = Labb1b(m ,h)
  
  x = zeros(m , 41); %placement of cars from 1 to m at time 0 to 40
  y = zeros(m , 41); %speed of cars from 1 to m at time 0 to 40
  t = 1;
  y(m , t) = g();
  t = t+1;
  while t <= 41
    y(m , t) = g();
    x(m , t) = x(m , (t-1)) + h * y(m , t);
    for i = m-1:-1:1
        x(i , t) = x(i , (t-1)) + h * y(i , t-1);
        y(i , t) = f(x(i+1 , t)-x(i , t));
    end
    t = t + 1;
  end  
  y
end

function Labb1c(m ,h)
    x = Labb1b(m ,h)
    for t = 1:41
        plot(x(:,t) , zeros(1,m),'r*');
        axis([0 1000 -1 1])
        drawnow
        pause(h)
    end
end

function y = g()
    y = 5;
end

function eulersMethod(h, high, low, yStart)
    x = low:h:high;
    y = zeroes(size(x));
    
end