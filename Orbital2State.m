function [ R,V ] =  Orbital2State( h, i, RAAN, e,omega,theta)

mu = 398600;       % Earth’s gravitational parameter [km^3/s^2]
% Components of the state vector of a body relative to its perifocal
% reference
rx = h^2/mu*(1/(1 + e*cosd(theta)))*[cosd(theta);sind(theta);0];
vx = mu/h*[-sind(theta); (e +cosd(theta));0];
% Direction cosine matrix
QXx = [cosd(omega), sind(omega),0;-sind(omega),cosd(omega),0;0,0,1]*...
    [1,0,0;0,cosd(i),sind(i);0,-sind(i),cosd(i)]*...
    [cosd(RAAN), sind(RAAN),0;-sind(RAAN),cosd(RAAN),0;0,0,1];
% Transformation Matrix
QxX = inv(QXx);
% Geocentric equatorial position vector R
R = QxX*rx;
% Geocentric equatorial velocity vector V
V = QxX*vx;

end

% Ashiv's note: I did not write this function, but I checked it against the
% theory in books:
% David Vallado, Fundamentals of Astrodynamics and Applications.
