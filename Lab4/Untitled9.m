

clc
clear


for x_dB= 0:5:40
   error_BER=0;  
   epoch=0;  
   error_count_BER=0;
   error_count_SER=0;

    while (error_count_BER<=1000)
        %S = (sum(QAM_16_symbol.^2)/16);
        S=1;
        M = 4; % symbol 당 bit 수 
        N=S*10^(-0.1*x_dB);
        noise = sqrt(N/2)*randn(1,length(QAM_16_symbol)) + 1i*(sqrt(N/2)*randn(1,length(QAM_16_symbol)));      % 잡음 생성
        h = sqrt(0.5) * [randn(1,length(QAM_16_symbol)) + 1i*randn(1,length(QAM_16_symbol))];       % Rayleigh channel
        h_c = conj(h);      % h 켤레복소수 생성
        QAM_16_symbol_h = QAM_16_symbol .* h;
        QAM_16_symbol_noise = QAM_16_symbol_h + noise;        %noise 추가
        QAM_16_symbol_demo = zeros(1, length(QAM_16_symbol_noise));
        
        QAM_16_symbol_noise = QAM_16_symbol_noise .* h_c;
        QAM_16_symbol_noise = QAM_16_symbol_noise ./ (h .* h_c);
        
        % Deomodulation Symbol
        for i=1:1:length(QAM_16_symbol_noise)
            QAM_16_symbol_demo(1, i) = distance_measure(QAM_16_symbol_noise(1, i));
        end
        
        % SER 占쏙옙占쏙옙
        error_bit_SER = QAM_16_symbol - QAM_16_symbol_demo;
        error_SER = nnz(error_bit_SER);       
        error_count_SER = error_count_SER + error_SER;
        
        % Demodulation Symbol to bit
        QAM_16_bit_demo = demo_symbol_to_bit(QAM_16_symbol_demo);
        
        % BER 占쏙옙占쏙옙 : error count, nnz, epoch plus 1
        error_bit_BER = message - QAM_16_bit_demo;
        error_BER = nnz(error_bit_BER);       %error_bit 占쏙옙커占쏙옙占? 0占쏙옙 占싣댐옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 
        error_count_BER = error_count_BER + error_BER;
        epoch = epoch + 1; 
    end
     QAM_16_BER = [QAM_16_BER error_count_BER/(epoch*length(message))];
     QAM_16_SER = [QAM_16_SER error_count_SER/(epoch*length(message))];
end