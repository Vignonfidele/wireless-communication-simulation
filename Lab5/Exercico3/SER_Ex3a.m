function [ BER_A_PS,   BER_N_PS ]=SER_Ex3a(SNR_dB, M,L )

    %% Parametro 
    format long
    N=1000000;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);  
    %% Analitico  
    pr=[0.0225, 0.105,  0.0225, 0.105 , 0.47 ,  0.105, 0.0225, 0.105 , 0.0225]  ;
    r1 = [ 0.5 , 1 , 2  1,  1 , 2 , 2,  2 , 2 ] ;
    BER_A_PS=0;
    for i=1:1:length(pr) 
        Fun=pr(i)*(mi*qfunc( sqrt(r1(i)*sita.*SNR )));
        BER_A_PS=BER_A_PS + Fun;
    end 
    %% Simulado
    pr3=[0.15, 0.7, 0.15]  ;
    r3 = [1/sqrt(2), 1, sqrt(2)] ;
    BER_N_PS = zeros(1,[]); 
    tx = randi([0,M-1],1,N);   % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);    % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N;  % Energia media
    for j = 1:length(SNR_dB)  
        r=zeros(1,[]);
        for ii=1:1:L 
            h=zeros(1,[]);
            Var=rand(1,N);
             for i=1:1:N
                A=Var(i);
                if A<=pr3(1)
                    h(i)= r3(1);
                elseif  A<=(pr3(1)+pr3(2))
                    h(i)= r3(2);
                elseif A<=(pr3(1)+pr3(2)+pr3(3))
                    h(i)= r3(3);
                end 
            end 
            r=[r; h];
        end 
        SNR_Max= max(r);
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
