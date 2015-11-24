function [ a,e,i,BigOmega,omega,E,nu] = fnTLEtoKeps( fname )
% fnTLEtoKeps converts data read from a TLE file to Keplerians.

% Adapted from: smallsats.org

%% Author:
% Ashiv Dhondea, RRSG, UCT
% Date: 21/11/15

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
addpath('Constants'); load('constants.mat');

%% File processes
% Open the TLE file and read TLE elements
FileID = fopen(fname, 'rb');
Line1 = fscanf(FileID,'%24c%*s',1);
Line2 = fscanf(FileID,'%d%6d%*c%5d%*3c%*2f%f%f%5d%*c%*d%5d%*c%*d%d%5d',[1,9]);
Line3 = fscanf(FileID,'%d%6d%f%f%f%f%f%f%f',[1,8]);

%% Keplerians
epoch = Line2(1,4)*24*3600;        % Epoch Date and Julian Date Fraction
Db = Line2(1,5);                % Ballistic Coefficient
i = Line3(1,3);                % Inclination [deg]
BigOmega = Line3(1,4);                % Right Ascension of the Ascending Node [deg]
e = Line3(1,5)/1e7;            % Eccentricity
omega = Line3(1,6);                % Argument of periapsis [deg]
M = Line3(1,7);                % Mean anomaly [deg]
n = Line3(1,8);                % Mean motion [Revs per day]

% Orbital elements
a = (mu_E/(n*2*pi/(24*3600))^2)^(1/3);     % Semi-major axis [km]

% Calculate the eccentric anomaly using Mean anomaly
errTol = 1e-10;            %Calculation Error

[ E] = fnKeplerEquation( M,e,errTol );

% Print the Keplerians
Keplerians = [a;e;i;BigOmega;omega;E];
fprintf('\n a [km]   e      inc [deg]  RAAN [deg]  w[deg]    E [deg] \n ')
fprintf('%4.2f  %4.4f   %4.4f       %4.4f     %4.4f    %4.4f\n', Keplerians);

nu = 2*atan2(sqrt(1-e)*cos(E/2),sqrt(1+e)*sin(E/2));

fclose(FileID);
end
