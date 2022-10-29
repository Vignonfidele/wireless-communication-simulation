function [  BER_A, BER_N ]=SER_Ex2(SNR_dB, M )

    %% Parametro 
    format long
    N=1e6;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);  
    %% Analitico  
    pr=[0.15, 0.7, 0.15]  ;
    r = [1/sqrt(2), 1, sqrt(2)] ;
    BER_A=0;
    for i=1:1:3
        Fun=pr(i)*(mi*qfunc( sqrt((r(i)^2)*sita.*SNR )));
        BER_A=BER_A + Fun;
    end 
    %% Simulado
    BER_N = zeros(1,[]); 
    tx = randi([0,M-1],1,N);   % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);    % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N;  % Energia media
    for j = 1:length(SNR_dB) 
        h=zeros(1,[]);
        Var=rand(1,N);
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
        Stx=tx_mod.*h;      %Simbolo enviado com influencia do canal  
        N0=E/SNR(j);  
        n=sqrt(N0/2)*(randn(1,N)+1i*randn(1,N));%computed noise
        Sr = Stx + n ; %Sinal+ ruido  
        Se = Sr./h;   %Equalizar o sinal 
        C_dem =qamdemod(Se, M);       %Demodulacao do sinal 
        BER_N(j) = sum(C_dem~=tx)/N;  %Calculo de error 
    end 
end
