function[simBer]=SER_STC01(Eb_N0_dB, sigma, M , nRx)

N = 1e6;               % messsage length in symbols
%Generate random message
x = randi([0 M-1],N,1);
%Modulate message
modulated = step(PSK_Mod,x);
%Encode using Alamouti space-time block coding
encoded=zeros(N,4);
s1=modulated(1:2:end); s2=modulated(2:2:end);
encoded(1:2:end,:)=sqrt(0.5)*[s1,s2, s1,s2];
encoded(2:2:end,:)=sqrt(0.5)*[-conj(s2),conj(s1), -conj(s2),conj(s1)];
%Transmit through Rayleigh channels with constant responses over 2 symbols 
h = sqrt(0.5)*kron((randn(N/2,4) + 1j*randn(N/2,4)),[1;1]); 
filtered = h.*encoded;
% Transmit through AWGN chan. and demodulate.
combined = zeros(length(modulated),2,length(snr));
decoded = zeros(length(modulated),length(snr));
demodulated = zeros(length(modulated),length(snr));
for i=1:length(snr)
   %Add AWGN  
   n_filtered = awgn(filtered,snr(i),'measured'); 
   %Combine the branches "in the air"
   combined(:,:,i) = [sum(n_filtered(:,1:2),2), sum(n_filtered(:,3:4),2)];
   %Alamouti decode
   y1_1 = combined(1:2:end,1,i); y2_1 = combined(2:2:end,1,i);
   y1_2 = combined(1:2:end,2,i); y2_2 = combined(2:2:end,2,i);
   y = [kron(y1_1,[1;1]),kron(conj(y2_1),[1;1]),...
        kron(y1_2,[1;1]),kron(conj(y2_2),[1;1])]; 
   h_trans = zeros(N,4); 
   h1=h(1:2:end,1); h2=h(1:2:end,2); h3=h(1:2:end,3); h4=h(1:2:end,4);
   h_trans(1:2:end,:) = [conj(h1),h2,  conj(h3),h4];
   h_trans(2:2:end,:) = [conj(h2),-h1, conj(h4),-h3];
   decoded(:,i) = sum(h_trans.*y,2)./sum(h_trans.*conj(h_trans),2);
   %Demodulate
   demodulated(:,i) = step(PSK_Demod,decoded(:,i)); 
end
%Compute BER
[~,ber5] = biterr(demodulated,x);
end