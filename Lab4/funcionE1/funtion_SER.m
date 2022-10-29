function [BER_N, BER_A]=funtion_SER(SNR_dB, M,sigma)
    %% Parametro 
    N=1e6;
    SNR=10.^(SNR_dB./10);
    %% Analitico 
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    gama=2*sita*(sigma^2).*SNR;
    BER_A=(mi/2)*(1-sqrt(gama./(2+gama)));
    BER_N = zeros(1,[]); 
    %% Simulado 
    tx = randi([0,M-1],1,N); 
    tx_mod = qammod(tx, M);
    for j = 1:length(SNR_dB)  
        r=abs((sigma)*randn(1,N) + 1i*(sigma)*randn(1,N)); 
        S=tx_mod.*r;
        Sr = add_awgn_noise(S ,SNR_dB(j) ); 
        Se = Sr./r; 
        C_dem =qamdemod(Se,M); 
        BER_N(j) = sum(C_dem~=tx)/N;  
    end 
end