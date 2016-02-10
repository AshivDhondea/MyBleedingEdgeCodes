function [ PhiT ] = fnExtractSTM( tbegin,tend, Xn )
% fnExtractSTM extracts State Transition Matrices from the numerically integrated
% augmented state vector.

%% Author
% Ashiv Dhondea, RRSG, UCT
% Created: 14/10/15
% Edited: 01/02/2016 to fit with the dimensionality of the 3-dimensional
% J2-perturbed problem.

%% Calculations

% Not that the  dimensionality (i.e. number of states) influences the
% dimensions of PhiT.

% Array of Phi matrices
PhiT = zeros(6*numel(tbegin:tend),6); % state transition matrices

for index = 1:numel(tbegin:tend)   
    % Propagate the perturbation vector through the simulation period.
    
    Phi = reshape(Xn(6+1:end,index),6,6);% extract Phi matrix
    
    % Load state transition matrix into the array of STMs
    PhiT(6*index-5:6*index,1:6) = Phi;
end

end
