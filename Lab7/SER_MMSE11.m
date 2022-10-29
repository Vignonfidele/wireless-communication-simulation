function [SER_N_MMSE]=SER_MMSE11(SNR, sigma, M , nRx, nTx, error) 
E=2*(M-1)/3;  
N0 = E./(10.^(SNR./10));
sigma_n=  sqrt(N0./2);   
SER_N_MMSE= zeros(1,[]);
for i=1:1:length(SNR) 
    conta_error=0;
    lop=0;
    while conta_error<=error
        tx = randi([0,M-1],nTx,1);                    %Converter para decimal para modular com qam 
        tx_mod = qammod(tx, M);                  %Modular 
        tx_mod_norm=tx_mod;                     %Normalizar a modulaçao   
        n = (sigma_n(i))*(randn(nRx,1)+1i*randn(nRx,1)) ;    
        H = (sigma*(randn(nRx,nTx) + 1i*randn(nRx,nTx )));  
        y= H*tx_mod_norm + n;                          %Sinal recebido
        %sigma_n1=
        B= pinv(sigma_n(i).^2*eye(nRx)+H'*H)*H';           %MMSE
        z=(B*y)./diag(B*H);   
        C_dem =qamdemod(z ,M);     
        conta_error = conta_error + sum(tx~=C_dem);
        lop=lop+1;  
    end  
    SER_N_MMSE(i)=conta_error/(lop*nTx);
end