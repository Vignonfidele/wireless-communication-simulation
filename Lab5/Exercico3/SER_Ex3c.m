function [ BER_A_EGC,   BER_N_EGC ]=SER_Ex3c(SNR_dB, M,L )

    %% Parametro 
    format long
    N=1e6;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);  
    %% Analitico  
    pr=[0.0225, 0.105,  0.0225, 0.105 , 0.47 ,  0.105, 0.0225, 0.105 , 0.0225]  ;
    r1 = [ sqrt(2) , 1+1/sqrt(2) , sqrt(2)+1/sqrt(2),  1+1/sqrt(2),  2 , 1+sqrt(2) , sqrt(2)+1/sqrt(2), sqrt(2)+1 , sqrt(2)+sqrt(2) ] ;
    BER_A_EGC=0;
    for i=1:1:length(pr) 
        Fun=pr(i)*(mi*qfunc( sqrt(r1(i)*sita.*SNR )));
        BER_A_EGC=BER_A_EGC + Fun;
    end 
    %% Simulado
    pr3=[0.15, 0.7, 0.15]  ;
    r3 = [1/sqrt(2), 1, sqrt(2)] ;
    BER_N_EGC = zeros(1,[]); 
    tx = randi([0,M-1],1,N);   % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);    % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N;  % Energia media
    for k = 1:L
        for i = 1:length(SNR_dB) 
            r=zeros(1,[]);
            for ii=1:1:L 
                h=zeros(1,[]);
                Var=rand(1,N);
                 for j=1:1:N
                    A=Var(j);
                    if A<=pr3(1)
                        h(j)= r3(1);
                    elseif  A<=(pr3(1)+pr3(2))
                        h(j)= r3(2);
                    elseif A<=(pr3(1)+pr3(2)+pr3(3))
                        h(j)= r3(3);
                    end 
                 end 
                r=[r; h];
            end   
            N0=E/SNR(i);  
            n = sqrt(N0/2)*(randn(L,N)+1i*randn(L,N));%computed noise 
            Stx=r.*tx_mod; 
            Sr = Stx + n ;   % Sinal+ ruido  
            %Sfa=Sr.*exp(-1i*angle(r)); %Remover fase
            S_eq=sum(Sr,1)./sum(r,1)         ;   %equalizar
            C_dem =qamdemod(S_eq,M);   %Demodulacao do sinal 
            BER_N_EGC(i) = sum(C_dem~=tx)/N;  %Calculo de error 
        end 
    end  
end
