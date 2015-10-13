function fnGlobePlot( Xin, R_earth )
% fnGlobePlot plots an orbit around the globe.

%% Author
% Ashiv Dhondea, RRSG, UCT.
% Date: 11 October 2015

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

%% Plot on globe

figure('Color',[0 0 0]);
figure(1);
% whitebg(1,'k')
hold on;
load('topo.mat','topo','topomap1');
colormap(topomap1);
% Create the surface.
[x,y,z] = sphere(50);
x =R_earth*x;
y =R_earth*y;
z =R_earth*z;

props.AmbientStrength = 0.1;
props.DiffuseStrength = 1;
props.SpecularColorReflectance = .5;
props.SpecularExponent = 20;
props.SpecularStrength = 1;
props.FaceColor= 'texture';
props.EdgeColor = 'none';
props.FaceLighting = 'phong';
props.Cdata = topo;
surface(x,y,z,props);

% Inertial Frame Axis
Xa  = R_earth:100:R_earth+2500;
Z0  = Xa*0;
plot3(-Xa,Z0,Z0,'r')
plot3(Z0,-Xa,Z0,'y')
plot3(Z0,Z0,Xa,'g')

% Plotting Orbits
plot3(Xin(1,:),Xin(2,:),Xin(3,:),'r');
axis square off
view(3)
zoom(2)

end

