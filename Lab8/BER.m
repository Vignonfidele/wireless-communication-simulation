function [P2]=BER(EbN0, sigma, M , J) 
    SNR=10.^(EbN0./10);
    d = 1.5*log2(M)/(M-1);
    varsigma = sqrt((d.*SNR)./(1+d.*SNR));
    Suma = 0 ;
    for k=0:1:J-1 
        Suma=Suma+nchoosek(J-1+k,k)*((1+varsigma)/2).^k;
    end
    SM = sqrt(M);
    P2 = 2*(SM-1)/(SM*log2(SM)) * (((1-varsigma)/2).^J).*Suma ;
       
end 