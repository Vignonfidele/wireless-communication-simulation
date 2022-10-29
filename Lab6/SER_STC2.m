function[BER_N_STC]=SER_STC1(SNR_dB, sigma, M , J)%Define message length
N = 1e6;               % messsage length in symbols
%Generate random message
SNR=10.^(SNR_dB./10);
x = randi([0 M-1],N,1);
%Modulate message
modulated = qammod(x, M);

E= sum(abs(modulated).^2)/N;
%modulated = step(PSK_Mod,x);


%Encode using Alamouti space-time block coding
encoded=zeros(N,2);
s1=modulated(1:2:end); s2=modulated(2:2:end);
encoded(1:2:end,:)=sqrt(0.5)*[s1,s2];
encoded(2:2:end,:)=sqrt(0.5)*[-conj(s2),conj(s1)];
%Transmit through Rayleigh channels with constant responses over 2 symbols 
h = sqrt(0.5)*kron((randn(N/2,2) + 1j*randn(N/2,2)),[1;1]); 
filtered = h.*encoded;
% Transmit through AWGN chan. and demodulate.
 BER_N_STC = zeros(1,[]); 
%decoded = zeros(length(modulated),length(SNR_dB));
 
for i=1:length(SNR_dB) 
    N0=E/SNR(i);  
    n = sqrt(N0/2)*(randn(N,1)+1i*randn(N,1));%computed noise 
   %Add AWGN  
   n_filtered = filtered + n ; 
   %Combine the branches "in the air"
   combined= sum(n_filtered,2);
   %Alamouti decode
   y1 = combined(1:2:end); y2 = combined(2:2:end);
   y = [kron(y1,[1;1]), kron(conj(y2),[1;1])]; 
   h_trans = zeros(N,2); 
   h1=h(1:2:end,1); h2=h(1:2:end,2);
   h_trans(1:2:end,:) = [conj(h1), h2];
   h_trans(2:2:end,:) = [conj(h2), -h1];
   decoded = sum(h_trans.*y,2)./sum(h_trans.*conj(h_trans),2);
   %Demodulate
   C_dem =qamdemod(decoded,M);   %Demodulacao do sinal 
   BER_N_STC(i) = sum(C_dem~=x)/N;  %Calculo de error 
   %demodulated(:,i) = step(PSK_Demod,decoded(:,i)); 
end