clc 
clear
close all 
%% Parametro 
M=16; 
sigma=1/sqrt(5);
SNR_dB = 0:1:35;  
%% Vectores de simulacion 
%[~, BER_A_4PSQ]=funtion_SER(SNR_dB, 8, sigma);
[~, BER_A_16QAM]=funtion_SER(SNR_dB, 16, sigma);
%[~, BER_A6_4QAM]=funtion_SER(SNR_dB, 64, sigma);
 
%[BER_N_4PSQ, ~]=funtion_SER(SNR_dB, 8, sigma);
[BER_N_16QAM, ~]=funtion_SER(SNR_dB, 16, sigma);
%[BER_N_4QAM, ~]=funtion_SER(SNR_dB, 64, sigma); 
 
%% Plote
%semilogy(SNR_dB, BER_A_4PSQ, 'r')

semilogy(SNR_dB, BER_A_16QAM,'k')
grid 
hold on 
%semilogy(SNR_dB, BER_A6_4QAM,'b') 
%semilogy(SNR_dB, BER_N_4PSQ,'r*')
semilogy(SNR_dB, BER_N_16QAM,'k*')
%semilogy(SNR_dB, BER_N_4QAM,'b*') 

legend('Apriximado-8PSK ', 'Apriximado-16QAM', ' Apriximado-64QAM', 'Simulado' );
xlabel('Es/No, dB')
ylabel('SER')
axis([0 35 0.001 10 ])
 