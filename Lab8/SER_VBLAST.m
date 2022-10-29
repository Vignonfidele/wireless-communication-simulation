function [ SER_N_VBLAST]=SER_VBLAST(EbNo_dB, sigma, M , nRx, nTx, error)
k=log2(M);
SNR= EbNo_dB + 10*log10(k); 
E=2*(M-1)/3;  
N0 = 1./10.^(SNR./10);
sigma_n=  sqrt(N0/2);   
SER_N_VBLAST= zeros(1,[]);
for i=1:1:length(EbNo_dB)  
    c_error=0;
    lop=0;
    while c_error<=error
        bits_tx= round(rand(nTx, log2(M)));              %Gerar bits  
        tx=bi2de(bits_tx, 'left-msb');                   %Converter para decimal para modular com qam 
        tx_mod = qammod(tx, M);                  %Modular 
        tx_mod_norm=tx_mod/sqrt(E);                    %Normalizar a modulaçao   
        n = (sigma_n(i))*(randn(nRx,1)+1i*randn(nRx,1)) ;    
        H = (sigma*(randn(nRx,nTx) + 1i*randn(nRx,nTx )));  
        y= H*tx_mod_norm + n;
        %Procedimento vblast-mmse 
        C_dem=zeros(1,[]);
        for ii = 1:1:nRx 
            B= pinv(sigma_n(i).^2*eye(nRx)+H'*H)*H'; % MMSE    
            V1=sum(abs(B).^2,2);
            v=V1;
            v(V1==0) = NaN; 
            [~,k]=min(v); 
            Co=B(k,:)*y;
            C_dem(k)=qamdemod(Co*sqrt(E),M);
            y=y-H(:,k)*(qammod(C_dem(k),M)/sqrt(E));
            H(:,k)=0;  
        end 
        c_error = c_error + sum(C_dem~=tx.');
        lop=lop+1;  
    end  
    SER_N_VBLAST(i)=c_error/(lop);
end