function [ ECI, V_ECI ] = fnECEFtoECI( ECEF, theta_GST ,V_ECEF )
% fnECEFtoECI converts ECEF measurements to the ECI frame using the
% Greenwich Sidereal time.

% GST: Greenwich hour angle in [deg] not [rad].
% ECI in [km], V_ECI in [km] and the same for ECEF and V_ECEF

% Folder Astro.
%% Dependencies:
% 1. fnRotate3.m

%% Author
% Ashiv Dhondea, RRSG, UCT
% Date: 29 November 2015

%% Reference
% 1. Fundamentals of astrodynamics and application. 
% 2. Richard Rieber's Orbital Library.
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
ECI = zeros(size(ECEF,1),size(ECEF,2));

% if nargin == 3 % if # of arguments is 3
V_ECI = zeros(size(ECEF,1),size(ECEF,2));
% end

% Loop through all observations
for index = 1:size(ECEF,2)  
    % Rotating the ECEF vector into the ECEF frame via the GST angle about the Z-axis
    ECI(:,index) = fnRotate3(-theta_GST(index))*ECEF(:,index);
    if nargin == 3
        V_ECI(:,index) = fnRotate3(-theta_GST(index))*V_ECEF(:,index);
    end
end

end
