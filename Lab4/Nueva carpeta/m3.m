clc
close all
clear
%%
SNR=0:1:35;                 %����ȱ仯��Χ
carrier_count=200;          % ���ز���
symbol_count=100;
bit_per_symbol=4;           %���Ʒ�ʽ����
M=2^bit_per_symbol;         %16QAM
%% �����������
N=carrier_count*symbol_count*bit_per_symbol;
x=round(rand(1,N))';
%% ���ز����Ʒ�ʽ
% 1-28���� 29-228��Ч 229-285���� 286-485���� 486-512����
carrier_position=29:228;
conj_position=485:-1:286;
h=qammod(x,M,'InputType','bit');
%%
for i=1:length(SNR)
    [QAM_sig_AWGN(i),QAM_mut_AWGN(i)]=ofdm_awgn(SNR(i),M,N,h,x);
    [QAM_sig_Ray(i),QAM_mut_Ray(i)]=ofdm_ray(SNR(i),M,N,h,x);
end


%% ����ͼ��

figure
semilogy(SNR,QAM_sig_AWGN,'r*');hold on;
semilogy(SNR,QAM_mut_AWGN,'yo');
semilogy(SNR,QAM_sig_Ray,':b*');
semilogy(SNR,QAM_mut_Ray,':go'); grid on;
%axis([-1 20 10^-4 1]);
legend('16QAM-AWGN-����','16QAM-AWGN-�ྶ','16QAM-Rayleigh-����','16QAM-Rayleigh-�ྶ');
title('OFDM/16QAM�������ܷ���');
xlabel('����ȣ�dB��');ylabel('BER');
