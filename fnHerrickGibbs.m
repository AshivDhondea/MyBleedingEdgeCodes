function [ VelVec2, errorFlag ] = fnHerrickGibbs( PosVec1,PosVec2,PosVec3,JD1,JD2,JD3 )
% fnHerrickGibbs uses the Herrick-Gibbs method of preliminary orbit determination to compute
% a velocity vector from 3 position vectors.

% Implements Algorithm 49 in [Ref 1]. Based on hgibbs.m from Vallado,
% updated for speed of execution.

%% Parameters:
% PosVec1,2,3 are three position vectors in the ECI frame.
% VelVec2 is the velocity vector computed for the second measurement. 
% errorFlag indicates whether the three position vectors are coplanar.
% 0 if yes. 1 if no. [Ref 3]

%% References
% 1. Fundamentals of astrodynamics and application. Vallado. 2001

%% Author
% Ashiv Dhondea, RRSG, UCT
% Date: 9/12/15

%% Dependencies:
% 1. angl.m

%% Load constants
load('constants.mat'); % load mu_E in [km ^3/s^2]

%% Calculations:
% Find the time steps
dt21= (JD2-JD1)*86400.0;
dt31= (JD3-JD1)*86400.0;   
dt32= (JD3-JD2)*86400.0;

% Find the magnitudes of the 3 vectors
magr1 = norm(PosVec1);
magr2 = norm(PosVec2);
magr3 = norm(PosVec3);

tolangle= 0.01745329251994;

% Find cross-product
Z23 = cross(PosVec2,PosVec3);

errorFlag = 0;

dotProd = dot(Z23,PosVec1)/(norm(Z23)*norm(PosVec1));

if ( abs( dotProd ) > 0.017452406 )
   errorFlag = 1;
end

% --------------------------------------------------------------
%   check the size of the angles between the three position vectors.
%   herrick gibbs only gives "reasonable" answers when the
%   position vectors are reasonably close.  10 deg is only an estimate.
% --------------------------------------------------------------
    theta  = angl( PosVec1,PosVec2 );
    theta1 = angl( PosVec2,PosVec3 );
    if ( (theta > tolangle) || (theta1 > tolangle) )  

        errorFlag = 1;
    end

    term1= -dt32*( 1.0/(dt21*dt31) + mu_E/(12.0*magr1^3) );
    term2= (dt32-dt21)*( 1.0/(dt21*dt32) + mu_E/(12.0*magr2^3) );
    term3=  dt21*( 1.0/(dt32*dt31) + mu_E/(12.0*magr3^3) );

    VelVec2 =  term1*PosVec1 + term2* PosVec2 + term3* PosVec3;

     fprintf(1,'p     %11.7f   %11.7f  %11.7f km2 \n',Z23);
     fprintf(1,'theta     %11.7f   %11.7f deg \n',theta*180/pi, theta1*180/pi );

end
