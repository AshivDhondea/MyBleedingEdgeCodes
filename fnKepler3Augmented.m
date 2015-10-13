function [ Xdot ] = fnKepler3Augmented( t, X )
% fnKepler3Augmented implements implements the vector function F in 
% DX = FX as well as the state transition matrix's DE.

% We employ an augmented state vector: the first six elements in X are the
% states (x, y, z, xdot, ydot, zdot). The next 36 elements are the elements
% from the state transition matrix reshaped into a column vector.

% Author: Ashiv Dhondea, RRSG, UCT
% Date: 10 October 2015
% Edited: 11 October 2015: included the full Amatrix, and the STM.

%% Parameters

% X(1) == x i.e. x component of position
% X(2) == y i.e. y   "           "
% X(3) == z i.e. z   "           " 
% X(4) == xdot i.e. first derivative of x position
% X(5) == ydot i.e.                     y   
% X(6) == zdot i.e                      z

% The remaining 36 elements in X are the elements from the 6x6 state
% transition matrix reshaped into a column.

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

% The state transition matrix's elements are the last 36 elements in the
% input state vector
Phi = reshape(X(end-36+1:end),6,6);% extract Phi matrix from the input vector X

% Find matrix A (state sensitivity matrix)

% We start with a matrix of zeros and then add in the non-zero elements.
Amatrix = zeros(6,6);
Amatrix(1,4) = 1;
Amatrix(2,5) = 1;
Amatrix(3,6) = 1;

Amatrix(4,1) = -mu*(r^2 - 3*X(1)^2)/r^5;
Amatrix(4,2) =  mu*3*X(1)*X(2)/r^5;
Amatrix(4,3) =  mu*3*X(1)*X(3)/r^5;

Amatrix(5,1) = Amatrix(4,2);
Amatrix(5,2) = -mu*(r^2 - 3*X(2)^2)/r^5;
Amatrix(5,3) = mu*3*X(2)*X(3)/r^5;

Amatrix(6,1) = Amatrix(4,3);
Amatrix(6,2) = Amatrix(5,3);
Amatrix(6,3) = -mu*(r^2 - 3*X(3)^2)/r^5;

% The state transition matrix's differential equation.
PhiDot = Amatrix*Phi; % Amatrix is a time dependent variable.i.e. not constant

% DX = F(X)
% D(x,y,z) = (xdot,ydot,zdot)
% D(xdot,ydot,zdot) = -mu/r^3 * (xdot,ydot,zdot)

Xdot = [X(4);X(5);X(6);-mu*X(1)/r^3; -mu*X(2)/r^3; -mu*X(3)/r^3;reshape(PhiDot,numel(PhiDot),1)];

end
