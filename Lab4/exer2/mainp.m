clc 
clear
close all 
%%Parametro 
M=8; 
B=5;
SNR_dB = 0:2:30; 
[pe_ana]=function_SER_analitico_B(SNR_dB, M, B);  
%[pe_numerico]=function_SER_analitico(SNR_dB, M, B) ;
[pe_num]=function_SER_numeroB(SNR_dB, M, B); 
loglog(SNR_dB,pe_ana,'b','MarkerSize',6, 'LineWidth',2);
grid
hold on 
loglog(SNR_dB,pe_num,'r*','MarkerSize',6, 'LineWidth',2)
legend(  'Apriximado ', 'Numero' );
xlabel('Es/No, dB')
ylabel('Symbol Error Rate')
title('Symbol Error Probability curve  ')
axis([0 35 0.00001 10 ])
  
