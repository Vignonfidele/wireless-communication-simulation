function [SER_N_ZF]=SER_ZFk(EbNo_dB, sigma, M , nRx, nTx , error) 
SNR= EbNo_dB + 10*log10(log2(M)); 
E=2*(M-1)/3;  
N0 = 1./10.^(SNR./10);
sigma_n=  sqrt(N0/2);    
SER_N_ZF= zeros(1,[]);
for i=1:1:length(SNR)
    c_error=0;  
    iter=0;
    while c_error<=error
        bits_tx= round(rand(nTx, log2(M))); 
        tx=bi2de(bits_tx, 'left-msb');  
        tx_mod = qammod(tx, M);
        tx_mod_norm=tx_mod/sqrt(E);  
        n = sigma_n(i)*(randn(nRx,1)+1i*randn(nRx,1)) ;    
        H = sigma*(randn(nRx,nTx) + 1i*randn(nRx,nTx )); 
        %Simbolo recebido 
        y=H*tx_mod_norm + n; 
        %ZF
        z=pinv(H)*y;
        %decode
        C_dem =qamdemod(z*sqrt(E),M);      
        c_error = c_error + sum(tx~=C_dem);
        iter=iter+1;  
    end  
    SER_N_ZF(i)=c_error/(iter);
end