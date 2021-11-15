function script()
    %Del 2
    plotPart2([0, 0.5, 1, 1.5, 2, 2.99, 3], [0, 0.52, 1.09, 1.75, 2.45, 3.5, 4]);
    
    %Del 3
    %part3fun5LS([150, 200, 300, 500, 1000, 2000], [2, 3, 4, 5, 6, 7]);
    %part3fun6LS([150, 200, 300, 500, 1000, 2000], [2, 3, 4, 5, 6, 7]);
    %part3fun6GN([150, 200, 300, 500, 1000, 2000], [2, 3, 4, 5, 6, 7]);
end

%Del 2:
function [a,b] = leastSquared(xList, yList)
    leastSquaredMat = [xList, xList.^2];
    koeff = leastSquaredMat\yList;
    a = koeff(1,1);
    b = koeff(2,1);
end

function plotPart2(xList, yList)
    [a,b] = leastSquared(xList', yList')

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
    y1 = a*x+b*x.^2;
    plot(x, y1);
    
    hold on
    
    p = polyfit(xList, yList, length(xList)-1);
    yVal = polyval(p, x);
    
    plot(x, yVal);
    
    hold off
    
    lsFun = @(x) a*x+b*x.^2;
    
    calcDif(xList, yList, lsFun, p)
    
end

function calcDif(xList, yList, lsFun, poly)
    lsVal = lsFun(xList);
    polyVal = polyval(poly, xList);
    
    lsDif = mean(abs(lsVal - yList))
    polyDif = mean(abs(polyVal - yList))
end

%Del 3:
function part3fun5LS(alpha, u)
    aFunc = @(x, y) x./y - x./8; 
    
    sysR = aFunc(alpha, u)';
    
    sysL = ones(6, 1);
    
    a = sysL \ sysR
    
    UFunc = @(x) 1./(1./8 + a./x);
    
    graphRangeX = 0:1:2000;
    
    graphRangeY = UFunc(graphRangeX);
    
    plot(graphRangeX, graphRangeY);
    
end

function [a,b] = part3LeastSquared(alpha, u)
    LSLeft = [
        1 log(alpha(1)); 
        1 log(alpha(2)); 
        1 log(alpha(3)); 
        1 log(alpha(4));
        1 log(alpha(5)); 
        1 log(alpha(6))
        ];
    LSRight = [log(8-u(1)); log(8-u(2)); log(8-u(3)); log(8-u(4)); log(8-u(5)); log(8-u(6))];
    
    koeff = LSLeft\LSRight;
    
    a = exp(koeff(1));
    b = koeff(2);
end

function part3fun6LS(alpha, u)
    [a,b] = part3LeastSquared(alpha, u);
   
    UFunc = @(x) 8 - a.*x.^b;
    
    graphRangeX = 100:1:3000;
    
    graphRangeY = UFunc(graphRangeX);
    
    plot(alpha, u, ".");
    hold on
    
    xlim([100, 3000]);
    ylim([0, 9]);
    
    plot(graphRangeX, graphRangeY);
end

function part3fun6GN(alpha, u)
    koeff = [100, -0.5]; %Guess of koef
    f = [];
    j = [];
    h = [];
    
    for i = 1:10
        for k = 1:length(alpha)
            f(k, 1) = 8 - u(k) - koeff(1,1)*(alpha(k)^koeff(1,2));
            j(k, 1) = -alpha(k)^koeff(1,2); 
            j(k, 2) = -koeff(1,1)*alpha(k)^koeff(1,2)*log(alpha(k));
        end    

        h = j\f;
        koeff = koeff - h';
    end
    
    uFuncGN = @(x) 8 - koeff(1,1).*x.^koeff(1,2);
    
    graphRangeX = 100:1:3000;
    
    graphRangeY = uFuncGN(graphRangeX);
    
    plot(alpha, u, ".");
    hold on
    
    xlim([100, 3000]);
    ylim([0, 9]);
    
    plot(graphRangeX, graphRangeY);
    
end