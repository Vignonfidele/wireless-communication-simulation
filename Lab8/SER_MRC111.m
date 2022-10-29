function [ SER_N_VBLAST]=SER_MRC111(EbNo_dB, sigma, M , L, error)
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
        bits_tx= round(rand(1, log2(M)));              %Gerar bits  
        tx=bi2de(bits_tx, 'left-msb');                   %Converter para decimal para modular com qam 
        tx_mod = qammod(tx, M);                  %Modular 
        tx_mod_norm=tx_mod/sqrt(E);                    %Normalizar a modulaçao   
        h=((sigma)*randn(L,1) + 1i*(sigma)*randn(L,1));  %Gerar uma canal Rayleigh 
        n = sigma_n(i)*(randn(L,1)+1i*randn(L,1)) ;   %computed noise 
        Stx=tx_mod_norm.*h; 
        Sr = Stx + n ;   % Sinal+ ruido    
        S_eq=  sum(conj(h).*Sr,1)./sum(h.*conj(h),1); % maximal ratio combining
        C_dem =qamdemod(S_eq*sqrt(E),M);   %Demodulacao do sinal  
        if C_dem~=tx
            c_error = c_error + 1;
        end
        lop=lop+1;  
    end  
    SER_N_VBLAST(i)=c_error/lop;
end