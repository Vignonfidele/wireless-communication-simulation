function [Sr,n,N0] = awgn_noise(s,snr) 
E= sum(abs(s).^2)/N; 
N0=E/snr;  
if(isreal(s))
    n = sqrt(N0/2)*randn(size(s));%computed noise
else
    n = sqrt(N0/2)*(randn(size(s))+1i*randn(size(s)));%computed noise
end 
Sr = s + n ; 
end