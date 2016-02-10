function [ Xinput_polar] = fnObservMatrixG( Xinput )
% fnObservMatrixG implements the G matrix in the observation equation
% 02/02/2016

Xinput_polar = zeros(3,1);
% Calculate range
Xinput_polar(1) = norm(Xinput(1:3));
% Calculate elevation
Xinput_polar(2) = atand(Xinput(3)/norm(Xinput(1:2)));
% Calculate azimuth
Xinput_polar(3) = atan2d(Xinput(1),Xinput(2));
end
