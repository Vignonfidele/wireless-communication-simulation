bit_count = 4*10000;
Eb_No = 0 : 1: 35;
SNR = Eb_No + 10*log10(4);

for aa = 1: 1: length(SNR)
    T_Errors = 0;
    T_bits = 0; 
    while T_Errors < 100
        uncoded_bits  = round(rand(1,bit_count));
        B = reshape(uncoded_bits,4,length(uncoded_bits)/4);
        B1 = B(1,:);
        B2 = B(2,:);
        B3 = B(3,:);
        B4 = B(4,:);
        a = sqrt(1/10);
        tx = a*(-2*(B3-0.5).*(3-2*B4)-1i*2*(B1-0.5).*(3-2*B2));
        N0 = 1/10^(SNR(aa)/10);
        rx = tx + sqrt(N0/2)*(randn(1,length(tx))+1i*randn(1,length(tx)));
        a = 1/sqrt(10);
        B5 = imag(rx)<0;
        B6 = (imag(rx)<2*a) & (imag(rx)>-2*a);
        B7 = real(rx)<0;
        B8 = (real(rx)<2*a) & (real(rx)>-2*a);
        temp = [B5;B6;B7;B8];
        B_hat = reshape(temp,1,4*length(temp));
        diff =  uncoded_bits - B_hat ;
        T_Errors = T_Errors + sum(abs(diff));
        T_bits = T_bits + length(uncoded_bits);      
    end

    BER(aa) = T_Errors / T_bits;

end
  
semilogy(SNR, BER, 'or');
hold on;
grid on
title('BER Vs SNR Curve for QAM-16 Modulation Scheme in AWGN');
xlabel('SNR (dB)'); ylabel('BER')