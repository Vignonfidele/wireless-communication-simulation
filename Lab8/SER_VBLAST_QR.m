function [ SER_N_VBLAST]=SER_VBLAST_QR(EbNo_dB, sigma, M , nRx, nTx, error)
k=log2(M);
SNR= EbNo_dB ;%+ 10*log10(k); 
E=2*(M-1)/3;  
N0 = E./10.^(SNR./10);
sigma_n=  sqrt(N0/2);   
SER_N_VBLAST= zeros(1,[]);
for i=1:1:length(EbNo_dB)  
    c_error=0;
    lop=0;
    while c_error<=error
        bits_tx= round(rand(nTx, log2(M)));              %Gerar bits  
        tx = randi([0,M-1],nTx);                   %Converter para decimal para modular com qam 
        tx_mod = qammod(tx, M);                  %Modular 
        tx_mod_norm=tx_mod/sqrt(E);                    %Normalizar a modulaçao   
        n = (sigma_n(i))*(randn(nRx,1)+1i*randn(nRx,1)) ;    
        H = (sigma*(randn(nRx,nTx) + 1i*randn(nRx,nTx )));
        y=H*tx_mod_norm + n; 
        H_bar_inver=[H;sigma_n(i).^2*eye(nTx)];
        [Q,R] = QR_decomp(H_bar_inver);
        Q1=Q(1:1:nTx,:);
        Q2=Q((nTx+1):1:end,:); 
        Co=(R*tx_mod_norm-sigma_n(i).^2*Q2'*tx_mod_norm+Q1'*n); 
        C_dem=qamdemod(Co(1:1:2) ,M);
        c_error = c_error + sum(C_dem~=tx);
        lop=lop+1;  
    end  
    SER_N_VBLAST(i)=c_error/(lop);
end