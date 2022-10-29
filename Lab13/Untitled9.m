 
symbin = [-1,1];  %Modular todos os todos os possiveis simbolos  
Comin=[];
g=0;
%Combinar todas as possibilidade dada o numero de antenas
%transmissora e os possiveis simbolos dada o modulação usada.... 
for k1=1:1:length(symbin)
    for k2=1:1:length(symbin)
        g=g+1;
        Comin(g,:)= [symbin(k1), symbin(k2)]  ;
    end
end 

Sum=zeros(1,[]); 
for ii=1:1:length(Comin)
    suma = sum(abs(y - H*Comin(ii,:).').^2); 
    Sum(ii)=suma;
end