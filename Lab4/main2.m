
clc
clear all 
M=16;
SNR_db = 0:2:35;
N=100000;
x = randi([0,M-1],N,1);
k = log2(M); % bits per symbol
sigma= 1/sqrt(2);
t = qammod(x, M,'Gray');
r=abs((sigma)*randn(1)+1i*(sigma)*randn(1));
tx=t*r;
err = zeros(1,7);
for j = 1:numel(SNR_db)
    rx = awgn(tx, SNR_db(j),'measured');
    
    Se=rx/r;
    rx_demod = qamdemod( Se, M, 'Gray' );
    
    [~,err(j)] = biterr(x,rx_demod);
end

pe_ana=function_SER_analitico(SNR_db, M, sigma) ;

 
semilogy( SNR_db, err*k, '^-');
%grid on
grid 
hold on 
semilogy(SNR_db,pe_ana,'b','MarkerSize',6, 'LineWidth',2)
legend('theory', 'simulation');
xlabel('Es/No, dB')
ylabel('Symbol Error Rate')
title('Symbol Error Probability curve for 16-QAM modulation')