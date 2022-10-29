%sinal
c=[-1; 1 ; -1]; 
%sinal aplicando ifft
s_c=sqrt(3)*ifft(c)
%canal 
h0=[(0.8-1j*0.1) (0.3+1j*0.4) (0.2)] ;
%Sinal recebido 
S_r=conv(h0 , s_c)
%aplicar fft al sinal recebido 
S_rf=fft(S_r)./sqrt(3)
%h en dominio de frequencia 
H_freq=fft(h0)
%sinal equalizado 
S_equ=S_rf./H_freq

% 
% %h1=[(-0.1-1j*0.2) (1j*0.6) (0.7-1j*0.4) ].' ; 
% S_r0=h0.*s_c;
% %S_r1=h1.*s_c; 
% S_r0f=fft(S_r0);
% %S_r1f=fft(S_r1); 
% S_ou0=conj(h0).*S_r0f;
% %S_ou1=conj(h1).*S_r1f;
% equa0= (conj(h0).*S_r0f)./ (h0.*conj(h0))
% %equa1= (conj(h1).*S_r1f)./ (h1.*conj(h1))
% 
% C=[equa0 , equa1]; 
% C_s= sum(C,2)
    

 
