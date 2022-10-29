clc
close 
clear all 
SNR_dB=0:1:10;
sigma=1 ;
error=100;
M=16;  
nTx=2;
nRx=2;
[SER_A_SISO,~]=SER_MRC1(SNR_dB, sigma, M , 2); 
[~,SER_A_MRC]=SER_MRC1(SNR_dB, sigma, M , 2);
[SER_MRC1]=SER_MRC111(SNR_dB, sigma, M , 2, error);
semilogy(SNR_dB,SER_A_SISO,'k--','MarkerSize',4, 'LineWidth',2)
grid
hold on 
semilogy(SNR_dB,SER_A_MRC,'r--','MarkerSize',4, 'LineWidth',2)  
semilogy(SNR_dB,SER_MRC1,'r--','MarkerSize',4, 'LineWidth',2)  

legend('SISO', 'MRC', 'VBLAST','VBLAST-QR', 'MLSE' )
xlabel('Es/No[dB]')
ylabel('SER')
%axis([0 35 0.001 2 ])