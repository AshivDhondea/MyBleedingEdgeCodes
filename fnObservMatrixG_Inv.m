function [ Xout] = fnObservMatrixG_Inv( Xinput )
% The inverse of the matrix G.
% Converts from polar to cartesians in the ENU coordinate system

% 02/02/2016

% Xinput(1) = range
% Xinput(2) = elevation
% Xinput(3) = azimuth

Xout(1) = Xinput(1)*cosd(Xinput(2))*sind(Xinput(3)); % x
Xout(2) = Xinput(1)*cosd(Xinput(2))*cosd(Xinput(3)); % y
Xout(3) = Xinput(1)*sind(Xinput(2)); % z
end
