clc
close 
clear
m=20;
SNR_dB=0:1:m;
sigma=1/2;
error=10;
M=16;  
nTx=2;
nRx=2;
[SER_A_SISO]=SER_SISO(SNR_dB, M, sigma); 
[SER_A_MRC]=SER_MRC(SNR_dB, sigma, M , nRx);   
[SER_N_VBLAST]=VBLAST(SNR_dB, sigma, M , nRx, nTx ,error);
[SER_N_MLSE]=SER_MLSE(SNR_dB, sigma, M , nRx, nTx ,error); 
semilogy(SNR_dB,SER_A_SISO,'k--','MarkerSize',4, 'LineWidth',2)
grid
hold on 
semilogy(SNR_dB,SER_A_MRC,'r--','MarkerSize',4, 'LineWidth',2) 
semilogy(SNR_dB,SER_N_VBLAST,'b--','MarkerSize',4, 'LineWidth',2)
semilogy(SNR_dB,SER_N_MLSE,'m--','MarkerSize',4, 'LineWidth',2) 
legend('SISO', 'MRC', 'VBLAST','MLSE' )
xlabel('Es/No[dB]')
ylabel('SER')
axis([0 m 0.01 2 ])