function [ Xdot ] = fnKepler_J2( t, X )
% fnKepler3 implements the Differential Equation for the two body Kepler
% problem perturbed by the J_2 effect.

% Author: Ashiv Dhondea, RRSG, UCT
% Date: 16 November 2015
% Edited: 29/11/15: Commented out constants. Now constants are obtained from the constants data file.

%% License
% Copyright (c) 2015 Ashiv Dhondea

% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the "Software")
% , to deal in the Software without restriction, including without 
% limitation the rights to use, copy, modify, merge, publish, distribute, 
% sublicense, and/or sell copies of the Software, and to permit persons to 
% whom the Software is furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included 
% in all copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
% OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
% THE USE OR OTHER DEALINGS IN THE SOFTWARE.

%% Declare constants
%mu_E = 398600.4418;     % Earth’s gravitational parameter [km^3/s^2]
%R_E = 6378.1363;  % Earth radius [km]
%J_2 = 1.082626925638815e-3;  % [] 
%addpath('Constants');
load('constants.mat');

%% Calculations
r = norm(X(1:3));

Xdot = zeros(6,1);

Xdot(1:3) = X(4:6); % dx/dt = xdot; dy/dt = ydot; dz/dt = zdot
expr = 1.5*J_2*(R_E/r)^2 ;

Xdot(4) = -(mu_E/r^3)*X(1)*(1-expr*(5*(X(3)/r)^2 -1));
Xdot(5) = -(mu_E/r^3)*X(2)*(1-expr*(5*(X(3)/r)^2 -1));
Xdot(6) = -(mu_E/r^3)*X(3)*(1-expr*(5*(X(3)/r)^2 -3));

end
