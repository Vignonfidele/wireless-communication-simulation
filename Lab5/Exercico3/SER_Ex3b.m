function [ BER_A_MRC,   BER_N_MRC ]=SER_Ex3b(SNR_dB, M,L )

    %% Parametro 
    format long
    N=1e6;  %Numero de amostra
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);  
    %% Analitico  
    pr=[0.0225, 0.105,  0.0225, 0.105 , 0.47 ,  0.105, 0.0225, 0.105 , 0.0225]  ;
    r1 = [ 1 , 1.5 , 2.5  1.5,  2 , 3 , 2.5,  3 , 4 ] ;
    BER_A_MRC=0;
    for i=1:1:length(pr) 
        Fun=pr(i)*(mi*qfunc( sqrt(r1(i)*sita.*SNR )));
        BER_A_MRC=BER_A_MRC + Fun;
    end 
    %% Simulado
    pr3=[0.15, 0.7, 0.15]  ;
    r3 = [1/sqrt(2), 1, sqrt(2)] ;
    BER_N_MRC = zeros(1,[]); 
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
            %h=((sigma)*randn(L,N) + 1i*(sigma)*randn(L,N));  %Gerar uma canal Rayleigh 
            N0=E/SNR(i);  
            n = sqrt(N0/2)*(randn(L,N)+1i*randn(L,N));%computed noise 
            Stx=tx_mod.*r; 
            Sr = Stx + n ;   % Sinal+ ruido    
            S_eq=  sum(conj(r).*Sr,1)./sum(r.*conj(r),1); % maximal ratio combining
            C_dem =qamdemod(S_eq,M);   %Demodulacao do sinal 
            BER_N_MRC(i) = sum(C_dem~=tx)/N;  %Calculo de error 
        end 
    end   
end
