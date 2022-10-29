function [BER_N, BER_A]=funtion_SER(SNR_dB, M, sigma)
    %% Parametro 
    N=1e5;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    %% Analitico 
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    gama=2*sita*(sigma^2).*SNR;
    BER_A=(mi/2)*(1-sqrt(gama./(2+gama)));
    BER_N = zeros(1,[]); 
    %% Simulado 
    tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N;  
    for j = 1:length(SNR_dB)  
        r=abs((sigma)*randn(1,N) + 1i*(sigma)*randn(1,N));  %Gerar uma canal Rayleigh 
        Stx=tx_mod.*r;      %Simbolo enviado com influencia do canal 
        N0=E/SNR(j);  
        n = sqrt(N0/2)*(randn(1,N)+1i*randn(1,N));%computed noise
        Sr = Stx + n ; %Sinal+ ruido  
        Se = Sr./r;   %Equalizar o sinal 
        C_dem =qamdemod(Se,M);   %Demodulacao do sinal 
        BER_N(j) = sum(C_dem~=tx)/N;  %Calculo de error 
    end 
end