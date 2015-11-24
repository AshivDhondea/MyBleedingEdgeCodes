function [  a,e,i,BigOmega,omega,T, h_p, h_a ] = fnTLEtoKeps_Satellites( fname)
%% fnTLEtoKeps_Satellites reads TLE elements from a file which contains data about many space objects.

% Based on: http://smallsats.org/2012/12/10/space-debris/

%% Author:
% Ashiv Dhondea, RRSG, UCT
% Date: 24/11/15

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
addpath('Constants'); load('constants.mat');

%% File processes
% Open the TLE file and read TLE elements
FileID = fopen(fname, 'rb');

index = 1;
while ~feof(FileID) % while not reached end of file, read TLEs.
    Line1 = fscanf(FileID,'%24c%*s',1);
    Line2 = fscanf(FileID,'%d%6d%*c%5d%*3c%*2f%f%f%5d%*c%*d%5d%*c%*d%d%5d',[1,9]);
    Line3 = fscanf(FileID,'%d%6d%f%f%f%f%f%f%f',[1,8]);
    
    i(index) = Line3(1,3);% Inclination [deg]
    BigOmega(index) = Line3(1,4); % Right Ascension of the Ascending Node [deg]
    e(index) = Line3(1,5)/1e7;    % Eccentricity
    omega(index) = Line3(1,6);    % Argument of periapsis [deg]
    M(index) = Line3(1,7);        % Mean anomaly [deg]
    n = Line3(1,8);               % Mean motion [Revs per day]
    
    a(index) = (mu_E/(n*2*pi/(24*3600))^2)^(1/3);     % Semi-major axis [km]
    T(index) = fnKeplerOrbitalPeriod(a(index)); % period in [s]
    
    h_p(index) = (1 - e(index))*a(index) - R_E;                % Perigee Altitude [km]
    h_a(index) = (1 + e(index))*a(index) - R_E;                % Apogee Altitude [km]
    % Increment count 
    index = index +1;
end

fclose(FileID);

end
