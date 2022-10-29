import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, ifft
 
def routine(N, Fs, fd): 
    Ts=1/Fs    
    t = np.linspace(0 , N*Ts, N) 
    f = np.linspace(-Fs/2, (Fs/2-Fs/N), N)
    mu=0
    sigma=1
    s=np.sqrt(1/(np.pi*fd*np.emath.sqrt(1-np.power(f/fd,2))))  
    s[np.where(f==-fd)] = 5*s[np.where(f==-fd)[0]+1]
    s[np.where(f== fd)] = 5*s[np.where(f== fd)[0]-1]
    s=s.real 
    #Para a variavel x:
    x=  np.random.normal(mu, sigma, size=N)
    out1x = fft(x)
    out2x = out1x*s 
    out3x = ifft(out2x).real
    out4x = out3x**2  
    #Para a variavel y: 
    y = np.random.normal(mu, sigma, size=N)

    out1y = fft(y)
    out2y = out1y*s 
    out3y = ifft(out2y).real
    out4y = out3y**2 
    Sum= np.sqrt(out4x + out4y ) 
    r= 10*np.log10(Sum)
    xy_a0= np.random.normal(mu, (sigma), size=(N, 2)).view(np.complex128)
    Sv=np.abs(xy_a0)
    return t , r , f, s, Sv 

Saida=routine(100000, 10, 1)


def pdf_Reyleight():
    sigma=1;
    ax=100
    r=np.linspace(0, 10, num=ax).reshape(ax,1) 
    pr=(r/sigma**2)*(np.exp(-(r**2)/(2*(sigma**2)))) 
    return r, pr 

saida2=pdf_Reyleight()
    
plt.plot(saida2[0], saida2[1], 'r')
plt.hist(Saida[4], color ='b', bins=100, density=True)   
plt.title('Rayleigh Fading com dopple') 
plt.legend(["PDF teórica Rayleigh",  "Histogram de amostra de rayleigh"])
plt.xlabel('r')
plt.ylabel('p(r)')
  
plt.show()