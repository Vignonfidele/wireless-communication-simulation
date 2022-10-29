function [ BER_N_MMSE]=SER_MMSE(SNR_dB, sigma, M , nRx, nTx)
BER_N_MMSE=zeros(1,[]); 
%  L antenas transmissora. 
%  J antenas receptora. 
N = 10^5; % number of bits or symbols  
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
   % Receiver

    % Forming the MMSE equalization matrix W = inv(H^H*H+sigma^2*I)*H^H
    % H^H*H is of dimension [nTx x nTx]. In this case [2 x 2] 
    % Inverse of a [2x2] matrix [a b; c d] = 1/(ad-bc)[d -b;-c a]
    hCof = zeros(2,2,N/nTx)  ; 
    hCof(1,1,:) = sum(h(:,2,:).*conj(h(:,2,:)),1) + 10^(-SNR_dB(i)/10);  % d term
    hCof(2,2,:) = sum(h(:,1,:).*conj(h(:,1,:)),1) + 10^(-SNR_dB(i)/10);  % a term
    hCof(2,1,:) = -sum(h(:,2,:).*conj(h(:,1,:)),1); % c term
    hCof(1,2,:) = -sum(h(:,1,:).*conj(h(:,2,:)),1); % b term
    hDen = ((hCof(1,1,:).*hCof(2,2,:)) - (hCof(1,2,:).*hCof(2,1,:))); % ad-bc term
    hDen = reshape(kron(reshape(hDen,1,N/nTx),ones(2,2)),2,2,N/nTx);  % formatting for division
    hInv = hCof./hDen; % inv(H^H*H)

    hMod =  reshape(conj(h),nRx,N); % H^H operation
    
    yMod = kron(y,ones(1,2)); % formatting the received symbol for equalization
    yMod = sum(hMod.*yMod,1); % H^H * y 
    yMod =  kron(reshape(yMod,2,N/nTx),ones(1,2)); % formatting
    yHat = sum(reshape(hInv,2,N).*yMod,1); % inv(H^H*H)*H^H*y 
    % receiver - hard decision decoding           %Sinal equalizado  
    C_dem =qamdemod(yHat,M);         
    BER_N_MMSE(i) = sum(C_dem~=tx)/N; 
end
end 
