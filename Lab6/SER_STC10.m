function[ber4]=SER_STC10(Eb_N0_dB,   M )

%% PART 4 - BPSK through rayleigh channel w/ Alamouti (2 Tx, 1 Rx)
%% Simulate BPSK through rayleigh channel w/ Alamouti (2 Tx, 1 Rx)
%Define message length
snr=10.^(Eb_N0_dB./10);

N = 1e5;               % messsage length in symbols
%Generate random message
x = randi([0 M-1],N,1);
%Modulate message 
modulated = qammod(x, M);  % Modular os N sinal 
E= sum(abs(modulated).^2)/N; 

%Encode using Alamouti space-time block coding
encoded=zeros(N,2);
s1=modulated(1:2:end); s2=modulated(2:2:end);
encoded(1:2:end,:)=sqrt(0.5)*[s1,s2];
encoded(2:2:end,:)=sqrt(0.5)*[-conj(s2),conj(s1)];
%Transmit through Rayleigh channels with constant responses over 2 symbols 
h = sqrt(0.5)*kron((randn(N/2,2) + 1j*randn(N/2,2)),[1;1]); 
filtered = h.*encoded;
% Transmit through AWGN chan. and demodulate.
combined = zeros(length(modulated),length(snr));
decoded = zeros(length(modulated),length(snr));
demodulated = zeros(length(modulated),length(snr));
for i=1:length(snr)
   %Add AWGN 
   N0=E/Eb_N0_dB(i);  
   n = sqrt(N0/2)*(randn(N,1)+1i*randn(N,1));
   n_filtered = filtered + n ; 
   %Combine the branches "in the air"
   combined(:,i) = sum(n_filtered,2);
   %Alamouti decode
   y1 = combined(1:2:end,i); y2 = combined(2:2:end,i);
   y = [kron(y1,[1;1]), kron(conj(y2),[1;1])]; 
   h_trans = zeros(N,2); 
   h1=h(1:2:end,1); h2=h(1:2:end,2);
   h_trans(1:2:end,:) = [conj(h1), h2];
   h_trans(2:2:end,:) = [conj(h2), -h1];
   decoded(:,i) = sum(h_trans.*y,2)./sum(h_trans.*conj(h_trans),2);
   %Demodulate
   demodulated(:,i) =qamdemod(decoded(:,i),M);   %Demodulacao do sinal 
   %BER_N_STC(i) = sum(C_dem~=tx)/N;  %Calculo de error 
end
%Compute BER
[~,ber4] = biterr(demodulated,x);
end