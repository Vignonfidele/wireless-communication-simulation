%% 16QAM
clear;
clc;
xBinary=randi([0,1],1,120000);        %CREATING RANDOM BITS
%% Fixed Variables
SNR = 1:1:35
Eb=2.5;
for i=1:(length(xBinary)/4)       %MAPPING
    if(xBinary(i*4-3) == 0 && xBinary(i*4-2) == 0 && xBinary(i*4-1) == 0 && xBinary(i*4) == 0)
        x(i)=-3+3i;
    end
    if(xBinary(i*4-3) == 0 && xBinary(i*4-2) == 1 && xBinary(i*4-1) == 0 && xBinary(i*4) == 1)
        x(i)=-1+3i;
    end
    if(xBinary(i*4-3) == 1 && xBinary(i*4-2) == 0 && xBinary(i*4-1) == 0 && xBinary(i*4) == 0)
        x(i)=1+3i;
    end
    if(xBinary(i*4-3) == 1 && xBinary(i*4-2) == 0 && xBinary(i*4-1) == 1 && xBinary(i*4) == 1)
        x(i)=3+3i;
    end
    if(xBinary(i*4-3) == 0 && xBinary(i*4-2) == 1 && xBinary(i*4-1) == 1 && xBinary(i*4) == 0)
        x(i)=-3+1i;
    end
    if(xBinary(i*4-3) == 0 && xBinary(i*4-2) == 0 && xBinary(i*4-1) == 0 && xBinary(i*4) == 1)
        x(i)=-1-1i;
    end
    if(xBinary(i*4-3) == 1 && xBinary(i*4-2) == 1 && xBinary(i*4-1) == 1 && xBinary(i*4) == 0)
        x(i)=1+1i;
    end
    if(xBinary(i*4-3) == 0 && xBinary(i*4-2) == 1 && xBinary(i*4-1) == 1 && xBinary(i*4) == 1)
        x(i)=3+1i;
    end
    if(xBinary(i*4-3) == 1 && xBinary(i*4-2) == 0 && xBinary(i*4-1) == 1 && xBinary(i*4) == 0)
        x(i)=-3-1i;
    end
    if(xBinary(i*4-3) == 1 && xBinary(i*4-2) == 1 && xBinary(i*4-1) == 0 && xBinary(i*4) == 1)
        x(i)=-1-1i;
    end
    if(xBinary(i*4-3) == 0 && xBinary(i*4-2) == 0 && xBinary(i*4-1) == 1 && xBinary(i*4) == 0)
        x(i)=1-1i;
    end
    if(xBinary(i*4-3) == 0 && xBinary(i*4-2) == 1 && xBinary(i*4-1) == 0 && xBinary(i*4) == 0)
        x(i)=3-1i;
    end
    if(xBinary(i*4-3) == 1 && xBinary(i*4-2) == 1 && xBinary(i*4-1) == 0 && xBinary(i*4) == 0)
        x(i)=-3-3i;
    end
    if(xBinary(i*4-3) == 1 && xBinary(i*4-2) == 1 && xBinary(i*4-1) == 1 && xBinary(i*4) == 1)
        x(i)=-1-3i;
    end
    if(xBinary(i*4-3) == 1 && xBinary(i*4-2) == 0 && xBinary(i*4-1) == 0 && xBinary(i*4) == 1)
        x(i)=1-3i;
    end
    if(xBinary(i*4-3) == 0 && xBinary(i*4-2) == 0 && xBinary(i*4-1) == 1 && xBinary(i*4) == 1)
        x(i)=3-3i;
    end
  
end
for j=1:35                           %DEMAPPING
    % Channel Modeling 
    hr=sqrt(1/2)*randn(1,120000/4);
    hi=sqrt(1/2)*randn(1,120000/4); 
    h=hr+1j*hi;
    % Noise Modeling
    nc=sqrt(1/2)*randn(1,120000/4);
    ns=sqrt(1/2)*randn(1,120000/4);
    n=nc+1j*ns;
    N(j)=sqrt(1/db2mag(2*SNR(j)));
    n=n*N(j);
    y=x.*h+n;
    output=y./h;
    for i=1:length(output)
    if (real(output(i)) > 0 && real(output(i))<2 && imag(output(i))>0 && imag(output(i))<2)
        yBinary(i*4-3)=1;
        yBinary(i*4-2)=1;
        yBinary(i*4-1)=1;
        yBinary(i*4)=0;
    end
    if (real(output(i)) > 0 && real(output(i))<2 && imag(output(i))>2)
        yBinary(i*4-3)=1;
        yBinary(i*4-2)=0;
        yBinary(i*4-1)=0;
        yBinary(i*4)=0;
    end
    if (real(output(i)) > 0 && real(output(i))<2 && imag(output(i))<0 && imag(output(i))>-2)
        yBinary(i*4-3)=0;
        yBinary(i*4-2)=0;
        yBinary(i*4-1)=1;
        yBinary(i*4)=0;
    end
    if (real(output(i)) > 0 && real(output(i))<2 && imag(output(i))<-2)
        yBinary(i*4-3)=1;
        yBinary(i*4-2)=0;
        yBinary(i*4-1)=0;
        yBinary(i*4)=1;
    end
    if (real(output(i)) > 2 &&imag(output(i))>0 && imag(output(i))<2) 
        yBinary(i*4-3)=0;
        yBinary(i*4-2)=1;
        yBinary(i*4-1)=1;
        yBinary(i*4)=1;
    end
    if (real(output(i)) > 2 && imag(output(i))>2)
        yBinary(i*4-3)=1;
        yBinary(i*4-2)=0;
        yBinary(i*4-1)=1;
        yBinary(i*4)=1;
    end
    if (real(output(i)) > 2 && imag(output(i))<0 && imag(output(i))>-2)
        yBinary(i*4-3)=0;
        yBinary(i*4-2)=1;
        yBinary(i*4-1)=0;
        yBinary(i*4)=0;
    end
    if (real(output(i)) > 2 && imag(output(i))<-2)
        yBinary(i*4-3)=0;
        yBinary(i*4-2)=0;
        yBinary(i*4-1)=1;
        yBinary(i*4)=1;
    end
    if (real(output(i)) < 0 && real(output(i))>-2 && imag(output(i))>0 && imag(output(i))<2)
        yBinary(i*4-3)=0;
        yBinary(i*4-2)=0;
        yBinary(i*4-1)=0;
        yBinary(i*4)=1;
    end
    if (real(output(i)) < 0 && real(output(i))>-2 && imag(output(i))>2)
        yBinary(i*4-3)=0;
        yBinary(i*4-2)=1;
        yBinary(i*4-1)=0;
        yBinary(i*4)=1;
    end
    if (real(output(i)) < 0 && real(output(i))>-2 && imag(output(i))<0 && imag(output(i))>-2)
        yBinary(i*4-3)=1;
        yBinary(i*4-2)=1;
        yBinary(i*4-1)=0;
        yBinary(i*4)=1;
    end
    if (real(output(i)) < 0 && real(output(i))>-2 && imag(output(i))<-2)
        yBinary(i*4-3)=1;
        yBinary(i*4-2)=1;
        yBinary(i*4-1)=1;
        yBinary(i*4)=1;
    end
    if (real(output(i))<-2 && imag(output(i))>0 && imag(output(i))<2)
        yBinary(i*4-3)=0;
        yBinary(i*4-2)=1;
        yBinary(i*4-1)=1;
        yBinary(i*4)=0;
    end
    if (real(output(i))<-2 && imag(output(i))>2)
        yBinary(i*4-3)=0;
        yBinary(i*4-2)=0;
        yBinary(i*4-1)=0;
        yBinary(i*4)=0;
    end
    if (real(output(i))<-2 && imag(output(i))<0 && imag(output(i))>-2)
        yBinary(i*4-3)=1;
        yBinary(i*4-2)=0;
        yBinary(i*4-1)=1;
        yBinary(i*4)=0;
    end
    if (real(output(i))<-2 && imag(output(i))<-2)
        yBinary(i*4-3)=1;
        yBinary(i*4-2)=1;
        yBinary(i*4-1)=0;
        yBinary(i*4)=0;
    end
    end
    % Error Calculation
    POE(j)= nnz(yBinary-xBinary)/120000;
end  
semilogy(SNR,POE,'r')         %POE APPEARS ON A RED CURVE
xlabel('SNR');
ylabel('BER');
hold on;
POETHEO = berfading(SNR, 'qam', 16, 1);    %THEORITICAL POE
semilogy(SNR,POETHEO,'b');                 %THEORITICAL POE APPEARS ON A BLUE CURVE
grid;
title('BER Vs SNR (dB)');
legend('16QAM','16QAM theo')