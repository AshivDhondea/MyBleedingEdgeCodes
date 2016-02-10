function [ Xnom ] = fnGenerateNominalTrajectory( timevec,Xnom_ini )
% fnGenerateNominalTrajectory generates a nominal trajectory for the period
% timevec, starting from the initial state vector Xnom_ini.

% This function is required when we need to update the nominal trajectory 
% and STMs when the convergence test fails.

% This function deals with the unperturbed problem.

%% Author
% Ashiv Dhondea, RRSG, UCT
% Created: 13 October 2015
% Edited: 20 November 2015 for the Orbit Problem

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

%% Dependencies
% 1. fnRK4vector.m
% 2. fnKepler3Augmented.m

%% Calculations

Num_state_variables = size(Xnom_ini,1);
% Nominal trajectory vector to cover the time period timevec
Xnom = zeros(Num_state_variables + Num_state_variables*Num_state_variables,numel(timevec)); % This is an augmented state vector
% 6 state variables, with 36 elements from the 6x6 STM

% Phi(0) = Identity matrix (property of state transition matrix)
Phi = eye(Num_state_variables ); 

% Load initial conditions into state vector
Xnom(:,1) = [ Xnom_ini; reshape(Phi,numel(Phi),1) ]; 

Xnom = fnRK4vector(@fnKepler3Augmented,timevec,Xnom); % Numerical integration

end
