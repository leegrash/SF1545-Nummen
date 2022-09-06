function Labb2()
    %Part 2
    %plotPart2([0, 0.5, 1, 1.5, 2, 2.99, 3], [0, 0.52, 1.09, 1.75, 2.45, 3.5, 4]);
    
    %Part 3
    %part3fun5LS([150, 200, 300, 500, 1000, 2000], [2, 3, 4, 5, 6, 7]);
    %part3fun6LS([150, 200, 300, 500, 1000, 2000], [2, 3, 4, 5, 6, 7]);
    %part3fun6GN([150, 200, 300, 500, 1000, 2000], [2, 3, 4, 5, 6, 7]);
    
    %Part 4
    plotPart4()
end

%Part 2:
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

%Part 3:
function part3fun5LS(alpha, u)
    aFunc = @(x, y) x./y - x./8; 
    
    sysR = aFunc(alpha, u)';
    
    sysL = ones(6, 1);
    
    a = sysL \ sysR
    
    UFunc = @(x) 1./(1./8 + a./x);
    
    graphRangeX = 0:1:3000;
    
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
    [a,b] = part3LeastSquared(alpha, u)
   
    UFunc = @(x) 8 - a.*x.^b;
    
    graphRangeX = 0:1:3000;
    
    graphRangeY = UFunc(graphRangeX);
    
    plot(alpha, u, ".");
    hold on
    
    xlim([0, 3000]);
    ylim([0, 9]);
    
    plot(graphRangeX, graphRangeY);
end

function part3fun6GN(alpha, u)
    koeff = [100, -0.5]; %Guess of koef
    f = []; %Empty f-vector
    j = []; %Empty jacobi-matrix
    h = []; %Empty corr-term
    
    for i = 1:10 %GN-iterations
        for k = 1:length(alpha)
            f(k, 1) = 8 - u(k) - koeff(1,1)*(alpha(k)^koeff(1,2)); %Set curr funcVal
            %Set jacobi-matrix for curr a and koeff
            j(k, 1) = -alpha(k)^koeff(1,2); 
            j(k, 2) = -koeff(1,1)*alpha(k)^koeff(1,2)*log(alpha(k));
        end    

        h = j\f; 
        koeff = koeff - h'; %set new val of koeff
    end
    
    uFuncGN = @(x) 8 - koeff(1,1).*x.^koeff(1,2);
    
    graphRangeX = 0:1:3000;
    
    graphRangeY = uFuncGN(graphRangeX);
    
    plot(alpha, u, ".");
    hold on
    
    xlim([0, 3000]);
    ylim([0, 9]);
    
    plot(graphRangeX, graphRangeY);
    
end

%Part 4
function plotPart4()
    N = 250; %Nbr of steps
    x0 = 1; %Begynnelsevärde
    t = 1/N; %Step-length
    tMax = 1;
    T = 0:t:tMax-t;
    tol = 0.0001; %tolerans for diff between iterations to stop
    consumption = zeros(1, numel(T));
    [capital,consumption]=Lagrange(N, t, x0, tol,consumption);
    
    plot(T,capital)
    hold on
    plot(T(1:end-1),consumption(1:end-1))
    legend({'Capital','Consumtion'}, 'Location', 'southeast')
    axis([0 1 0 2])
end

function [capital,consumption] = Lagrange(N, t, x0, tol,consumption)
    f = @(x) x; 
    
    %f = @(x) x + (x^2)/10; 
    
    %f = @(x) 1.0709*x + 0.0618*x^2; 
    
    capital = ones(1,N);
    k_upd = zeros(1,N);
    lambda = zeros(1,N);

    k_upd(1) = x0; %startVal = 1
    diff = 1; %val >tol io whileslingan not to be past

    while norm(diff) > tol

        lambda(end) = 1/sqrt(capital(end)); %N:th X acc to assignment 
        for n = N-1:-1:1 %step backwards and give lagrangemultiple
            lambda(n) = lambda(n+1) + f(capital(n)) * t * lambda(n+1);
        end

        for n = 1:N-1
            k_upd(n+1) = capital(n) + t * (f(capital(n)) - 1/((lambda(n+1))^(3/5)));
        end

        diff = k_upd - capital;%diff to compare stopp-condition  
        capital = k_upd;%update capVector for next iteration
    end
    for i = 1:N-1
        consumption(i) = lambda(i+1)^(-3/5); % ã=(lambda_n+1)^(-3/5)
    end
end
