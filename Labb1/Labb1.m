function Labb1()
    Labb1a()
end

function Labb1a()
    x = -10:100;
    y = arrayfun(@f, x);
    
    plot(x, y)
end

function y = f(x)
    if x < 0
        y = 0;
    elseif 0 < x && x < 75
        y = x/3;
    else 
        y = 25;
    end
end