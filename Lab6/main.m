clc
clear
close all 
SNR_dB=1:1:10;
sigma=1/sqrt(2);
M=16; 
[BER_A_STC1,~]=SER_STC(SNR_dB, sigma, M , 1); 
[~,BER_N_STC1]=SER_STC(SNR_dB, sigma, M , 1);

[BER_A_STC2,~]=SER_STC(SNR_dB, sigma, M , 2);
[~,BER_N_STC2]=SER_STC(SNR_dB, sigma, M , 2);
 
[BER_A_STC3,~]=SER_STC(SNR_dB, sigma, M , 3);
[~,BER_N_STC3]=SER_STC(SNR_dB, sigma, M , 3);
 
semilogy(SNR_dB,BER_A_STC1,'r--','MarkerSize',4, 'LineWidth',2)
grid
hold on
semilogy(SNR_dB,BER_N_STC1,'r*','MarkerSize',4, 'LineWidth',2)
semilogy(SNR_dB,BER_A_STC2,'k--','MarkerSize',4, 'LineWidth',2)
semilogy(SNR_dB,BER_N_STC2,'k*','MarkerSize',4, 'LineWidth',2)
semilogy(SNR_dB,BER_A_STC3,'b--','MarkerSize',4, 'LineWidth',2)
semilogy(SNR_dB,BER_N_STC3,'b*','MarkerSize',4, 'LineWidth',2)  
legend('Simulado J=1', 'Aproximada J=1', 'Simulado J=2',...
     'Aproximada J=2', 'Simulado J=3' , 'Aproximada J=3');
xlabel('Es/No, dB')
ylabel('SER')
axis([0 30 0.00001 10 ])