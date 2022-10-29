function [pe_numerico]=function_SER_analitico(SNR_dB, M, B) 
    %% Parametre
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    %% Gera canal
    x=-B + (2*B)*rand(1,1);
    y=-B + (2*B)*rand(1,1);
    Sv1= x+1i*y ;
    r=abs(Sv1);  
    pe_numerico=mi.*erfc(sqrt(sita.*(r.^2).*SNR));  
end 