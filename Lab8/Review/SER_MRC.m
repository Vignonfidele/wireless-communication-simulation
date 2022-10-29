function [BER_A_MRC ]=SER_MRC(SNR_dB, sigma, M , J)
    %% Parametro  
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    gama=2*sita*(sigma^2).*SNR; 
    varsigma = sqrt(gama./(2+gama)); 
    %%  Analitico  Rayleigh Maximal-ratio combining MRC
    Suma=0;
    for k=0:1:J-1
       Suma=Suma+nchoosek(J-1+k,k)*((1+varsigma)/2).^k;
    end
    BER_A_MRC= mi*((1-varsigma)/2).^J.*Suma;  
   
  
end