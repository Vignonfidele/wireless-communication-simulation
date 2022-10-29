function [pe_ana]=function_SER_analitico_B(SNR_dB, M, B) 
    %% Parametros
    SNR=10.^(SNR_dB./10);
    mi=(4*(sqrt(M)-1))/(sqrt(M));
    sita=3/(M-1); 
    gama=sita.*SNR;
    %% Integracao em intervalo 0<r<B
    coefA=mi*pi/(2*sqrt(2*pi)*B^2); 
    Integre1=(1/2)*sqrt(pi/2)*(1./(sqrt(gama))).^2;
    parte1=coefA*Integre1; 
    %% Integracao em intervalo B<r<sqrt(2)B
    coefB=mi/(sqrt(2*pi)*B^2);
    fun1 = @(x) (B.*(-sqrt(-B.^2+sqrt(-B.^2+(x.^2./gama))))).*exp(-(x.^2/2)); 
    A1=integral(fun1,B,Inf,'ArrayValued',true);
    A2=(-pi.*((B.*exp(-((B.^2)./2)))+(sqrt(pi./2).*erfc(B./sqrt(2)))))./(4.*gama);
    fun2=@(x) (B.*(x.^2)*(exp(-(x.^2./2)))*asinh(sqrt(-(gama.*B.^2/x.^2))))/(sqrt(-B.^2).*gama); 
    A3=integral(fun2,B,Inf,'ArrayValued',true);
    %% Calculo de p_error
    parte2=coefB*(A1+A2+A3) ;
    pe_ana= parte1+parte2; 
end 