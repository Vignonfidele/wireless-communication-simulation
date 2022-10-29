clc;
clear 
close all;

% INPUTS AND CONVERSION
Number_of_input_bit = 1000000;
EsN0_dB = (0:35);   
% ____________________
%   16QAM ANALYSIS
% ____________________
% generate the constellattion array for mapping
sita = 1/sqrt(10);
M = 16 ;% number of constellation 
QAM_SER_RAYLEIGH=[];
for v = 1:length(EsN0_dB) 
    x = randi([0,M-1],1,Number_of_input_bit); 
    t= sita*qammod(x, M);
    tx = qammod(x, M);  
    n=  1/sqrt(2)* (randn(1,Number_of_input_bit) + 1i*randn(1,Number_of_input_bit)); 
    h=   1/sqrt(2)*(randn(1, Number_of_input_bit) + 1i* randn(1, Number_of_input_bit));  
    Sr=h.*tx + 10^(-EsN0_dB(v)/20)*n; 
    Se=Sr./h;
    
    C_dem =qamdemod(Se,M); 
    QAM_SER_RAYLEIGH(v) = size(find((x - C_dem)),2);
      
end
SER_RAYLEIGH = QAM_SER_RAYLEIGH/Number_of_input_bit;
%%%%%%%%%%%%%%%%%%%%%%%%%% Simulated and theoretical 16QAM SER OVER RAYLEIGH %%%%%%%%%%
c1=0.5*10.^(EsN0_dB./10)*log(M)/(M-1);
n1=sqrt(c1./(c1+1));
Theoretical_QAM_RAYLEIGH=2.*(sqrt(M)-1)./sqrt(M)*(1-n1)-((sqrt(M)-1)./sqrt(M)).*((sqrt(M)-1)./sqrt(M))*(1-4.*n1./deg2rad(180).*atan(1./n1));

semilogy(EsN0_dB, SER_RAYLEIGH, 'k<-')
hold on
semilogy(EsN0_dB, Theoretical_QAM_RAYLEIGH, 'm*');
title(" QPSK, 16QAM's SER over RAYLEIGH channel");
xlabel('Es/N0');
ylabel('Symbol Error rate (BER) in dB'); 
grid on 