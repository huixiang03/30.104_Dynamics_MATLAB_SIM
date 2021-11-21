close all

t=0:0.5:1000; % points of evaluation of the function y

% setting initial conditions
% Setting initial conidtions for the acceleration for the sake of the
% function
initial_x=0;  
initial_xp=0;  
initial_xp2=0;  

initial_t= 0.9; 
initial_tp = 0;  
initial_tp2 = 0;  

initial_p = -0.4; 
initial_pp = 0;  
initial_pp2 = 0;  

[t,y] = ode15i( @solveode, t, [initial_x; initial_t; initial_p;
    initial_xp; initial_tp; initial_pp],[initial_xp; initial_tp; initial_pp;
    initial_xp2; initial_tp2; initial_pp2]);
delta_angle = y(:,3) - y(:,2);
total_angle = y(:,3) + y(:,2);
y

figure;
% subplot(1,1,1); plot(t,delta_angle,'-');
% xlabel('t'); %sets the x-axis label
% ylabel('delta angle'); %sets the y-axis label

subplot(4,1,1); plot(t,y(:,1)); 
xlabel('t'); %sets the x-axis label
ylabel('x'); %sets the y-axis label
subplot(4,1,2); plot(t,y(:,2)); 
xlabel('t'); %sets the x-axis label
ylabel('t'); %sets the y-axis label
subplot(4,1,3); plot(t,y(:,3)); 
xlabel('t'); %sets the x-axis label
ylabel('p'); %sets the y-axis label

subplot(4,1,4); plot(t,total_angle,'-');
xlabel('t'); %sets the x-axis label
ylabel('total angle'); %sets the y-axis label


% here we write the differential equation that we want to solve
function dzdt=solveode(t,x,y)
mp1 = 50;
mp2 = 50;
mm = 50; 
% sum of masses of platform and both metronome w/o the weight of 
% the pendulum
mc = 50;
g = 10; % for simplification
b1 = 0.1;
b2 = 0;
b3 = 0;
masses = [mp1, mp2, mm, mc];
Rcp = 50;
dzdt = [
    - y(1) + x(4);
    - y(2) + x(5);
    - y(3) + x(6);
    
    - y(4) + ( -b1 * x(4) + ( (x(5).^2).*sin(x(2))- y(5).*cos(x(2)) ) .* Rcp .* masses(1)...
    + ( (x(6).^2).*sin(x(3))- y(6).*cos(x(3)) ) .* Rcp .* masses(2) )...
    ./ (masses(3) + 3 * masses(4) + masses(1) + masses(2));
    
    - y(5) - ( b2 * x(5) + (y(4) * cos(x(2)) + g * sin(x(2)))...
    * Rcp * masses(1)) ./ ((Rcp^2) * masses(1));
    
    - y(6) - ( b3 * x(6) + (y(4) * cos(x(3)) + g * sin(x(3)))...
    * Rcp * masses(2)) ./ ((Rcp^2) * masses(2));
    ];

end

