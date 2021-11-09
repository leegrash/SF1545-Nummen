%Gustaf Svensson - 20000709-4170
%Hampus Dartgard Holma - 19991118-6790

function Labb1()
   m = input("How many cars? ");
   h = input("h? ");
   
   iterations = 400;
   %Labb1a()
   plotLabbB(m,h,5,iterations, 75) %b - inbromsning
   %plotLabbB(m,h,25,iterations, 10) %b - accelerations
   %Labb1c(m ,h,25,iterations, 10) %c - film
   %Labb1g(m, h, 75, iterations, 5, 5, 20) %g - fixPoint
   %Labb1h(m, h, 75, iterations, 5, 5) %h - errPlot
end

%1a
function Labb1a()
    x = -200:400;
    y = arrayfun(@f, x);
    
    plot(x, y)
    xlim([-100, 400])
    ylim([-50, 50])
end

%1b
function plotLabbB(m, h, vel, iterations, dist)
    carPos = Labb1b(m ,h,vel, iterations, dist);
    
    carPosT = carPos.';
    
    carList = [];
    
    for i = 1:m
        x = 0:iterations-1;
        y = carPosT(:,i);
        
        plot(x, y)
        hold on
    end
    hold off
    
    t = 1;
end

function carPos = Labb1b(m ,h , vel,iterations, dist)
  
  carPos = genPosMatrix(m, iterations, dist); %placement of cars from 1 to m at time 0 to 40
  carVel = genVelMatrix(vel, m , iterations, dist); %speed of cars from 1 to m at time 0 to 40
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

%1c
function Labb1c(m ,h, vel,iterations, dist)
    carPos = Labb1b(m ,h,vel, iterations, dist);
    for t = 1:iterations
        plot(carPos(:,t) , zeros(1,m),'r*');
        axis([0 1000 -1 1])
        drawnow
        pause(h)
    end
end

%1g
function fixPointPosMatrix = Labb1g(m, h, dist, timeStep, startFixPoint, carMVel, iterations)
    posMatrix = genPosMatrix(m, timeStep, dist);
    
    %first car
    for t = 2:timeStep
        posMatrix(m,t) = posMatrix(m,t-1)+h*carMVel;
    end
    
    for iteration = 1:iterations %number of iterations
        for car = m-1:-1:1
            for t = 2:timeStep
                posMatrix(car,t) = FixPoint(posMatrix(car, t-1), posMatrix(car+1,t), h, startFixPoint, iteration);
            end
        end
    end
    
    fixPointPosMatrix = posMatrix
end

%1h
function Labb1h(m, h, dist, timeStep, startFixPoint, carMVel)
    fixPointPosMatrix = Labb1g(m, h, dist, timeStep, startFixPoint, carMVel, 20);
    
    correctMatrix = EulerBackwards(m, timeStep, genPosMatrix(m, timeStep, dist), carMVel, h);
    
    avgErrList = [];
    
    for r = 1:timeStep
        sumErrThisStep = 0;
        
        for k = 1:m
            errThisCar = correctMatrix(k, r) - fixPointPosMatrix(k, r);
            sumErrThisStep = sumErrThisStep + abs(errThisCar);
        end
       
        avgErrList(end+1) = sumErrThisStep/m;
    end
    
    x = 1:timeStep;
    y = avgErrList;
    %plot(x, y)
    
    errList = J(m, h, dist, timeStep, startFixPoint, carMVel, 20, correctMatrix);
    
    x = 1:20;
    y = errList;
    semilogy(x, y)
end

%assisting functons

function errList = J(m, h, dist, timeStep, startFixPoint, carMVel, iterations, correctMatrix)
    errList = [];
    
    for i = 1:iterations
        fixPointPosMatrix = Labb1g(m, h, dist, timeStep, startFixPoint, carMVel, i);
        
        errList(end+1) = abs(correctMatrix(1, timeStep) - fixPointPosMatrix(1, timeStep));
    end
    
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

function x = FixPoint(oldX, newX, h, startFixPoint, i)
    x = startFixPoint;
    for k = 1:i
        x = oldX+h*f(newX-x);
    end
end

function correctMatrix = EulerBackwards(m, timeSteps, startMatrix, vel, h)
    for r = 2:timeSteps
        startMatrix(m, r) = startMatrix(m, r-1)+vel*h;
    end
    
    for k = m-1:-1:1
        for r = 1:timeSteps-1
            startMatrix(k, r+1) = (3*startMatrix(k, r)+h*startMatrix(k+1, r+1))/(3+h);
        end
    end
    correctMatrix = startMatrix;
end

function y = g(vel)
    y = vel;
end

function matrix = genPosMatrix(m, iterations, dist)
    matrix = zeros(m, iterations);
    
    for index=1:m
       matrix(index, 1) = (index-1)*dist;
    end
    
end

function matrix = genVelMatrix(carVel, m, iterations, dist)
    matrix = zeros(m, iterations);
    
    for index=1:m-1
       matrix(index, 1) = dist/3;
    end
    
    matrix(m, 1) = carVel;
end


