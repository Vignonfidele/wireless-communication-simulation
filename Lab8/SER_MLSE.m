function [ SER_N_MLSE]=SER_MLSE(EbNo_dB, sigma, M , nRx, nTx, error)
k=log2(M);
SNR= EbNo_dB + 10*log10(k); 
E=2*(M-1)/3;  
N0 = 1./10.^(SNR./10);
sigma_n=  sqrt(N0/2);    
SER_N_MLSE= zeros(1,[]);
for i=1:1:length(EbNo_dB)  
    c_error=0;
    lop=0;
    while c_error<=error
        bits_tx= round(rand(nTx, log2(M))); 
        tx=bi2de(bits_tx,'left-msb');  
        %tx = randi([0,M-1],nTx,1);              %Gerar nTx simbolos para transmitir 
        tx_mod = qammod(tx, M);                  %Modular  os simbolo gerados
        tx_mod_norm=tx_mod/sqrt(E);                    %Normalizar a modulaçao   
        n = (sigma_n(i))*(randn(nRx,1)+1i*randn(nRx,1)) ;  %Gerar o vector nRx de ruido  
        H = (sigma*(randn(nRx,nTx) + 1i*randn(nRx,nTx)));  %Gerar um canal nRx x nTx
        y= H*tx_mod_norm + n;                            %Sinal recebido 
        %Detector MLSE
        x = (0:M-1); %Gerar todos os possiveis simbolos  
        symbin = qammod(x,M )/sqrt(E);  %Modular todos os todos os possiveis simbolos  
        Comin=[];
        g=0;
        %Combinar todas as possibilidade dada o numero de antenas
        %transmissora e os possiveis simbolos dada o modulação usada.... 
        for k1=1:1:length(symbin)
            for k2=1:1:length(symbin)
                g=g+1;
                Comin(g,:)= [symbin(k1), symbin(k2)] ; 
            end
        end              
        Sum=zeros(1,[]); 
        for ii=1:1:length(Comin)
            suma = sum(abs(y - H*Comin(ii,:).').^2); 
            Sum(ii)=suma;
        end
        [~, k]= min(Sum); %Encontrar o minimo dos sum dos modulo ao quadrado de todas as possibilidades     
        C_dem =qamdemod(Comin(k,:)*sqrt(E),M).'; %Demodular o sinal  
        c_error = c_error + sum(tx~=C_dem);      %Contabilizar os error 
        lop=lop+1;  
    end  
    SER_N_MLSE(i)=c_error/(lop);
end