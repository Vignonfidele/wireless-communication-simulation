function [r] = awgn_noise(S,SNRdB)  
SNR = 10^(SNRdB/10);  
E=sum(abs(S).^2)/length(S); 
N0=E/SNR;  
n = sqrt(N0/2)*randn(size(S));%computed noise 
r = S + n; %received signal
end