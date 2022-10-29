function [ BER_A_MRC,  BER_N_MRC]=SER_MRC(SNR_dB, sigma, M , L)

    %% Parametro 
     %% Simulado Rayleigh puro selection
    BER_N_MRC = zeros(1,[]); 
    tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N;  
    for j = 1:length(SNR_dB) 
        h = ((sigma)*randn(L,N) + 1i*(sigma)*randn(L,N));  
        Stx = tx_mod.*h;      %Simbolo enviado com influencia do canal    
        N0 = E/SNR(j);  
        n = sqrt(N0/2)*(randn(L,N)+1i*randn(L,N));%computed noise
        Sr = Stx + n ; %Sinal+ ruido
        Sr_p = Sr.*conj(h) ; 
        Sr_Com=sum(Sr_p);     %Saida do MRC
        Sr_eq=Sr_Com./sum(h);
        C_dem =qamdemod(Sr_eq, M); 
        %Demodulacao do sinal 
        BER_N_MRC(j) = sum(C_dem~=tx)/N;  %Calculo de error 
    end 
end
