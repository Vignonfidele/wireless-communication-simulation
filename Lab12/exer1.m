clc
F=dftmtx(3)/sqrt(3);
H0=[(0.8-1j*0.1) (0.3+1j*0.4) (0.2)].' ;
H1=[(-0.1-1j*0.2) (1j*0.6) (0.7-1j*0.4) ].' ; 

c=[-1; -1; 1; 1; -1; 1];
c1=[-1;1;-1];
c2=[-1;1;1];
SR1=H0.*c1-H1.*c2
SR2=H0.*c2+H1.*c1 
Ck=conj(H0).*SR1+H1.*conj(SR2)
Ck1=conj(H0).*SR2-H1.*conj(SR1)

EquH0=abs(H0).^2
EquH1=abs(H1).^2
Heq=EquH0+EquH1

Tx1=Ck./Heq
Tx2=Ck1./Heq

% C=[ conj(H0(1))*SR1(1) + H1(1)*conj(SR2(1));...
%     
%     conj(H0(1))*SR2(1) - H1(1)*conj(SR1(1)); ...
%     
%     conj(H0(2))*SR1(2) + H1(2)*conj(SR2(2));...
%     
%     conj(H0(2))*SR2(2) - H1(2)*conj(SR1(2)); ...
%     
%     conj(H0(3))*SR1(3) + H1(3)*conj(SR2(3));...
%     
%     conj(H0(3))*SR2(3) - H1(3)*conj(SR1(3))   ]
%  
%  
% %H0 = fft(h0)/sqrt(3) ;
% %H1 = fft(h1)/sqrt(3) ; 
% 
% H0eq = H0.*conj(H0) ;
% H1eq = H1.*conj(H1);
% 
% Heq=sum ([H0eq, H1eq ],2)
% % R0=conj(H0).*H0.*c;
% % R1=conj(H1).*H1.*c
% % 
% % C=[R0 , R1] 
% c1=c(1:2:end)./Heq
% c2=c(2:2:end)./Heq
% 
% % H0 = toeplitz(h0) ;
% % H1 = toeplitz(h1) ;
% % S_C0=conj(H0)*F*H0*F'*c
% % S_C1=conj(H1)*F*H1*F'*c
% % C=[S_C0 , S_C1]; 
% % C_s= sum(C,2)
% 
% % S_C1=
% % F_H=F';
% % c=[-1;1;-1];
% % %Sinal transmitido 
% % s=F_H*c;
% % %Sinal transmitido + canal + ruido 
% % S_R0=H0.*s;
% % S_R1=H1.*s;
% % 
% % %Sinal transmitido + canal + ruido +fft
% % S_R0f=F*S_R0;
% % S_R1f=F*S_R1;
% % 
% % S_C0= conj(H0).*S_R0f;
% % S_C1=conj(H1).*S_R1f
% % 
% % C=[S_C0 , S_C1];
% 
% % C_s= sum(C,2);
% 
