clc 
clear
close all 
SNR_dB=0:25; 
sigma=1/sqrt(2);
M=16; 
L=2; 
[ BER_A_PS,  ~]=SER_MRC1(SNR_dB, sigma, M , L);
[ ~ ,  BER_N_PS]=SER_MRC1(SNR_dB, sigma, M , L); 

semilogy(SNR_dB,BER_A_PS,'r' )
hold on 
grid
semilogy(SNR_dB,BER_N_PS,'r*' ) 
legend('Aproximado-16QAM','Simulado-16QAM');
xlabel('Es/No, dB')
ylabel('SER')
axis([0 27 0.00001 10 ])