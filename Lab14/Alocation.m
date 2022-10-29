clc
clear
close all 

K=8;  % Numero de simbolo OFDM
bmin=10; %Numero de bite minimo para todo los usuarios 
P=100; %Potencia 
sigma2 = 10^(-2); % Varianza ......
Pes=10^(-5);   % Probabilidade de error de simbolo
H1=[0.3 0.2 0.4 0.6 0.8 1.0 1.2 1.3].';  %canal do usuario 1
H2=[1.0 0.8 1.4 0.3 0.2 0.1 0.2 0.3].';  %canal do usuario 2
H3=[0.1 0.2 0.3 2.6 2.8 0.3 0.1 0.1].';  %canal do usuario 3
rho=(1/3)*(qfuncinv(Pes/4))^2; %calculo de rho

T_user1=(rho*sigma2)./abs(H1).^2;
T_user2=(rho*sigma2)./abs(H2).^2;
T_user3=(rho*sigma2)./abs(H3).^2;

%Calculo das potencias 
P_user1=(P/K)+((rho*sigma2)/K)*sum(1./abs(H1).^2)-T_user1;
P_user2=(P/K)+((rho*sigma2)/K)*sum(1./abs(H2).^2)-T_user2;
P_user3=(P/K)+((rho*sigma2)/K)*sum(1./abs(H3).^2)-T_user3;

%Capacidade de carga de uma subportadora

b_user1=fix(log2(1+(P_user1./T_user1))).'
b_user2=fix(log2(1+(P_user2./T_user2))).'
b_user3=fix(log2(1+(P_user3./T_user3))).'