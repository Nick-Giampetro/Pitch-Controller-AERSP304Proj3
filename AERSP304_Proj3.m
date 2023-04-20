% PITCH-CONTROLLER AERSP 304
% By : Nicholas Giampetro, Craig Stenstrom, Payton Glynn

clc
clear
close all

% Create State Space Representation
A = [ -0.03 -32.1 0 0; 0 0 0 56.7; -0.00025 0 -0.313 56.7; 0 0 -0.0139 -0.426] ;      
B = [0; 0; 0.232; 0.0203] ;
C = [0 1 0 0] ;
D = 0 ;
G = ss(A,B,C,D) ;

% Convert State Space Representation to a Transfer Function
[num,den] = ss2tf(A,B,C,D) ;        % num returns transfer function numerator coefficients, den returns denominator coefficients for open-loop transfer function

% Find Poles and Zeros
[O,X,k] = tf2zp(num,den) ;

% Step Input Response
opt = stepDataOptions('StepAmplitude',.2) ;           % inputting step input of elevator
figure
step(G,opt) ;                                       % response for the step input

% Closed Transfer Function
K = 1 ;
Gcl = feedback(G,K) ;

figure
step(Gcl,opt)



%Root Locus

controlSystemDesigner(Gcl,0.2)
