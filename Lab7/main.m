clc
clear
close all
a=20;
SNR_dB=0:1:a;
sigma=1/sqrt(2);
error=10;
M=16;  
nTx=2;
nRx=2;
[SER_A_SISO]=SER_SISO(SNR_dB, M, sigma, error); 
[SER_A_MRC]=SER_MRC(SNR_dB, sigma, M , nRx);  
[SER_N_ZF]=SER_ZF11(SNR_dB, sigma, M , nRx, nTx ,error);
[SER_N_MMSE]=SER_MMSE11(SNR_dB, sigma, M , nRx, nTx ,error); 
[SER_N_VBLAST]=SER_VBLAST(SNR_dB, sigma, M , nRx, nTx, error);
semilogy(SNR_dB,SER_A_SISO,'k--','MarkerSize',4, 'LineWidth',2)
grid
hold on 
semilogy(SNR_dB,SER_A_MRC,'r--','MarkerSize',4, 'LineWidth',2) 
semilogy(SNR_dB,SER_N_ZF,'g--','MarkerSize',4, 'LineWidth',2)
semilogy(SNR_dB,SER_N_MMSE,'b--','MarkerSize',4, 'LineWidth',2)
semilogy(SNR_dB,SER_N_VBLAST,'m--','MarkerSize',4, 'LineWidth',2) 
legend('SISO', 'MRC', 'ZF','MMSE','VBLAST' )
xlabel('Es/No[dB]')
ylabel('SER')
axis([0 a 0.01 2 ])