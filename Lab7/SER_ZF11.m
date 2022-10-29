function [SER_N_ZF]=SER_ZF11(SNR, sigma, M , nRx, nTx , error)
E=2*(M-1)/3;  
N0 = E./(10.^(SNR./10));
sigma_n=  sqrt(N0./2);  
SER_N_ZF= zeros(1,[]);
for i=1:1:length(SNR)
    c_error=0;  
    iter=0;
    while c_error<=error
        tx = randi([0,M-1],nTx,1);  
        tx_mod = qammod(tx, M); 
        n = (sigma_n(i))*(randn(nRx,1)+1i*randn(nRx,1)) ;    
        H =  sigma*(randn(nRx,nTx) + 1i*randn(nRx,nTx ));  
        y=H*tx_mod + n;  
        z=pinv(H)*y; %ZF 
        C_dem =qamdemod(z,M);  %decode
        c_error = c_error + sum(tx~=C_dem); %Conta os error
        iter=iter+1;                        %Numero de interacao
    end  
    SER_N_ZF(i)=c_error/(iter*nTx);
end