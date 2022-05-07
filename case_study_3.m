clear;
close all;

load('RoadSurfaceSamples.mat');

m_vehicle = 400; % fixed
k = 5E4; % fixed

% variables
% We choose 1.5 as our cutoff frequency. 
m_load = 163; % mass of the load 

v = 40; % velocity
b = 7501; % damping coefficient

% different simulated roads
roads = cat(2, roadTrap, roadSin, roadPothole, inverse_trap);

% simulation and plots
systemSimulation(m_vehicle+m_load, b, k, v, roads);


%% Testing

x = linspace(0,50, 251)'; % roadSurface sample spatial locations, in m
t = x/v; % Time vector
n = k; % system numerator
d = [m_vehicle+m_load, b, k]; % system denominator
[diff, sum_diff] = Testing(n, d, t, roads); 

    figure;
    subplot(4,1,1), plot(x, diff(: , 1));
    title('The response difference for the trapezoidal bump');
    subplot(4,1,2), plot(x, diff(: , 2));
    title('The difference for the sinusoidal road response against flat road');
    subplot(4,1,3), plot(x, diff(: , 3));
    title('The difference for the pothole road against flat road');
    subplot(4,1,4), plot(diff(: , 4));
    title('The response difference for the inverse trapezoidal bump');

    for i = 1:4
        subplot(4,1,i);
        xlabel('Road Surface x (m)');
        ylabel('Difference (m)');
    end 

%% Test for different speeds

TestSpeed(n, d,  roads); 
