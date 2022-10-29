j=1; 
N=1
s = [1; -1] ;    
% Ordenar os simbolos segundo a Alamouti STBC  
s_2ant = zeros(2,N);
s_2ant(1,1:1:N)=s;
s_2ant(2,1:2:N) = -conj(s(2:2:N)); 
s_2ant(2,2:2:N) = conj(s(1:2:N)); 
 
h = [ 0.2*exp(-1j*0.1) , 0.7*exp(1j*0.3) ];
n =  [-0.2+1j*0.1 , -0.2+1j*0.1 ] ;
Stx = zeros(J,N);
Stx_2ant = zeros(J*2,N);                                    % Vector dos simbolo na duas antenas          
h_eq= zeros(J*2,N);                                         % Vector de equalização
for ii = 1:J 
    h_2Ts = kron(reshape(h(ii,:),2,N/2),ones(1,2));                 %Forma a matriz do canal  
    Stx(ii,:) = sum(h_2Ts.*s_2ant,1) +  n(ii,:); 
    % Formando a matriz dos simbolos recebidos vindo das duas antenas tranmissora (Alamouti STBC).    
    Stx_2ant(2*ii-1,1:2:N) = Stx(ii,1:2:N); 
    Stx_2ant(2*ii-1,2:2:N) = conj(Stx(ii,1:2:N)); 
    Stx_2ant(2*ii,1:2:N)   = conj(Stx(ii,2:2:N)); 
    Stx_2ant(2*ii,2:2:N)   = Stx(ii,2:2:N); 
    % Formando a matriz do canal para equalizar simbolo recebidos   
    h_eq(2*ii-1,1:2:N)=conj(h_2Ts(1,1:2:N));
    h_eq(2*ii-1,2:2:N)=-h_2Ts(2,1:2:N);
    h_eq(2*ii,1:2:N)=h_2Ts(2,1:2:N);
    h_eq(2*ii,2:2:N)=conj(h_2Ts(1,1:2:N));                          %Calculo de error 
end  

S_eq = sum(h_eq.*Stx_2ant,1)./sum(h_eq.*conj(h_eq),1);