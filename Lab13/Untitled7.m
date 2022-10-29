clc
F=dftmtx(3)/sqrt(3);
H0=[0.4531+1j*0.2113 0.4531+1j*0.2113 0.2472+1j*0.7608 0.2472+1j*0.7608].' 
H1=[0.8693-1j*0.2329 0.8693-1j*0.2329  0.0866+1j*0.05 0.0866+1j*0.05 ].'  

ct=[1  ; 1 ;  -1  ; -1];

ct1=[-1  ; 1 ;  1  ; -1];



n0=[0.1  ; 0.2 ;  -0.3  ; -0.01]; 

SR=H0.*ct + H1.*ct1 + n0

H0eq = H0.*conj(H0) ;
H1eq = H1.*conj(H1);
Heq=sum ([H0eq, H1eq ],2);

C=[conj(H0(1))*SR(1) + H1(2)*conj(SR(2)); conj(H0(1))*SR(2) - H1(1)*conj(SR(1))   ; conj(H0(3))*SR(3) + H1(4)*conj(SR(4)) ; conj(H0(3))*SR(4) - H1(3)*conj(SR(3))  ]

C_eq=C./Heq

%H0 = fft(h0)/sqrt(3) ;
%H1 = fft(h1)/sqrt(3) ; 




R0= conj(H0).*H0.*c +conj(H0).*n0;
R1= conj(H1).*H1.*c +conj(H1).*n1;

C=[R0 , R1] ;
C_s= sum(C,2)./Heq

% H0 = toeplitz(h0) ;
% H1 = toeplitz(h1) ;
% S_C0=conj(H0)*F*H0*F'*c
% S_C1=conj(H1)*F*H1*F'*c
% C=[S_C0 , S_C1]; 
% C_s= sum(C,2)

% S_C1=
% F_H=F';
% c=[-1;1;-1];
% %Sinal transmitido 
% s=F_H*c;
% %Sinal transmitido + canal + ruido 
% S_R0=H0.*s;
% S_R1=H1.*s;
% 
% %Sinal transmitido + canal + ruido +fft
% S_R0f=F*S_R0;
% S_R1f=F*S_R1;
% 
% S_C0= conj(H0).*S_R0f;
% S_C1=conj(H1).*S_R1f
% 
% C=[S_C0 , S_C1];

C_s= sum(C,2);

