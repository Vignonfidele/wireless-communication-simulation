function [BER_A_MRC, BER_N_MRC]=SER_MRC1(SNR_dB, sigma, M , L)
    %% Parametro 
    N=1e4;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    gama=2*sita*(sigma^2).*SNR; 
    varsigma = sqrt(gama./(2+gama)); 
    %%  Analitico  Rayleigh Maximal-ratio combining MRC
    Suma=0;
    for k=0:1:L-1
       Suma=Suma+nchoosek(L-1+k,k)*((1+varsigma)/2).^k;
    end
    BER_A_MRC= mi*((1-varsigma)/2).^L.*Suma;   
     %% Simulado Rayleigh Maximal-ratio combining (MRC)
    BER_N_MRC = zeros(1,[]);   
    tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N; 
    for k = 1:L
        for i = 1:length(SNR_dB) 
            h=((sigma)*randn(L,N) + 1i*(sigma)*randn(L,N));  %Gerar uma canal Rayleigh 
            N0=E/SNR(i);  
            n = sqrt(N0/2)*(randn(L,N)+1i*randn(L,N)) ;   %computed noise 
            Stx=tx_mod.*h; 
            Sr = Stx + n ;   % Sinal+ ruido    
            S_eq=  sum(conj(h).*Sr,1)./sum(h.*conj(h),1); % maximal ratio combining
            C_dem =qamdemod(S_eq,M);   %Demodulacao do sinal 
            BER_N_MRC(i) = sum(C_dem~=tx)/N;  %Calculo de error 
        end 
    end  
end


