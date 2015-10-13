function [ X ] = fnRK4vector( func, timevec ,X)
% Runge-Kutta 4th Order method
% Vector implementation of the RK4 method.
% Scalar implementation is fnRK4.m

% Ashiv Dhondea, RRSG, UCT
% 10/10/2015

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
h = timevec(2) - timevec(1);

for index = 2:numel(timevec)
    k1 = func(timevec(index-1)      ,X(:,index-1)          );
    k2 = func(timevec(index-1)+0.5*h,X(:,index-1)+ k1*0.5*h);
    k3 = func(timevec(index-1)+0.5*h,X(:,index-1)+ k2*0.5*h);
    k4 = func(timevec(index-1)+    h,X(:,index-1)+ k3    *h);
  
    X(:,index) = X(:,index-1) + (1/6)*(k1+2*k2+2*k3+k4)*h;
end

end
