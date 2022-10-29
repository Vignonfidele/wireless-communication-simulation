clc 
clear
close all 
%%Parametro 
M=16; 
sigma= 1/sqrt(2);
SNR_dB = 0:1:10;
[pe_num]=function_SER_numero(SNR_dB, M, sigma) ; 
semilogy(SNR_dB, pe_num, 'r') 
legend(  'Apriximado-8PSK ', 'Apriximado-16QAM', ' Apriximado-64QAM');
xlabel('Es/No, dB')
ylabel('SER')
axis([0 35 0.001 10 ])
  
