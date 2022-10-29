function [BER_A_Rayleigh, BER_A_PS, BER_A_MRC, BER_N_Rayleigh, BER_N_PS]=SER_all(SNR_dB, sigma, M , L)

    %% Parametro 
    N=1e6;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    gama=2*sita*(sigma^2).*SNR; 
    varsigma = sqrt(gama./(2+gama));
    %% Analitico  Rayleigh sem diversidade   
    BER_A_Rayleigh=(mi/2)*(1-sqrt(gama./(2+gama)));
    %%  Analitico  Rayleigh puro selection
    fun1 = @(x)  exp(-(x.^2/2))*(1-exp(-(x.^2./gama))).^L; 
    %Outage =(1-exp(-(R_th.^2./gama)))^L sendo R_th gama comparativa
    BER_A_PS= (mi/(sqrt(2*pi)))*integral(fun1,0,Inf,'ArrayValued',true); 
    %%  Analitico  Rayleigh Maximal-ratio combining MRC
    Suma=0;
    for k=0:1:L-1
       Suma=Suma+nchoosek(L-1+k,k)*((1+varsigma)/2).^k;
    end
    BER_A_MRC= mi*((1-varsigma)/2).^L.*Suma; 
      
    %% Simulado Rayleigh sem diversidade  
    BER_N_Rayleigh = zeros(1,[]);    
    tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    for j = 1:length(SNR_dB)  
        r=abs((sigma)*randn(1,N) + 1i*(sigma)*randn(1,N));  %Gerar uma canal Rayleigh 
        Stx=tx_mod.*r;      %Simbolo enviado com influencia do canal   
        E= sum(abs(Stx).^2)/N;  
        N0=E/SNR(j);  
        n = sqrt(N0/2)*(randn(1,N)+1i*randn(1,N));%computed noise
        Sr = Stx + n ; %Sinal+ ruido  
        Se = Sr./r;   %Equalizar o sinal 
        C_dem =qamdemod(Se,M);   %Demodulacao do sinal 
        BER_N_Rayleigh(j) = sum(C_dem~=tx)/N;  %Calculo de error 
    end 
     %% Simulado Rayleigh puro selection
    BER_N_PS = zeros(1,[]);
    BER_N_Rayleigh = zeros(1,[]);    
    tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    for j = 1:length(SNR_dB)  
        r=abs((sigma)*randn(L,N) + 1i*(sigma)*randn(L,N));  %Gerar uma canal Rayleigh 
        SNR_Max= max(r);
        Stx=tx_mod.*SNR_Max;      %Simbolo enviado com influencia do canal   
        E= sum(abs(Stx).^2)/N;  
        N0=E/SNR(j);  
        n = sqrt(N0/2)*(randn(1,N)+1i*randn(1,N));%computed noise
        Sr = Stx + n ; %Sinal+ ruido
        Se = Sr./SNR_Max;   %Equalizar o sinal 
        C_dem =qamdemod(Se,M); 
        %Demodulacao do sinal 
        BER_N_PS(j) = sum(C_dem~=tx)/N;  %Calculo de error 
    end 
    
%      %% Simulado Rayleigh Maximal-ratio combining (MRC)
%     BER_N_MRC = zeros(1,[]);   
%     tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
%     tx_mod = qammod(tx, M);  % Modular os N sinal 
%     for j = 1:length(SNR_dB)
%         Sr_c=zeros(1,[]);
%         r_eq=zeros(1,[]);
%         for i=1:1:L
%             r=abs((sigma)*randn(1,N) + 1i*(sigma)*randn(1,N));  %Gerar uma canal Rayleigh
%             r_eq=r_eq+r;
%             Stx=tx_mod.*r;      %Simbolo enviado com influencia do canal   
%             E= sum(abs(Stx).^2)/N;  
%             N0=E/SNR(j);  
%             n = sqrt(N0/2)*(randn(1,N)+1i*randn(1,N));%computed noise
%             Sr = Stx + n ;   % Sinal+ ruido  
%             Sr_p=Sr*conj(r); % Sinal ponderada com o ganho conjugado
%             Sr_c=Sr_c+Sr_p;  % Sinal na saida do combinador. 
%         end
%         Se = Sr_c./r_eq;   %Equalizar o sinal 
%         C_dem =qamdemod(Se,M);   %Demodulacao do sinal 
%         BER_N(j) = sum(C_dem~=tx)/N;  %Calculo de error 
%     end 
%     
%     %% Simulado Rayleigh EGC 
%     BER_N_EGC = zeros(1,[]);   
%     tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
%     tx_mod = qammod(tx, M);  % Modular os N sinal 
%     for j = 1:length(SNR_dB)
%         Sr_c=zeros(1,[]);
%         r_eq=zeros(1,[]);
%         for i=1:1:L
%             r=abs((sigma)*randn(1,N) + 1i*(sigma)*randn(1,N));  %Gerar uma canal Rayleigh 
%             r_eq=r_eq+r;
%             Stx=tx_mod.*r;      %Simbolo enviado com influencia do canal   
%             E= sum(abs(Stx).^2)/N;  
%             N0=E/SNR(j);  
%             n = sqrt(N0/2)*(randn(1,N)+1i*randn(1,N));%computed noise
%             Sr = Stx + n ;   % Sinal+ ruido 
%             theta=angle(r);
%             Sr_p=Sr*exp(1j*theta); % Sinal ponderada com o ganho conjugado
%             Sr_c=Sr_c+Sr_p;  % Sinal na saida do combinador. 
%         end
%         Se = Sr_c./r_eq;   %Equalizar o sinal 
%         C_dem =qamdemod(Se,M);   %Demodulacao do sinal 
%         BER_N(j) = sum(C_dem~=tx)/N;  %Calculo de error 
%     end 


end
