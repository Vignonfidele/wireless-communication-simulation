function [error_rate_sig,error_rate_mut]=ofdm_ray(SNR,M,bit_length,bit_moded,bit_sequence)
carrier_count = 200; % ���ز���
symbol_count = 100;
ifft_length = 512;
CP_length = 128;
CS_length = 20;
alpha = 1.5/32;
carrier_position = 29:228;
conj_position = 485:-1:286;
%% IFFT
% ����ת��
ifft_position = zeros(ifft_length,symbol_count);
bit_moded = reshape(bit_moded,carrier_count,symbol_count);
% figure('position',[400 0 400 400],'menubar','none');
% stem(abs(bit_moded(:,1)));
% grid on;
ifft_position(carrier_position,:)=bit_moded(:,:);
ifft_position(conj_position,:)=conj(bit_moded(:,:));
signal_time = ifft(ifft_position,ifft_length);

% ��ѭ��ǰ׺�ͺ�׺
signal_time_C = [signal_time(end-CP_length+1:end,:);signal_time];
signal_time_C = [signal_time_C; signal_time_C(1:CS_length,:)];

% �Ӵ�
signal_window = zeros(size(signal_time_C));
% ͨ��������
signal_window = signal_time_C.*repmat(rcoswindow(alpha,size(signal_time_C,1)),1,symbol_count);

%% �����źţ��ྶ�ŵ�
signal_Tx = reshape(signal_window,1,[]); % ���ʱ��һ�������źţ�������
signal_origin = reshape(signal_time_C,1,[]); % δ�Ӵ������ź�
mult_path_am = [1 0.2 0.1]; %  �ྶ����
mutt_path_time = [0 20 50]; % �ྶʱ��
windowed_Tx = zeros(size(signal_Tx));
path2 = 0.2*[zeros(1,20) signal_Tx(1:end-20) ];
path3 = 0.1*[zeros(1,50) signal_Tx(1:end-50) ];
signal_Tx_mult = signal_Tx + path2 + path3; % �ྶ�ź�


%% ��AWGN
signal_power_sig = var(signal_Tx); % ���������źŹ���
signal_power_mut = var(signal_Tx_mult); % �ྶ�����źŹ���
SNR_linear = 10^(SNR/10);
noise_power_mut = signal_power_mut/SNR_linear;
noise_power_sig = signal_power_sig/SNR_linear;
noise_sig = randn(size(signal_Tx))*sqrt(noise_power_sig);
noise_mut = randn(size(signal_Tx_mult))*sqrt(noise_power_mut);
% noise_sig=0;
% noise_mut=0;

% �������ŵ�
n1=length(signal_Tx_mult);
R=raylrnd(0.5,1,n1);         %�����ŵ�
signal_Tx=signal_Tx.*R;
signal_Tx_mult=signal_Tx_mult.*R;

Rx_data_sig = signal_Tx+noise_sig;
Rx_data_mut = signal_Tx_mult+noise_mut;
%% ����ת��
Rx_data_mut = reshape(Rx_data_mut,ifft_length+CS_length+CP_length,[]);
Rx_data_sig = reshape(Rx_data_sig,ifft_length+CS_length+CP_length,[]);
%% ȥѭ��ǰ׺�ͺ�׺
Rx_data_sig(1:CP_length,:) = [];
Rx_data_sig(end-CS_length+1:end,:) = [];
Rx_data_mut(1:CP_length,:) = [];
Rx_data_mut(end-CS_length+1:end,:) = [];
%% FFT
fft_sig = fft(Rx_data_sig);
fft_mut = fft(Rx_data_mut);
%% ������
data_sig = fft_sig(carrier_position,:);
data_mut = fft_mut(carrier_position,:);

%% ��ӳ��
bit_demod_sig = reshape(qamdemod(data_sig,M,'OutputType','bit'),[],1);
bit_demod_mut = reshape(qamdemod(data_mut,M,'OutputType','bit'),[],1);
%% ������
error_bit_sig = sum(bit_demod_sig~=bit_sequence);
error_bit_mut = sum(bit_demod_mut~=bit_sequence);
error_rate_sig = error_bit_sig/bit_length;
error_rate_mut = error_bit_mut/bit_length;


end