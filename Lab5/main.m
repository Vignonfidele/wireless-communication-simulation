clc 
clear
close all 
SNR_dB=10:45;
sigma=1 ;
M=16;
L=4;
[BER_A_Rayleigh,~,~]=SER_all(SNR_dB, sigma, M , L);
[~,BER_A_PS,~]=SER_all(SNR_dB, sigma, M , L);
[~,~,BER_A_MRC1]=SER_all(SNR_dB, sigma, M , 1);
[~,~,BER_A_MRC2]=SER_all(SNR_dB, sigma, M , 2);
[~,~,BER_A_MRC3]=SER_all(SNR_dB, sigma, M , 3);
[~,~,BER_A_MRC4]=SER_all(SNR_dB, sigma, M , 4);  
[~,~,BER_A_MRC5]=SER_all(SNR_dB, sigma, M , 5);

semilogy(SNR_dB,BER_A_MRC1,'r' )
hold on 
grid 
semilogy(SNR_dB,BER_A_MRC2, 'b' )
semilogy(SNR_dB,BER_A_MRC3 , 'm') 
semilogy(SNR_dB,BER_A_MRC4 , 'm') 
semilogy(SNR_dB,BER_A_MRC5 , 'm') 
axis([10 40 0.0000001 1])
