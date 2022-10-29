clc 
clear
close all 
%%Parametro 
 
sigma= 1/sqrt(2);
SNR_dB=0:1:35;

%pe_num=function_SER_numero(SNR_dB, M, sigma) ;
M=16;
SNR_db = 0:1:35;
N=1000;
x = randi([0,M-1],N,1);
k = log2(M); % bits per symbol
pe_ana=function_SER_analitico(SNR_db, M, sigma) ;
tx = qammod(x, M,'Gray');
err = zeros(1,7);
for j = 1:numel(SNR_db)
    r=(abs(sigma*randn(1)+1i*sigma*randn(1)))^2;
    rx = awgn(tx*r, SNR_db(j),'measured');
    rx_demod = qamdemod( rx, M, 'Gray' );
    [~,err(j)] = biterr(x,rx_demod);
end

theorySER = 3/2*erfc(sqrt(0.1*(10.^(SNR_db/10))));

figure
semilogy(SNR_db, err*k, '^-');
grid 
hold on 
semilogy(SNR_db,pe_ana,'b','MarkerSize',6, 'LineWidth',2)
legend('theory', 'simulation');
xlabel('Es/No, dB')
ylabel('Symbol Error Rate')
title('Symbol Error Probability curve for 16-QAM modulation')
  
