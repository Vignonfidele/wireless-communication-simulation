clc
close 
clear
m=20;
SNR_dB=0:1:m;
sigma=1/sqrt(2);
error=1000;
M=16;  
nTx=2;
nRx=2;
[P2]=BER(SNR_dB, sigma, M , 2) ;
[SER_A_SISO]=SER_SISO(SNR_dB, M, sigma, error); 
[SER_A_MRC]=SER_MRC(SNR_dB, sigma, M , nRx);  
[SER_N_VBLAST_QR]=SER_VBLAST(SNR_dB, sigma, M , nRx, nTx ,error);
[SER_N_VBLAST]=SER_VBLAST(SNR_dB, sigma, M , nRx, nTx ,error);
[SER_N_MLSE]=SER_MLSE(SNR_dB, sigma, M , nRx, nTx ,error); 
semilogy(SNR_dB,SER_A_SISO,'k--','MarkerSize',4, 'LineWidth',2)
grid
hold on 
%semilogy(SNR_dB,P2,'r*','MarkerSize',4, 'LineWidth',2) 
semilogy(SNR_dB,SER_A_MRC,'r--','MarkerSize',4, 'LineWidth',2) 
semilogy(SNR_dB,SER_N_VBLAST,'b--','MarkerSize',4, 'LineWidth',2)
semilogy(SNR_dB,SER_N_VBLAST_QR,'g--','MarkerSize',4, 'LineWidth',2)
semilogy(SNR_dB,SER_N_MLSE,'m--','MarkerSize',4, 'LineWidth',2) 
legend('SISO', 'MRC', 'VBLAST','VBLAST-QR', 'MLSE' )
xlabel('Es/No[dB]')
ylabel('SER')
axis([0 m 0.01 2 ])