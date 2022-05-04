clear;
close all;

load('RoadSurfaceSamples.mat');

m_vehicle = 400; % fixed
k = 4E4; % fixed

% variables
m_load = 600; % mass of the load
v = 5; % velocity
b = 5000; % damping coefficient

% different simulated roads
roads = cat(2, roadTrap, roadSin, roadPothole, inverse_trap);

% simulation and plots
systemSimulation(m_vehicle+m_load, b, k, v, roads);