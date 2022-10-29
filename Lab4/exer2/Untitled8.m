close all;
clear
clc; 
N = 100000;
SNR_dB =0:1:35;   
sita = 1/sqrt(10);
M = 16 ; 
sigma=1/sqrt(2);
error = zeros(1,[]);  

for j = 1:length(SNR_dB) 
    tx = randi([0,M-1],1,N); 
    tx_mod = qammod(tx, M);
    tx_mod_norm = sita.*tx_mod;  
    r=abs((sigma)*randn(1,N) + 1i*(sigma)*randn(1,N)); 
    S=tx_mod.*r;
    Sr = add_awgn_noise(S ,SNR_dB(j) ); 
    Se = Sr./r; 
    C_dem =qamdemod(Se,M); 
    error(j) = sum(C_dem~=tx)/N;  
end 
 
%%%%%%%%%%%%%%%%%%%%%%%%%% Simulated and theoretical 16QAM SER OVER RAYLEIGH %%%%%%%%%%


semilogy(SNR_dB, error, 'k<-');
title(" QPSK, 16QAM's SER over RAYLEIGH channel");
xlabel('Es/N0');
ylabel('Symbol Error rate (BER) in dB'); 
grid on 