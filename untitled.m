
function untitled()
    function y = f(x)
        if x < 0
            y = 0;
        elseif 0 < x < 75
            y = x/3;
        else 
            y = 25;
        end
    end

    xVal = [-10:1:100];
    yVal = [];
    
    for val = 1:xVal
        yVal(end+1) = f(val)
    end  
    
    plot(x,y)
    xlabel("distance")
    ylabel("speed")
    title("graph")
end  
