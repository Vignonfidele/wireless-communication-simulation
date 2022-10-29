%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All rights reserved by Krishna Pillai, http://www.dsplog.com
% The file may not be re-distributed without explicit authorization
% from Krishna Pillai.
% Checked for proper operation with Octave Version 3.0.0
% Author        : Krishna Pillai
% Email         : krishna@dsplog.com
% Version       : 1.0
% Date          : 28th September 2008
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script for computing the SNR improvement in 
% Rayleigh fading channel with Maximal Ratio Combining

clear
N = 10^3; % number of bits or symbols

% Transmitter
ip = rand(1,N)>0.5; % generating 0,1 with equal probability
s = 2*ip-1; % BPSK modulation 0 -> -1; 1 -> 0

nRx = [1:20];
Eb_N0_dB =   [25]; % multiple Eb/N0 values

for jj = 1:length(nRx)

    for ii = 1:length(Eb_N0_dB)

        n = 1/sqrt(2)*[randn(nRx(jj),N) + j*randn(nRx(jj),N)]; % white gaussian noise, 0dB variance
        h = 1/sqrt(2)*[randn(nRx(jj),N) + j*randn(nRx(jj),N)]; % Rayleigh channel

        % Channel and noise Noise addition
        sD = kron(ones(nRx(jj),1),s);%sD = 1; 
        y = h.*sD + 10^(-Eb_N0_dB(ii)/20)*n;

        % maximal ratio combining
        yHat =  sum(conj(h).*y,1); 
        
        % effective SNR
        EbN0EffSim(ii,jj) = mean(abs(yHat));
        EbN0EffThoery(ii,jj) = nRx(jj);

    end

end


close all
figure
plot(nRx,10*log10(EbN0EffThoery),'bd-','LineWidth',2);
hold on
plot(nRx,10*log10(EbN0EffSim),'mp-','LineWidth',2);
axis([1 20 0 16])
grid on
legend('theory', 'sim');
xlabel('Number of receive antenna');
ylabel('SNR gain, dB');
title('SNR improvement with Maximal Ratio Combining');


