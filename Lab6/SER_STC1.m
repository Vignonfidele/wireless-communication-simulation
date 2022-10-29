function[BER_N_STC]=SER_STC1(SNR_dB, sigma, M , J)
    N = 1e6;   
    BER_N_STC = zeros(1,[]);   
    tx = randi([0,M-1],N,1); % Genar N sinal para analisar (1 M-1)
    tx_mod = qammod(tx, M);  % Modular os N sinal 
    E= sum(abs(tx_mod).^2)/N;
    Normalize=1/sqrt(2);  
    tx_mod_2=zeros(N,2);
    Lin1=tx_mod(1:2:end);
    Lin2=tx_mod(2:2:end); 
    tx_mod_2(1:2:end,:)=Normalize*[Lin1,        Lin2];
    tx_mod_2(2:2:end,:)=Normalize*[-conj(Lin2), conj(Lin1)];  
    for i=1:length(SNR_dB) 
        h=sigma*kron((randn(N/2,2) + 1j*randn(N/2,2)),[1;1]);   %forma a matriz dos canais. 
        N0=E/SNR_dB(i);  
        n = sqrt(N0/2)*(randn(N,1)+1i*randn(N,1));  %computed noise  
        %Sr = h.*tx_mod_2 + n ;                 %Rajada de sinal recebido + o ruido branco  
        Sr_con = sum(h.*tx_mod_2,2)+n;
        
%         Sr_con = kron(reshape(Sr,2,N/2),ones(12));    %Sepera os vectores de recepcion   
%         Sr_con(1,1:1:N) = Sr;                             %Adecua o sinal recebido 
%         Sr_con(2,1:2:N) = conj(Sr(2:2:N));       %
%         Sr_con(2,2:2:N) = conj(Sr(1:2:N));
%         % adecuando o canal...
%         heq=zeros(2,N);
%         heq(1,1:1:N)=conj(H(1,1:1:N));
%         heq(2,1:2:N)=H(2,1:2:N);
%         heq(2,2:2:N)=-H(2,2:2:N);  
         
       %Alamouti decode
       y1 = Sr_con(1:2:end); y2 = Sr_con(2:2:end);
       y = [kron(y1,[1;1]), kron(conj(y2),[1;1])]; 
       h_trans = zeros(N,2); 
       
       h1=h(1:2:N,1); h2=h(1:2:N,2);
       h_trans(1:2:end,:) = [conj(h1), h2];
       h_trans(2:2:end,:) = [conj(h2), -h1];
       
       S_eq = sum(h_trans.*y,2)./sum(h_trans.*conj(h_trans),2);
       %Demodulate   
        C_dem =qamdemod(S_eq,M);   %Demodulacao do sinal 
        BER_N_STC(i) = sum(C_dem~=tx)/N;  %Calculo de error
    end
end 