close all;
clear
clc;
N = 1000;
SNR_dB =0:1:10;  

% ____________________
%   16QAM ANALYSIS
% ____________________
% generate the constellattion array for mapping0
sita = 1/sqrt(10);
M = 16 ;% number of constellation
SER_QAM_real_AWGN = zeros(1,[]);
SER_QAM_imag_AWGN = zeros(1,[]);

SER_QAM_real_RAYLEIGH = zeros(1,[]);
SER_QAM_imag_RAYLEIGH = zeros(1,[]);

SER_QAM_AWGN = zeros(1, N);
QAM_SER_AWGN= zeros(1, length(SNR_dB));

SER_QAM_RAYLEIGH = zeros(1, N);
QAM_SER_RAYLEIGH= zeros(1, length(SNR_dB));
pe_num=[];
for v = 1:length(SNR_dB)
    % generate the data. Note: the data generated is not in binary but multiplying by M and setting the vector
    % in this form gives a gray mapping
    error=0;
    N1=0;
    while error<1000
        N1=N1+1;
        t = randi([0,M-1],1,N); 
        tx = qammod(t, M);
        tx_Normal = sita*tx; 
        n = 1/sqrt(2)* (randn(1,N) + 1i*randn(1,N));
        h = 1/sqrt(2)* (randn(1, N) + 1i* randn(1, N));  
        Sr = h.* tx_Normal + 10^(-SNR_dB(v)/20)*n;
        Se = Sr./h; 
        C_dem =qamdemod(Se,M);  
        if C_dem~=t
              error=error+1;
        end
    end
    pe=error/N1;
    pe_num=[pe_num, pe]; 

end

ee= pe_num
SER_RAYLEIGH = QAM_SER_RAYLEIGH/N;
 
%%%%%%%%%%%%%%%%%%%%%%%%%% Simulated and theoretical 16QAM SER OVER RAYLEIGH %%%%%%%%%%
c1=0.5*10.^(SNR_dB./10)*log(M)/(M-1);
n1=sqrt(c1./(c1+1));
Theoretical_QAM_RAYLEIGH=2.*(sqrt(M)-1)./sqrt(M)*(1-n1)-((sqrt(M)-1)./sqrt(M)).*((sqrt(M)-1)./sqrt(M))*(1-4.*n1./deg2rad(180).*atan(1./n1));

semilogy(SNR_dB, ee, 'k<-', SNR_dB, Theoretical_QAM_RAYLEIGH, 'm*');
title(" QPSK, 16QAM's SER over RAYLEIGH channel");
xlabel('Es/N0');
ylabel('Symbol Error rate (BER) in dB'); 
grid on 