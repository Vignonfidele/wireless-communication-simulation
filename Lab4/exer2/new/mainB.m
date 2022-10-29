clc 
clear
close all 
%% Parametro 
M=16; 
B= 5;
SNR_dB = 0:1:35;  
%% Vectores de simulacion  
 
[BER_N_4PSQ, ~]=funtion_SER_B(SNR_dB, 8, B);
[BER_N_16QAM, ~]=funtion_SER_B(SNR_dB, 16, B);
[BER_N_4QAM, ~]=funtion_SER_B(SNR_dB, 64, B); 
%  
 %% plote
semilogy(SNR_dB, BER_N_4PSQ,'r')
grid 
hold on  
semilogy(SNR_dB, BER_N_16QAM,'k')
semilogy(SNR_dB, BER_N_4QAM,'b') 

legend('Simulado-8PSK ', 'Simulado-16QAM', ' Simulado-64QAM' );
xlabel('Es/No, dB')
ylabel('SER')
%axis([0 35 0.001 10 ])
 