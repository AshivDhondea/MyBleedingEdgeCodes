function [ Mmatrix ] = fnObservMatrix( Xnom )
% fnObservMatrix evaluates the observation matrix on the nominal trajectory
% Case 4: nonlinear filter model, nonlinear dynamical model

% Radar observations: (range,azimuth,elevation) 
% Filter states: (x,y,z,xdot,ydot,zdot)

% 02/02/2016

% Reference:
% 1. Pg 122 in Tracking Filter Engineering. Morrison.

rho = norm(Xnom);
s = norm(Xnom(1:2));

Mmatrix = zeros(3,6);
Mmatrix(1,1) = Xnom(1)/rho; 
Mmatrix(1,2) = Xnom(2)/rho; 
Mmatrix(1,3) = Xnom(3)/rho; 

Mmatrix(2,1) = -Xnom(1)*Xnom(3)/(rho^2*s);
Mmatrix(2,2) = -Xnom(2)*Xnom(3)/(rho^2*s); 
Mmatrix(2,3) = s/(rho^2);

Mmatrix(3,1) = -Xnom(2)/s^2;
Mmatrix(3,2) = -Xnom(1)/s^2;

end
