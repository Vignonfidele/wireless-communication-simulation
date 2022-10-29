function [BER_N, BER_A]=funtion_SER_B(SNR_dB, M, B)
    %% Parametro 
    N=1e6;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    BER_N = zeros(1,[]); 
    BER_A = []; 
    %% Analitico
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1); 
    for i = 1:length(SNR_dB)
        gama=sita*SNR(i);
        %% Integracao em intervalo 0<r<B
        coefA=(mi*pi)/(2*sqrt(2*pi)*(B^2)); 
        Integre1=(1/2)*sqrt(pi/2)*(1./gama);
        parte1=coefA*Integre1; 
        %% Integracao em intervalo B<r<sqrt(2)B 
        coefB=mi/(sqrt(2*pi)*B^2); 
        K=-((B^2)*gama)/2;
        A1=sqrt(2)*B*sqrt(gama)*pi*((8*B*(sqrt(-B^2))*gama)+pi+((B^2)*gama*pi));
        A2=8*sqrt(-(1/((B^2)*gama)))*(-(B^2)*gama)^(3/2)*pi*abs(kummerU(-(1/2),0,K));
        A3= (8*meijerG([3/2, 3/2], [], [1, 2], 1/2, K));
        cof= -1/(8*B*gama^(3/2)*sqrt(pi)); 
        %A3=0
        Integral2= cof *(A1+A2+A3) ;
        parte2=(coefB*Integral2); 
        %O resultado de cada integral esta complexa. Por tanto vou integrar
        %Realizar apana o simulacao numerica 
       
        %% Soma das integrais 
        BER= parte1+parte2; 
        BER_A=[BER_A, BER ];
    end  
    
    %% Simulado 
    tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    for j = 1:length(SNR_dB)  
        x=- B + (2*B)*rand(1,N);
        y=-B + (2*B)*rand(1,N);
        Sv1= x+1i*y ;
        r=abs(Sv1); 
        Stx=tx_mod.*r;      %Simbolo enviado com influencia do canal   
        E= sum(abs(Stx).^2)/N;  
        N0=E/SNR(j);  
        n = sqrt(N0/2)*(randn(1,N)+1i*randn(1,N));%computed noise
        Sr = Stx + n ; %Sinal+ ruido  
        Se = Sr./r;   %Equalizar o sinal 
        C_dem =qamdemod(Se,M);   %Demodulacao do sinal 
        BER_N(j) = sum(C_dem~=tx)/N;  %Calculo de error 
    end 
end