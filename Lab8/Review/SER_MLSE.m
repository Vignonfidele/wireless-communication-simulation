function [ SER_N_MLSE]=SER_MLSE(SNR, sigma, M , nRx, nTx, error)
E=2*(M-1)/3;  
N0 = E./10.^(SNR./10);
sigma_n=  sqrt(N0/2);    
SER_N_MLSE= zeros(1,[]);
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
for i=1:1:length(SNR)  
    c_error=0;
    lop=0;
    while c_error<=error
        tx = randi([0,M-1],nTx,1);   
        tx_mod = qammod(tx, M);                    %Normalizar a modulaçao   
        n = (sigma_n(i))*(randn(nRx,1)+1i*randn(nRx,1)) ;  %Gerar o vector nRx de ruido  
        H = (sigma*(randn(nRx,nTx) + 1i*randn(nRx,nTx)));  %Gerar um canal nRx x nTx
        y= H*tx_mod + n;                            %Sinal recebido 
        %Detector MLSE 
        Sum=zeros(1,[]); 
        for ii=1:1:length(Comin)
            suma = sum(abs(y - H*Comin(ii,:).').^2); 
            Sum(ii)=suma;
        end
        [~, k]= min(Sum); %Encontrar o minimo dos sum dos modulo ao quadrado de todas as possibilidades     
        C_dem =qamdemod(Comin(k,:),M).'; %Demodular o sinal  
        c_error = c_error + sum(tx~=C_dem);      %Contabilizar os error 
        lop=lop+1;  
    end  
    SER_N_MLSE(i)=c_error/(lop*nTx);
end