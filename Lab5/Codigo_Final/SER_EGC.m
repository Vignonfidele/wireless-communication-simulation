function [ BER_A_EGC , BER_N_EGC]=SER_EGC(SNR_dB, sigma, M , L)
    %% Parametro 
    N=1e6;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    gama=2*sita*(sigma^2).*SNR;  
    %%  Analitico  Rayleigh Maximal-ratio combining MRC
    BER_A_EGC= mi*(1 - sqrt(gama.*(gama+2))./(gama+1) ) ;
     %% Simulado Rayleigh  EGC
    BER_N_EGC = zeros(1,[]);   
    tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N; 
    for k = 1:L
        for i = 1:length(SNR_dB)  
            h=((sigma)*randn(L,N) + 1i*(sigma)*randn(L,N));  %Gerar uma canal Rayleigh
            N0=E/SNR(i);  
            n = sqrt(N0/2)*(randn(L,N)+1i*randn(L,N));%computed noise 
            Stx=h.*tx_mod; 
            Sr = Stx + n ;   % Sinal+ ruido  
            Sfa=Sr.*exp(-1i*angle(h)); %Remover fase
            S_eq=sum( Sfa,1)./sum(h.*exp(-1i*angle(h)),1)         ;   %equalizar
            C_dem =qamdemod(S_eq,M);   %Demodulacao do sinal 
            BER_N_EGC(i) = sum(C_dem~=tx)/N;  %Calculo de error     
        end 
    end  
end


