function fnSatellite_GroundTrack_Plot( Rvec, varargin )
% Plots a satellite ground track

%% Based on:
% http://smallsats.org/2013/01/20/satellite-ground-track-molniya-1-93/

%% Author
% Ashiv Dhondea, RRSG, UCT
% Date: 16 November 2015
% Edited: 21/11/15: include my name as textbox

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

%% Plot
X_Width = 820;
Y_Width = 420;

hFig = figure;
 set(gcf,'PaperPositionMode','auto')
 set(hFig, 'Position', [100 100 X_Width Y_Width])
hold on;
grid on;
axis([0 360 -90 90]);
load('topo.mat','topo','topomap1');
contour(0:359,-89:90,topo,[0 0],'b')
axis equal
box on
set(gca,'XLim',[0 360],'YLim',[-90 90], ...
    'XTick',[0 60 120 180 240 300 360], ...
    'Ytick',[-90 -60 -30 0 30 60 90]);
image([0 360],[-90 90],topo,'CDataMapping', 'scaled');
colormap(topomap1);
ylabel('Latitude [^0]');
xlabel('Longitude [^0]');
title('ISS Ground Track');

hold on;

for index = 1:size(Rvec,2)
    % Convert position vector to right ascension and declination
    [ alpha0 ,delta0 ] = R2RA_Dec( Rvec(1:3,index) );
    plot(alpha0,delta0,'.r');
    
    hold on;
end

nVarargs = length(varargin);

for k = 1:nVarargs
    hold on;
    Xvar = varargin{k};
    
   for index = 1:size(Xvar,2)
        % Convert position vector to right ascension and declination
        [ alpha0 ,delta0 ] = R2RA_Dec( Xvar(1:3,index) );
        plot(alpha0,delta0,'.y');    
   end
end

text(280,-80,'AshivD','Color',[1 1 1], 'VerticalAlignment','middle',...
	'HorizontalAlignment','left','FontSize',12 );
hold off;


end

