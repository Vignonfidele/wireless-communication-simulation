function [b_userf]=Water_filling_algorithm(K, U, bmin , P, Pes, H, sigma2 ) 
%- K: número de subportadoras
%- U: número de usuários
%- bmin: vetor U x 1 contendo o número mínimo de bits que cada usuário deve transmitir no símbolo OFDM
%- P: vetor U x 1 contendo a potência disponível para cada usuário
%- Pes: vetor U x 1 contendo a probabilidade de erro de símbolo alvo para cada usuário
%- H: matriz K x U contendo a resposta em frequência do canal de cada usuário em suas colunas. 
%- sigma2: varianza

rho=(1/3)*(qfuncinv(Pes/4))^2; %calculo de rho
b_userf=[];
for i=1:1:U
    H_useri=H(i,1:1:end);
    T_user=(rho*sigma2)./abs(H_useri).^2;  
    %Calculo das potencias 
    P_user=(P/K)+((rho*sigma2)/K)*sum(1./abs(H_useri).^2)-T_user;  
    %Capacidade de carga de uma subportadora 
    b_user=fix(log2(1+(P_user./T_user))) ; 
    b_userf=[b_userf;b_user];
end 