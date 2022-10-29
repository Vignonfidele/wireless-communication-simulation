function [ BER_A ]=SER_SISO(SNR_dB, M, sigma, error)
    %% Parametro  
    SNR=10.^(SNR_dB./10);
%     
%     k=log2(M);
%     SNR1= SNR_dB; %+ %10*log10(k); 
%     E=2*(M-1)/3;  
%     N0 = 1./10.^(SNR1./10);
%     sigma_n=  sqrt(N0/2);
    %% Analitico 
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1);
    gama=2*sita*(sigma^2).*SNR;
    BER_A=(mi/2)*(1-sqrt(gama./(2+gama))); 
    %%
%     SER_N_ZF= zeros(1,[]);
% for i=1:1:length(SNR_dB)
%     c_error=0;  
%     iter=0;
%     while c_error<=error
%         bits_tx= round(rand(1, log2(M))); 
%         tx=bi2de(bits_tx, 'left-msb');  
%         tx_mod = qammod(tx, M);
%         tx_mod_norm=tx_mod/sqrt(E); 
%         H = abs(sigma*(randn(1,1) + 1i*randn(1,1 ))); 
%         n = (sigma_n(i))*(randn(1,1)+1i*randn(1,1)) ;   
%         %Simbolo recebido 
%         y=H*tx_mod_norm + n; 
%         %ZF
%         z= y./H;
%         %decode
%         C_dem =qamdemod(z*sqrt(E),M);      
%         c_error = c_error + sum(tx~=C_dem);
%         iter=iter+1;  
%     end  
%     SER_N_ZF(i)=c_error/(iter);
% end
end