function Labb1()
    Labb1a()
    Labb1b()
end

function Labb1a()
    x = -200:400;
    y = arrayfun(@f, x);
    
    plot(x, y)
    xlim([-100, 400])
    ylim([-50, 50])
end

function y = f(x)
    if x <= 0
        y = 0;
    elseif 0 < x && x < 75
        y = x/3;
    else 
        y = 25;
    end
end

function Labb1b()
    
end

function y = g()
    y = 5;
end

function eulersMethod(h, high, low, yStart)
    x = low:h:high;
    y = zeroes(size(x));
    
end