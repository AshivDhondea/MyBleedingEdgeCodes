function [ YY  ] = fnSensorSignal( Xactual,StandardDeviationX,StandardDeviationY,StandardDeviationZ )
%  FNSENSORSIGNAL evaluates the sensor's output signal.
% See Chapter 3 in Tracking Filter Engineering.

% The observation scheme is linear so we are in Case 3. We can thus readily
% form the sensor output signal vector.

% Some minor changes are needed when the number of state variables changes.

% Author: Ashiv Dhondea
% Date: 29 September 2015
% Edited: 11 October 2015: Modified for 3 dimensional Two Body Problem

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
YY = zeros(size(Xactual));

% YY(1:3,:) = Xactual(1:3,:); 
% Technically, YY = M Xactual, 
% In other words, we can only measure the x and y and z positions.
% Do note that we could also compute the velocity by differentiation. We'll
% leave that for later on.

% Sensor adds zero mean WGN
GaussianNoiseX = 0 + StandardDeviationX*randn(size(Xactual,2),1);
GaussianNoiseY = 0 + StandardDeviationY*randn(size(Xactual,2),1);
GaussianNoiseZ = 0 + StandardDeviationZ*randn(size(Xactual,2),1);

% There is additive white Gaussian noise in both x and y measured positions.
YY(1:3,:) = Xactual(1:3,:) + [GaussianNoiseX';GaussianNoiseY';GaussianNoiseZ']; % Actual/true position + noise

%% Explanation
% As explained elsewhere in this function, our sensor can only provide
% measurements of the position of the object, not of its velocity. I.e. we
% have no Doppler information. Since the observation model is linear but
% the dynamical model is nonlinear, we are in case 3, according to Tracking
% Filter Engineering. So our filter is the GNF(3)

end
