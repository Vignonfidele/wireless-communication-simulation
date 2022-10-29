clc
clear
close all 
K=8;  % Numero de simbolo OFDM
U=3;
bmin=10; %Numero de bite minimo para todo los usuarios 
P=100; %Potencia 
sigma2 = 10^(-2); % Varianza ......
Pes=10^(-5);   % Probabilidade de error de simbolo
 
H=[0.3 0.2 0.4 0.6 0.8 1.0 1.2 1.3;...
    1.0 0.8 1.4 0.3 0.2 0.1 0.2 0.3;...
    0.1 0.2 0.3 2.6 2.8 0.3 0.1 0.1 ];

[b_userf]=Water_filling_algorithm(K, U, bmin , P, Pes, H, sigma2 ) 