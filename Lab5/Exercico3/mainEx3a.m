clc 
clear
close all 
format long
SNR_dB=0:23; 
M=16; 
L=2;

[  BER_A, ~ ]=SER_Ex2(SNR_dB, 16 );
[  ~ , BER_N ]=SER_Ex2(SNR_dB, 16 );

[  BER_A_PS, ~ ]=SER_Ex3a(SNR_dB, 16 ,2 );
[  ~ , BER_N_PS ]=SER_Ex3a(SNR_dB,16 ,2 );

[ BER_A_MRC,~]=SER_Ex3b(SNR_dB,16 ,2 );
[ ~,   BER_N_MRC ]=SER_Ex3b(SNR_dB, 16 ,2); 

[ BER_A_EGC,~]=SER_Ex3c(SNR_dB,16 ,2 );
[ ~,   BER_N_EGC ]=SER_Ex3c(SNR_dB, 16 ,2); 

semilogy(SNR_dB,BER_A,'r' )
hold on 
grid 
semilogy( SNR_dB , BER_A_PS,'b' )   
semilogy( SNR_dB , BER_A_MRC,'m' ) 
semilogy( SNR_dB , BER_A_EGC,'k' ) 
semilogy(SNR_dB,BER_N,'r*' ) 
semilogy(SNR_dB, BER_N_PS,'b*' )   
semilogy(SNR_dB, BER_N_MRC,'m*' )
semilogy(SNR_dB, BER_N_EGC,'k*' )
legend('Sem diversidade','PS', 'MRC', 'EGC');
xlabel('Es/No, dB')
ylabel('SER')
axis([0 27 0.000001 10 ])