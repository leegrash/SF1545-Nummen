function script()
    %Del 2
    plotPart2([0, 0.5, 1, 1.5, 2, 2.99, 3], [0, 0.52, 1.09, 1.75, 2.45, 3.5, 4]);
end

%Del 2:
function [a,b] = leastSquared(xList, yList)
    leastSquaredMat = [xList.^2, xList];
    koeff = leastSquaredMat\yList;
    a = koeff(1,1);
    b = koeff(2,1);
end

function plotPart2(xList, yList)
    [a,b] = leastSquared(xList', yList');

    plot(xList(1),yList(1),".");
    hold on
    
    plot(xList(2),yList(2),".");
    hold on
    
    plot(xList(3),yList(3),".");
    hold on
    
    plot(xList(4),yList(4),".");
    hold on
    
    plot(xList(5),yList(5),".");
    hold on
    
    plot(xList(6),yList(6),".");
    hold on
    
    plot(xList(7),yList(7),".");
    hold on
    
    x = 0:0.01:3;
    
    y1 = a*x.^2+b*x;
    plot(x, y1);
    
    hold on
    
    p = polyfit(xList, yList, length(xList)-1);
    yVal = polyval(p, x);
    
    plot(x, yVal);
    
    hold off
end