close all; clear var; clc;

% INPUTS AND CONVERSION
Number_of_input_bit = 10^6;
EsN0_dB = (0:35); 
% ____________________
%    QPSK ANALYSIS
% ____________________

Received_data_AWGN = zeros(1,Number_of_input_bit);
Received_data_RAYLEIGH = zeros(1,Number_of_input_bit);
nSER_AWGN = zeros(1, []);
nSER_RAYLEIGH = zeros(1, []);
% Generate the signal wihin the for loop
for u = 1:length(EsN0_dB)
    data = (rand(1,Number_of_input_bit)>0) + 1i*(rand(1,Number_of_input_bit)>0); % Unseparated because of Symbol is required
    normalized_data = (1/sqrt(2))* data;
    noise = (1/sqrt(2)) * (randn(1,Number_of_input_bit) + 1i*randn(1,Number_of_input_bit));
    h_SER_RAY = 1/sqrt(2)* (randn(1, Number_of_input_bit) + 1i* randn(1, Number_of_input_bit));

    transmitted_data_AWGN = normalized_data + 10^(-EsN0_dB(u)/20) * noise;
    transmitted_data_RAYLEIGH = h_SER_RAY.* normalized_data + 10^(-EsN0_dB(u)/20) * noise;
    transmitted_data_RAYLEIGH_1 = transmitted_data_RAYLEIGH./h_SER_RAY;

    % _______________
    % DEMODULATION
    % _______________
    received_data_real_AWGN = real(transmitted_data_AWGN);
    received_data_imag_AWGN = imag(transmitted_data_AWGN);

    received_data_real_RAYLEIGH = real(transmitted_data_RAYLEIGH_1);
    received_data_imag_RAYLEIGH = imag(transmitted_data_RAYLEIGH_1);

    % approximate the values fall within the limit of the transmitted signal
    Received_data_AWGN(received_data_real_AWGN < 0 & received_data_imag_AWGN < 0) = -1 + -1*1i;
    Received_data_AWGN(received_data_real_AWGN >= 0 & received_data_imag_AWGN > 0) = 1 + 1*1i;
    Received_data_AWGN(received_data_real_AWGN < 0 & received_data_imag_AWGN >= 0) = -1 + 1*1i;
    Received_data_AWGN(received_data_real_AWGN >= 0 & received_data_imag_AWGN < 0) = 1 - 1*1i;

    Received_data_RAYLEIGH(received_data_real_RAYLEIGH < 0 & received_data_imag_RAYLEIGH < 0) = -1 + -1*1i;
    Received_data_RAYLEIGH(received_data_real_RAYLEIGH >= 0 & received_data_imag_RAYLEIGH > 0) = 1 + 1*1i;
    Received_data_RAYLEIGH(received_data_real_RAYLEIGH < 0 & received_data_imag_RAYLEIGH >= 0) = -1 + 1*1i;
    Received_data_RAYLEIGH(received_data_real_RAYLEIGH >= 0 & received_data_imag_RAYLEIGH < 0) = 1 - 1*1i;

    nSER_AWGN(u) = size(find((data - Received_data_AWGN)),2);
    nSER_RAYLEIGH(u) = size(find((data - Received_data_RAYLEIGH)),2);
end

SER_QPSK_AWGN = nSER_AWGN/Number_of_input_bit;
SER_QPSK_RAYLEIGH = nSER_RAYLEIGH/Number_of_input_bit;
Theoretical_SER_QPSK = erfc(sqrt(0.5*(10.^(EsN0_dB/10)))) - (1/4)*(erfc(sqrt(0.5*(10.^(EsN0_dB/10))))).^2;

% ____________________
%   16QAM ANALYSIS
% ____________________
% generate the constellattion array for mapping
constellation_Array = (reshape(repmat([-3,-1,1,3],4,1),[],1) + 1i*(repmat([-3,-1,1,3],1,4)')).';
Normalization_factor = 1/sqrt(10);
M = 16 ;% number of constellation
SER_QAM_real_AWGN = zeros(1,[]);
SER_QAM_imag_AWGN = zeros(1,[]);

SER_QAM_real_RAYLEIGH = zeros(1,[]);
SER_QAM_imag_RAYLEIGH = zeros(1,[]);

SER_QAM_AWGN = zeros(1, Number_of_input_bit);
QAM_SER_AWGN= zeros(1, length(EsN0_dB));

SER_QAM_RAYLEIGH = zeros(1, Number_of_input_bit);
QAM_SER_RAYLEIGH= zeros(1, length(EsN0_dB));

for v = 1:length(EsN0_dB)
    % generate the data. Note: the data generated is not in binary but multiplying by M and setting the vector
    % in this form gives a gray mapping
    QAM_data = ceil(M.*(rand(1, Number_of_input_bit)))-1;
    QAM_data_map = constellation_Array(QAM_data+1);
    Norm_QAM_data_map = Normalization_factor * QAM_data_map;
    
    Noise_signal = 1/sqrt(2)* (randn(1,Number_of_input_bit) + 1i*randn(1,Number_of_input_bit));
    h_SER_RAY_1 = 1/sqrt(2)* (randn(1, Number_of_input_bit) + 1i* randn(1, Number_of_input_bit));

    Tran_QAM_AWGN = Norm_QAM_data_map + 10^(-EsN0_dB(v)/20)*Noise_signal;
    Tran_QAM_RAYLEIGH = h_SER_RAY_1.* Norm_QAM_data_map + 10^(-EsN0_dB(v)/20)*Noise_signal;
    Tran_QAM_RAYLEIGH_1 = Tran_QAM_RAYLEIGH./h_SER_RAY_1;

    %%%%%%%%%%%%%%%%%%%%%% DEMODULATION OF 16QAM OVER AWGN %%%%%%%%%%%%%%%%%
    Tran_QAM_Real_AWGN = real(Tran_QAM_AWGN);
    Tran_QAM_Imag_AWGN = imag(Tran_QAM_AWGN);
    %%%%%%%%%%%%%%%%%%%%%% DEMODULATION OF 16QAM OVER RAYLEIGH %%%%%%%%%%%%%%%%%
    Tran_QAM_Real_RAYLEIGH = real(Tran_QAM_RAYLEIGH_1);
    Tran_QAM_Imag_RAYLEIGH = imag(Tran_QAM_RAYLEIGH_1);
    
    %%%%%%%%%%%%%%%%%%%%%% MAPPING 16QAM OVER AWGN TO CONSTELLATION %%%%%%%%
    SER_QAM_real_AWGN((Tran_QAM_Real_AWGN< -2/sqrt(10)))                         = -3;
    SER_QAM_real_AWGN(Tran_QAM_Real_AWGN > 2/sqrt(10))                           =  3;
    SER_QAM_real_AWGN((Tran_QAM_Real_AWGN>-2/sqrt(10) & Tran_QAM_Real_AWGN<=0))  = -1;
    SER_QAM_real_AWGN((Tran_QAM_Real_AWGN>0 & Tran_QAM_Real_AWGN<=2/sqrt(10)))   =  1;

    SER_QAM_imag_AWGN((Tran_QAM_Imag_AWGN< -2/sqrt(10)))                         = -3;
    SER_QAM_imag_AWGN((Tran_QAM_Imag_AWGN > 2/sqrt(10)))                         =  3;
    SER_QAM_imag_AWGN((Tran_QAM_Imag_AWGN>-2/sqrt(10) & Tran_QAM_Imag_AWGN<=0))  = -1;
    SER_QAM_imag_AWGN((Tran_QAM_Imag_AWGN>0 & Tran_QAM_Imag_AWGN<=2/sqrt(10)))   =  1;

    %%%%%%%%%%%%%%%%%%%%%% MAPPING 16QAM OVER AWGN TO CONSTELLATION %%%%%%%%
    SER_QAM_real_RAYLEIGH((Tran_QAM_Real_RAYLEIGH< -2/sqrt(10)))                             = -3;
    SER_QAM_real_RAYLEIGH(Tran_QAM_Real_RAYLEIGH > 2/sqrt(10))                               =  3;
    SER_QAM_real_RAYLEIGH((Tran_QAM_Real_RAYLEIGH>-2/sqrt(10) & Tran_QAM_Real_RAYLEIGH<=0))  = -1;
    SER_QAM_real_RAYLEIGH((Tran_QAM_Real_RAYLEIGH>0 & Tran_QAM_Real_RAYLEIGH<=2/sqrt(10)))   =  1;

    SER_QAM_imag_RAYLEIGH((Tran_QAM_Imag_RAYLEIGH< -2/sqrt(10)))                             = -3;
    SER_QAM_imag_RAYLEIGH((Tran_QAM_Imag_RAYLEIGH > 2/sqrt(10)))                             =  3;
    SER_QAM_imag_RAYLEIGH((Tran_QAM_Imag_RAYLEIGH>-2/sqrt(10) & Tran_QAM_Imag_RAYLEIGH<=0))  = -1;
    SER_QAM_imag_RAYLEIGH((Tran_QAM_Imag_RAYLEIGH>0 & Tran_QAM_Imag_RAYLEIGH<=2/sqrt(10)))   =  1;

    SER_QAM_AWGN =  SER_QAM_real_AWGN + 1i* SER_QAM_imag_AWGN;
    SER_QAM_RAYLEIGH =  SER_QAM_real_RAYLEIGH + 1i* SER_QAM_imag_RAYLEIGH;
    QAM_SER_AWGN(v) = size(find((QAM_data_map- SER_QAM_AWGN)),2); % counting the number of errors
    QAM_SER_RAYLEIGH(v) = size(find((QAM_data_map- SER_QAM_RAYLEIGH)),2); % couting the number of errors

end

 
SER_RAYLEIGH = QAM_SER_RAYLEIGH/Number_of_input_bit;
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%% Simulated and theoretical QPSK SER OVER RAYLEIGH %%%%%%%%%%
m = 4;
c11=1*10.^(EsN0_dB./10)*log(m)/(m-1); % I was alternating the constants to fit, why?
n11=sqrt(c11./(c11+1));
Theoretical_QPSK_RAYLEIGH=2.*(sqrt(m)-1)./sqrt(m)*(1-n11)-((sqrt(m)-1)./sqrt(m)).*((sqrt(m)-1)./sqrt(m))*(1-4.*n11./deg2rad(180).*atan(1./n11));

semilogy(EsN0_dB, SER_QPSK_RAYLEIGH, 'b--', EsN0_dB, Theoretical_QPSK_RAYLEIGH, 'gd', 'MarkerFaceColor','w');
hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%% Simulated and theoretical 16QAM SER OVER RAYLEIGH %%%%%%%%%%
c1=0.5*10.^(EsN0_dB./10)*log(M)/(M-1);
n1=sqrt(c1./(c1+1));
Theoretical_QAM_RAYLEIGH=2.*(sqrt(M)-1)./sqrt(M)*(1-n1)-((sqrt(M)-1)./sqrt(M)).*((sqrt(M)-1)./sqrt(M))*(1-4.*n1./deg2rad(180).*atan(1./n1));

semilogy(EsN0_dB, SER_RAYLEIGH, 'k<-', EsN0_dB, Theoretical_QAM_RAYLEIGH, 'm*');
title(" QPSK, 16QAM's SER over RAYLEIGH channel");
xlabel('Es/N0');
ylabel('Symbol Error rate (BER) in dB'); 
grid on 