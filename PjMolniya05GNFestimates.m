% PjMolniya05GNFestimates.m plots the filter estimates generated in
% PjMolniya04GNF.m

%% Dependencies

% Calls fnGlobePlot.m 

% Requires data 'FilterEstimates.mat' 

%% Author
% Ashiv Dhondea, RRSG, UCT.
% Date: 15 October 2015

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

%% Load data
load('FilterEstimates.mat') % Contains filter estimates
load('ActualEphemeris.mat')

%% Plotting

% Plot actual orbit
fnGlobePlot( X(:,2:80), R_earth, -30, 5,1.5)

% Plot predicted orbit
fnGlobePlot( X_hat(:,2:80), R_earth, -30, 5,1.5)

%% Estimates vs Actual
error = X - X_hat;

figure;

subplot(3,1,1);
plot(error(1,2:80));
grid on;
title('Errors in x position')
xlabel('sample #')
ylabel('error')

subplot(3,1,2);
plot(error(2,2:80));
grid on;
title('Errors in y position')
xlabel('sample #')
ylabel('error')

subplot(3,1,3);
plot(error(3,2:80));
grid on;title('Errors in z position');
xlabel('sample #')
ylabel('error')

figure;
subplot(3,1,1);
title('Errors in x velocity')
plot(error(4,2:80));
grid on;
xlabel('sample #')
ylabel('error')

subplot(3,1,2);
title('Errors in y velocity')
plot(error(5,2:80));
grid on;
xlabel('sample #')
ylabel('error')

subplot(3,1,3);
title('Errors in z velocity')
plot(error(6,2:80));
grid on;
xlabel('sample #')
ylabel('error')
