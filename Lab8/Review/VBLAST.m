function [ SER_N_VBLAST]=VBLAST(SNR, sigma, M , nRx, nTx, error)
E=2*(M-1)/3;  
N0 = E./10.^(SNR./10);
sigma_n =  sqrt(N0./2);   
SER_N_VBLAST= zeros(1,[]);
for i=1:1:length(SNR)  
    c_error=0;
    lop=0;
    while c_error<=error
        tx = randi([0,M-1],nTx,1);                    %Converter para decimal para modular com qam 
        tx_mod = qammod(tx, M);                     %Normalizar a modulaçao   
        n = sigma_n(i)*(randn(nRx,1)+1i*randn(nRx,1)) ;    
        H = sigma*(randn(nRx,nTx) + 1i*randn(nRx,nTx ));  
        y= H*tx_mod + n;
        %Procedimento vblast-mmse 
        C_dem=zeros(1,[]);
        for ii = 1:1:nRx 
            B= pinv(sigma_n(i).^2*eye(nRx)+H'*H)*H'; % MMSE    
            V1=sum(abs(B).^2,2);
            v=V1;
            v(V1==0) = NaN; 
            [~,k]=min(v); 
            Co=B(k,:)*y;
            C_dem(k)=qamdemod(Co,M);
            y=y-H(:,k)*(qammod(C_dem(k),M));
            H(:,k)=0;  
        end 
        c_error = c_error + sum(C_dem~=tx.');
        lop=lop+1;  
    end  
    SER_N_VBLAST(i)=c_error/(lop*nTx);
end