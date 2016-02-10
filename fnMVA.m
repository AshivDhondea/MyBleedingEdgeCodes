function [ delta_X_hat, S_hat ] = fnMVA( Lambda, TotalObservationMatrixTranspose, RynInv, Ryn, delta_Y )
% FNMVA implements the Minimum Variance Algorithm (MVA).
% Ashiv Dhondea, RRSG, UCT.
% 23/10/15

%LambdaInv = inv(Lambda);
% Avoid computing LambdaInv, better use QR decomposition Edited: 9/11/15

% Filter matrix W in TFE == matrix M in Tapley,Schutz,Born.
W = Lambda\TotalObservationMatrixTranspose*RynInv;

% Estimated covariance matrix
S_hat = W*Ryn*W';

% Estimated perturbation vector
delta_X_hat = W*delta_Y;

end
