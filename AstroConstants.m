%% Astrodynamics constants

%% Author:
% Ashiv Dhondea, RRSG, UCT
% 23/11/15

%% Values obtained from 
% 1. Fundamentals of astrodynamics and application. Vallado


%% Constants
mu_E = 398600.4418;     % Earth’s gravitational parameter [km^3/s^2]

R_E = 6378.1363;  % Earth radius [km]

theta_dot = 7.29211585530066e-5;  % [rad/s]

J_2 = 1.082626925638815e-3;  % [] 

%% Save data

destination = 'constants.mat';
save(destination, 'mu_E','R_E','theta_dot','J_2');

%% End.
