function [ BER_A_PS,  BER_N_PS]=SER_Pure_Selection_Discret(SNR_dB, sigma, M , L)

    %% Parametro 
    N=1e6;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    gama=2*sita*(sigma^2).*SNR;  
    %% Analitico  
    pr=[0.15, 0.7, 0.15]  ;
    r = [1/sqrt(2), 1, sqrt(2)] ;
    %%  Analitico  Rayleigh puro selection
    fun1 = @(x)  exp(-(x.^2/2))*(1-exp(-(x.^2./gama))).^L; 
    %Outage =(1-exp(-(R_th.^2./gama)))^L sendo R_th gama comparativa
    BER_A_PS= (mi/(sqrt(2*pi)))*integral(fun1,0,Inf,'ArrayValued',true);   
     %% Simulado Rayleigh puro selection
    BER_N_PS = zeros(1,[]); 
    tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N; 
    for j = 1:length(SNR_dB)  
       rh=[];
       for k=1:1:L
       Var=rand(1,N);
       h=zeros(1,[]);
           for i=1:1:N
               %Gerar uma canal N canal com a pdf
               A=Var(i);
               if A<=pr(1)
                   h(i)= r(1);
               elseif  A<=(pr(1)+pr(2))
                    h(i)= r(2);
               elseif A<=(pr(1)+pr(2)+pr(3))
                    h(i)= r(3);
               end
            end 
            rh=[rh;h];
       end 
        SNR_Max= max(rh);
        Stx=tx_mod.*SNR_Max;      %Simbolo enviado com influencia do canal    
        N0=E/SNR(j);  
        n = sqrt(N0/2)*(randn(1,N)+1i*randn(1,N));%computed noise
        Sr = Stx + n ; %Sinal+ ruido
        Se = Sr./SNR_Max;   %Equalizar o sinal 
        C_dem =qamdemod(Se,M); 
        %Demodulacao do sinal 
        BER_N_PS(j) = sum(C_dem~=tx)/N;  %Calculo de error 
    end 
 
end
