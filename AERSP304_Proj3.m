% PITCH-CONTROLLER AERSP 304
% By : Nicholas Giampetro, Craig Stenstrom, Payton Glynn

clc
clear
close all

% Step 1
% Create State Space Representation
A = [ -0.03 -32.1 0 0; 0 0 0 56.7; -0.00025 0 -0.313 56.7; 0 0 -0.0139 -0.426] ;      
B = [0; 0; 0.232; 0.0203] ;
C = [0 1 0 0] ;
D = 0 ;
G = ss(A,B,C,D) ;

% Step 2
% Convert State Space Representation to a Transfer Function
[num,den] = ss2tf(A,B,C,D) ;        % num returns transfer function numerator coefficients, den returns denominator coefficients for open-loop transfer function
G = tf(num,den); 

% Step 3
% Find Poles and Zeros
[O,X,k] = tf2zp(num,den);                          % outputs zeros, poles, and k values

% Step Input Response
opt = stepDataOptions('StepAmplitude',.2) ;         % inputting step input of elevator (changing from unit amplitude to 0.2 rad)
F = figure;
step(G,opt) ;                                       % response for the step input
title('Step Response (Full Scale)')
xlabel('Time');
ylabel('Theta (rad)');
exportgraphics(F,['Open Loop Response','.jpg']);

% Step 4
% Closed Transfer Function
K = 1 ;
Gcl = feedback(G,K); 

F = figure;
step(Gcl,opt)
title('Step Response')
xlabel('Time');
ylabel('Theta (rad)');
exportgraphics(F,['Closed Loop Response','.jpg']);

% Step 5
s = tf('s');
Gclnew = Gcl*0.2/s;
[n,d] = tfdata(Gclnew, 'v');      % returns numerator and denominator of closed loop as a row vector
[z,p] = residue(n,d);          % returns zeros and poles of closed loop

syms q
f = (z(1)/(q-p(1))) + (z(2)/(q-p(2))) + (z(3)/(q-p(3))) + (z(4)/(q-p(4))) + (z(5)/(q-p(5)));
theta = matlabFunction(ilaplace(f));
t = 0:.1:80;
theta_t = theta(t);

F = figure;
plot(t,theta_t);
title('Step Response (Manual Calculation)')
xlabel('Time (seconds)');
ylabel('Theta (rad)');
exportgraphics(F,['Manual Theta Calc','.jpg']);

% Step 6 and 7
% Root Locus

% rltool(Gcl)     % commented out so it does not open everytime

% used rl tool to generate the (s+z)/(s+p) term multiplied by desired K
Ck2 = 2 * ((s+0.9) / (s+3)) ;
Ck50 = 50 * ((s+0.9) / (s+3)) ;
Ck200 = 200 * ((s+0.9) / (s+3)) ;

Gk2 = feedback(G*Ck2,1) ;
Gk50 = feedback(G*Ck50,1) ;
Gk200 = feedback(G*Ck200,1) ;

F = figure;
step(Gk2,opt)
title('Theta vs Time for compensator gain = 2')
xlabel('Time');
ylabel('Theta (rad)');
exportgraphics(F,['Theta vs Time for k = 2','.jpg']);

F = figure;
step(Gk50,opt)
title('Theta vs Time for compensator gain = 50')
xlabel('Time');
ylabel('Theta (rad)');
exportgraphics(F,['Theta vs Time for k = 50','.jpg']);

F = figure;
step(Gk200,opt)
title('Theta vs Time for compensator gain = 200')
xlabel('Time');
ylabel('Theta (rad)');
exportgraphics(F,['Theta vs Time for k = 200','.jpg']);
