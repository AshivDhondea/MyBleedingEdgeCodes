function [ Xdot ] = fnKepler3( t, X )
% fnKepler3 implements the Differential Equation for the two body Kepler
% problem which only assumes gravitation.

% Author: Ashiv Dhondea, RRSG, UCT
% Date: 10 October 2015

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

%% Calculations
r = norm(X(1:3));
mu = 398600;     % Earth’s gravitational parameter [km^3/s^2]

% DX = F(X)
% D(x,y,z) = (xdot,ydot,zdot)
% D(xdot,ydot,zdot) = -mu/r^3 * (xdot,ydot,zdot)

Xdot = [X(4);X(5);X(6);-mu*X(1)/r^3; -mu*X(2)/r^3; -mu*X(3)/r^3];

end
