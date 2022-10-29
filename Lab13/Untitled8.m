
h00=[1 ;+0.1];
h10=[0.8 ;-0.3];
h01=[0.4 ;+0.4];
h11=[0.2 ;-0.8];
M=2;
H00= dftmtx(M)*h00
H10= dftmtx(M)*h10
H01= dftmtx(M)*h01
H11= dftmtx(M)*h11

H0=[H00(1), H10(1); H01(1), H11(1) ]
H1=[H00(2), H10(2); H01(2), H11(2) ]

c=[-1; -1]
R0=H0*c
R1=H1*c

S_R0=pinv(H0)*R0

S_R2=pinv(H1)*R1

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
    suma = sum(abs(R1 - H1*Comin(ii,:).').^2); 
    Sum(ii)=suma;
end

display(Sum)

% F= (dftmtx(2)/sqrt(2))*
