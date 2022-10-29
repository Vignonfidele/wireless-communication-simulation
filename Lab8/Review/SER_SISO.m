function [ SER_A ]=SER_SISO(SNR_dB, M, sigma)
    %% Parametro  
    SNR=10.^(SNR_dB./10); 
    %% Analitico 
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    gama=2*sita*(sigma^2).*SNR;
    SER_A=(mi/2)*(1-sqrt(gama./(2+gama))); 
 
end