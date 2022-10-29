function [pe_num]=function_SER_numeroB(SNR_dB, M, B)  
   pe_num=[];
   SNR = 10.^(SNR_dB./10);
   for j = 1:1:numel(SNR_dB) 
       error=0;
       N=0;
       while error<100000
           N=N+1;
           x = randi([0,M-1]); 
           tx = qammod(x, M);
           E0=3;
           Coef=1/(3/(M-1));
           E=E0*Coef;
           No=E/SNR(j);
           noise_var=No/2; 
           x=-B + (2*B)*rand(1,1);
           y=-B + (2*B)*rand(1,1);
           Sv1= x+1i*y ;
           r=abs(Sv1);
           n= sqrt(noise_var)*randn(1);
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