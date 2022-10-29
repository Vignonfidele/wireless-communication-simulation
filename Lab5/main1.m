clc 
clear
close all 
SNR_dB=5:45;
sigma=1/sqrt(2) ;
M=16; 
L=[1,2,3,4,5,6];
[BER_A_Rayleigh,~,~]=SER_all(SNR_dB, sigma, M , L(1));
[~,BER_A_PS1,~]=SER_all(SNR_dB, sigma, M , L(1));
[~,BER_A_PS2,~]=SER_all(SNR_dB, sigma, M , L(2));
[~,BER_A_PS3,~]=SER_all(SNR_dB, sigma, M , L(3)); 
[~,BER_A_PS4,~]=SER_all(SNR_dB, sigma, M , L(4)); 
[~,BER_A_PS5,~]=SER_all(SNR_dB, sigma, M , L(5)); 

semilogy(SNR_dB,BER_A_PS1,'r' )
hold on 
grid 
semilogy(SNR_dB,BER_A_PS2, 'b' )
semilogy(SNR_dB,BER_A_PS3 , 'm') 
semilogy(SNR_dB,BER_A_PS4 , 'm') 
semilogy(SNR_dB,BER_A_PS5 , 'm') 
axis([5 40 0.000001 1])
