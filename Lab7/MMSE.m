function [ SER] = MMSE( , bits_all , n_all , H_all , par)

n_symbols=1e4;
n_iterations=1e3;
n_errors=zeros(length(par.SNRdB_list),1); %Numero de Erros para cada SNR -> Simbolos
n_errors_bits=zeros(length(par.SNRdB_list),1); %Numero de Erros para cada SNR -> Bits

for loop1=1:n_iterations    
    H = H_all(:,:,loop1); %Matriz Canal com Distribuição Normal com media zero e varianza unitaria
    
    %parfor ind_db=1:length(par.SNRdB_list)        
    for ind_db = 1:length(par.SNRdB_list)
        sigma = sqrt(par.MT*par.Es*10^(-par.SNRdB_list(ind_db)/10)); %Sigma do Ruido AWGN
        %N0 = par.MT*par.Es*10^(-par.SNRdB_list(ind_db)/10);         
        
        %Inicialização Erro
        err = 0;
        err_bits = 0;
        
        %parfor loop2=1:n_symbols
        for loop2 = 1:n_symbols
            % generate transmit symbol
            idx = bi2de(bits_all(:,:,loop2),'left-msb')+1;
            x = par.symbols(idx).'; 
            % Sinal Recebido = Canal*SinalEnviado + Ruido
            y = H*x + sigma*n_all(:,loop2,loop1);
            % Começo Detecção MMSE
            G = pinv( H'*H + (sigma^2/par.Es)*eye(par.MT) )*H';
            x_mmse = G*y; %MMSE
            [none,idxhat] = min(abs(x_mmse*ones(1,length(par.symbols))-ones(par.MT,1)*par.symbols).^2,[],2);
            x_hat = par.symbols(idxhat).'; %Decodificação do x_mmse - Quantização
            bits_hat = par.bits(idxhat,:); %Simbolos a Bits
            %Conteo Erros
            err = err + sum(x~=x_hat); %Erro De Simbolos
            err_bits = err_bits + sum(sum(bits_all(:,:,loop2)~=bits_hat)); %Erro De Bits
        end %fim Loop2-> n_symbols
        n_errors(ind_db)=err;
        n_errors_bits(ind_db)=err_bits;
    end %fim ind_db->SNR
end%fim loop1

SER = n_errors/(par.MT*n_iterations*n_symbols); %SER          