
function [pe_ana]=function_SER_analitico(SNR_dB, M, sigma) 
    SNR=10.^(23./10)
    
    mi=(4*(sqrt(M)-1))/(sqrt(M))
    sita=3/(M-1)
    gama=2*sita*(sigma^2).*SNR;
    pe_ana=(mi/2)*(1-sqrt(gama./(2+gama)));  
end 