% PITCH-CONTROLLER AERSP 304
% By : Nicholas Giampetro, Craig Stenstrom, Payton Glynn

A = [ -0.03 -32.1 0 0; 0 0 0 56.7; -0.00025 0 -0.313 56.7; 0 0 -0.0139 -0.426];      
B = [0; 0; 0.232; 0.0203];
C = [0 1 0 0];
D = 0;
sys = ss(A,B,C,D)