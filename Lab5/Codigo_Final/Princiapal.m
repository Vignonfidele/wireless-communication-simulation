clc 
clear
close all 
SNR_dB=0:30;
sigma=1/sqrt(2) ;
M=16;
L=2;
[ BER_A_PS,  ~]=SER_Pure_Selection(SNR_dB, sigma, M , 1);
[ ~,  BER_N_PS]=SER_Pure_Selection(SNR_dB, sigma, M , 1);

[ BER_A_PS1,  ~]=SER_Pure_Selection(SNR_dB, sigma, M , 2);
[ ~,  BER_N_PS1]=SER_Pure_Selection(SNR_dB, sigma, M , 2);

[ BER_A_PS2,  ~]=SER_Pure_Selection(SNR_dB, sigma, M , 4);
[ ~,  BER_N_PS2]=SER_Pure_Selection(SNR_dB, sigma, M , 4);

% 
% [BER_A_Rayleigh , ~ ]=SER_Rayleigh_sem_diversidade(SNR_dB, sigma, M );
% [~ , BER_N_Rayleigh ]=SER_Rayleigh_sem_diversidade(SNR_dB, sigma, M ); 

%[BER_A_EGC, ~]=SER_EGC(SNR_dB, sigma, M , L);
% [ BER_A_EGC, ~]=SER_EGC(SNR_dB, sigma, M , L);
% [ ~, BER_N_EGC]=SER_EGC(SNR_dB, sigma, M , L);
% 
% 
% [BER_A_MRC, ~ ]=SER_MRC1(SNR_dB, sigma, M , L);
% [ ~ , BER_N_MRC]=SER_MRC1(SNR_dB, sigma, M , L);
 
semilogy(SNR_dB,BER_A_PS, 'r' ) 
hold on 
grid 
semilogy(SNR_dB,BER_N_PS,'r*' )
semilogy(SNR_dB,BER_A_PS1, 'b' )  
semilogy(SNR_dB,BER_N_PS1,'b*' )
semilogy(SNR_dB,BER_A_PS2, 'k' )  
semilogy(SNR_dB,BER_N_PS2,'k*' )
%  
% semilogy(SNR_dB,BER_N_Rayleigh, 'b*' ) 
