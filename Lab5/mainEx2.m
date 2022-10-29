clc 
clear
close all 
SNR_dB=0:25; 
M=16; 
[BER_A_PS, ~]=SER_Ex2(SNR_dB, M ); 
[~, BER_N]=SER_Ex2(SNR_dB, M ); 
[BER_A_PS1, ~]=SER_Ex2(SNR_dB, 64 ); 
[~, BER_N1]=SER_Ex2(SNR_dB, 64 ); 
semilogy(SNR_dB,BER_A_PS,'r' )
hold on 
grid
semilogy(SNR_dB,BER_N,'r*' )
semilogy(SNR_dB,BER_A_PS1,'b' )
semilogy(SNR_dB,BER_N1,'b*' )
legend('Aproximado-16QAM','Simulado-16QAM', 'Aproximado-64QAM','Simulado-64QAM' );
xlabel('Es/No, dB')
ylabel('SER')
axis([0 27 0.00001 10 ])