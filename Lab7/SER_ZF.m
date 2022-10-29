function [ BER_N_ZF]=SER_ZF(SNR_dB, sigma, M , nRx, nTx)
rng(1,'twister')
BER_N_ZF=zeros(1,[]); 
 %  L antenas transmissora. 
  %  J antenas receptora. 
N = 4; % number of bits or symbols  
SNR=10.^(SNR_dB./10);
for i = 1:length(SNR_dB) 
    % Transmitter
    tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N;  
    N0=E/SNR(i);  
    n = sqrt(N0/2)*(randn(nRx,N/nTx)+1i*randn(nRx,N/nTx)) ;    
    h = sigma*(randn(nRx,nTx,N/nTx) + 1i*randn(nRx,nTx,N/nTx));  
    sMod = kron(tx_mod,ones(nRx,1)); % 
    sMod = reshape(sMod,[nRx,nTx,N/nTx]); % grouping in [nRx,nTx,N/NTx ] matrix  
    % Channel and noise Noise addition  
    y = squeeze(sum(h.*sMod,2)) +  n;  
    hInv=zeros(nRx,nTx,N/nTx);
    
    for k=1:1:N/nTx
        %hInv(:,:,k)=inv(h(:,:,k)'*h(:,:,k));
        hInv(:,:,k)=inv(h(:,:,k));
    end
    yMod = kron(y,ones(1,2));
    yMo=[];
    for k=1:1:N/nTx
        yMo=[yMo, sum(yMod(:,k).*hInv(:,:,k),1)]; 
    end 
%     hMod =  reshape(conj(h),nRx,N); % H^H operation
%     yMod = kron(y,ones(1,2)); % formatting the received symbol for equalization
%     yMod = sum(hInv.*yMod,1); % H^H * y 
%     yMod =  kron(reshape(yMod,2,N/nTx),ones(1,2)); % formatting
%     yHat = sum(reshape(hInv,2,N).*yMod,1); % inv(H^H*H)*H^H*y  
    C_dem =qamdemod(yMo,M);         
    BER_N_ZF(i) = sum(C_dem~=tx)/N; 
end
end 
