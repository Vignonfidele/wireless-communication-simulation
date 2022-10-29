function[BER_N_STC]=SER_STC11(SNR_sB, sigma, M , J) 
SNR =10.^(SNR_sB./10);
N = 100000;  
BER_N_STC = zeros(1,[]); 
for i = 1:length(SNR_sB) 
    tx = randi([0,M-1],N,1); % Genar N sinal para analisar (1 M-1) 
    s = sigma*qammod(tx, M);  % Modular os N sinal  
    E= sum(abs(s).^2)/N;  %Energia medio 
    % Ordenar os simbolos segundo a Alamouti STBC  
    s_2ant = zeros(2,N);
    s_2ant(1,1:1:N)=s;
    s_2ant(2,1:2:N) = -conj(s(2:2:N)); 
    s_2ant(2,2:2:N) = conj(s(1:2:N));
    %s_2ant=  s_2ant;  
    N0 = E/SNR(i);
    h = sigma*(randn(J,N) + 1i*randn(J,N));           %Gerar uma canal Rayleigh 
    n = sqrt(N0/2)*(randn(J,N) + 1i*randn(J,N));      %Gerar o ruido    
    Stx = zeros(J,N);
    Stx_2ant = zeros(J*2,N);          % Vector dos simbolo na duas antenas   
    h_eq= zeros(J*2,N);               % Vector de equalização
    for ii = 1:J 
        h_2Ts = kron(reshape(h(ii,:),2,N/2),ones(1,2));  %Forma a matriz do canal  
        Stx(ii,:) = sum(h_2Ts.*s_2ant,1) +  n(ii,:); 
        % Formando a matriz dos simbolos recebidos vindo das duas antenas tranmissora (Alamouti STBC).    
        Stx_2ant(2*ii-1,1:2:N) = Stx(ii,1:2:N); 
        Stx_2ant(2*ii-1,2:2:N) = conj(Stx(ii,1:2:N)); 
        Stx_2ant(2*ii,1:2:N) = conj(Stx(ii,2:2:N)); 
        Stx_2ant(2*ii,2:2:N) = Stx(ii,2:2:N); 
        % Formando a matriz do canal para equalizar simbolo recebidos   
        h_eq(2*ii-1,1:2:N)=conj(h_2Ts(1,1:2:N));
        h_eq(2*ii-1,2:2:N)=-h_2Ts(2,1:2:N);
        h_eq(2*ii,1:2:N)=h_2Ts(2,1:2:N);
        h_eq(2*ii,2:2:N)=conj(h_2Ts(1,1:2:N)); 
    end   
    S_eq = sum(h_eq.*Stx_2ant,1)./sum(h_eq.*conj(h_eq),1);              %Sinal equalizado  
    C_dem =qamdemod(S_eq,M)';                                           %Sinal demodulado 
    BER_N_STC(i) = sum(C_dem~=tx)/N;                                     %Calculo de error 
end 
end
