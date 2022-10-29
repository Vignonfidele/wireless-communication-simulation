function [pe_num]=function_SER_numero(SNR_dB, M, sigma)  
   pe_num=[];
   SNR = 10.^(SNR_dB./10);
   for j = 1:1:numel(SNR_dB) 
       error=0;
       N=0;
       while error<1000
           N=N+1;
           x = randi([0,M-1]); 
           tx = qammod(x, M);
           E0=2.4142; 
           No=E0/SNR(j);   
           r=abs((sigma)*randn(1)+1i*(sigma)*randn(1)); 
           n=sqrt(No/2)*(randn(1)+1i*randn(1));
           Sr=tx*r+n; 
           Se=Sr/r;
           C_dem =qamdemod(Se,M);
           if C_dem~=x
              error=error+1;
           end
        end
        pe=error/N;
        pe_num=[pe_num, pe];
   end       
end 