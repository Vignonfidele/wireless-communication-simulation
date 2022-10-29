function[BER_N_STC1]=SER_STC4(SNR_dB, sigma, M , nRx)
    %Define message length

    N = 10^5; % number of bits or symbols
    SNR=10.^(SNR_dB./10); 
    BER_N_STC = zeros(1,[]); 
    for ii = 1:length(SNR_dB)

        % Transmitter 
        tx = randi([0,M-1],1,N); % Genar N sinal para analisar (1 M-1)
        s = qammod(tx, M);  % Modular os N sinal  
        E= sum(abs(s).^2)/N; 
        % Alamouti STBC 
        sCode = 1/sqrt(2)*kron(reshape(s,2,N/2),ones(1,2)) ;

        % channel
        h = sigma*(randn(nRx,N) + 1i*randn(nRx,N)); % Rayleigh channel
        N0=E/SNR(ii); 
        n =sqrt(N0/2)*(randn(nRx,N) + 1i*randn(nRx,N)); % white gaussian noise, 0dB variance
           
        y = zeros(nRx,N);
        yMod = zeros(nRx*2,N);
        for kk = 1:nRx

            hMod = kron(reshape(h(kk,:),2,N/2),ones(1,2)); % repeating the same channel for two symbols    
            temp = hMod;
            hMod(1,2:2:end) = conj(temp(2,2:2:end)); 
            hMod(2,2:2:end) = -conj(temp(1,2:2:end));

            % Channel and noise Noise addition
            y(kk,:) = sum(hMod.*sCode,1) +  n(kk,:);

            % Receiver
            yMod(2*kk-1:2*kk,:) = kron(reshape(y(kk,:),2,N/2),ones(1,2));

            % forming the equalization matrix
            hEq(2*kk-1:2*kk,:) = hMod;
            hEq(2*kk-1,1:2:end) = conj(hEq(2*kk-1,1:2:end));
            hEq(2*kk,  2:2:end) = conj(hEq(2*kk,  2:2:end));

        end

        % equalization 
        hEqPower = sum(hEq.*conj(hEq),1);
        yHat = sum(hEq.*yMod,1)./hEqPower; % [h1*y1 + h2y2*, h2*y1 -h1y2*, ... ]
        yHat(2:2:end) = conj(yHat(2:2:end)); 
        % receiver - hard decision decoding
        
        C_dem = qamdemod(yHat,M);   %Demodulacao do sinal 
        BER_N_STC(ii) = sum(C_dem ~= tx)/N;  %Calculo de error  
    end
end