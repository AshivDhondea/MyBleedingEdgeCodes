% PjMolniya01GenerateData.m

% First project file in the Molniya tracking project.
% In this project, we generate an ephemeris for a satellite on a Molniya
% orbit from its Keplerians.

%% Dependencies
% Based on Code01NumIntegTwoBody.m

% Calls Orbital2State.m, fnGlobePlot.m, fnKepler3.m and fnRK4vector.m

% Saves data in 'ActualEphemeris.mat' for processing by the subsequent
% project files.

%% Author
% Ashiv Dhondea, RRSG, UCT.
% Date: 11 October 2015

%% References

% 1. Tracking Filter Engineering. Norman Morrison
% 2. Statistical Orbit Determination. Tapley, Schutz, Born.

%% Clear memory
clear
clc
close all;

%% Declare constants
mu = 398600;     % Earth’s gravitational parameter [km^3/s^2]
R_earth = 6378;  % Earth radius [km]

%% Keplerians for Molniya Orbit
% Molniya Orbit 1
a     = 26554;
e     = 0.72;
i     = 63.4;
omega = -90;
theta = 0;
RAAN  = 0;
h =(a*mu*(1 - e^2))^0.5;

% Calculating initial state vector
[ R0,V0 ] = Orbital2State( h, i, RAAN, e,omega,theta);

clear h i RAAN e omega theta

% Initial state vector which determines nominal trajectory
X0 = [R0;V0];
tstart = 0;
tstop = 42000;

dt = 100;
time = tstart:dt:tstop-dt;
t = time';

clear time

% propagated state vectors stored in X
% 6 elements: x,y,z,xdot,ydot,zdot
X = zeros(6,numel(t));

% Initial Conditions
X(:,1) = X0;
Phi0 = eye(6);

X = fnRK4vector( @fnKepler3, t ,X);

%% Plotting
fnGlobePlot( X, R_earth, -30, 5, 1.5)
% zoom(0.75)
saveas(1,'AshivMolniyaOrbit1.pdf');

%% Store data
data = 'ActualEphemeris.mat';
save(data,'X','t');

%% End
% The data generated in this file is analysed in the project
% PjMolniya02SensorData.m
