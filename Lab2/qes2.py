'''Para reproducir este script será necesario instalar as bibliotecas numpy e matplotlib'''  
import numpy as np                          #Biblioteca para operacao matematica
import matplotlib.pyplot as plt             #Para plotar  
from scipy.fft import fft, ifft
import os  
os.system ("cls")

def xfuncion(fd,N):  
    f=np.linspace(-fd, fd, num=N).reshape(N,1)
    f[0]=f[0]+0.01  
    f[N-1]=f[N-1]-0.01   
    s=1/(np.pi*fd*np.sqrt(1-(f/fd)**2)) 
    return f,s
 
def sample_dopple_Rayleigh(N, fd, fs): 
    mu=0 
    sigma=1  
    s=np.sqrt(1/(np.pi*fd*np.sqrt(1-(fs/fd)**2)))
    #Para a variavel x:
    x=np.random.normal(mu, sigma, size=N).reshape(N,1) 
    out1x = fft(x).real
    out2x = out1x*s
    out3x = ifft(out2x).real
    out4x =out3x**2 
    #Para a variavel y: 
    y=np.random.normal(mu, sigma, size=N).reshape(N,1) 
    out1y = fft(y).real 
    out2y = out1y*s 
    out3y = ifft(out2y).real
    out4y = out3y**2
    Suma= out4x + out4y
    sample_doppler = np.sqrt(Suma)   
    #t=np.linspace(0, 1, num=T).reshape(T,1) 
    return sample_doppler

def sample_Reyleigh(size):
    mu=0 
    sigma=1   
    xy_a0=np.random.normal(mu,sigma, size=(size, 2)).view(np.complex128) #  VA x e jy... 
    Sv=np.abs(xy_a0)    #Calcula o modulo
    return Sv


def pdf_Reyleight():
    sigma=1;
    ax=100
    r=np.linspace(0, 10, num=ax).reshape(ax,1) 
    pr=(r/sigma**2)*(np.exp(-(r**2)/(2*(sigma**2)))) 
    return r, pr 
     
'''rf1=sample_Reyleigh(1000000 )
rf2=sample_dopple_Rayleigh(1000000, 1, 0.01)
rf3=pdf_Reyleight()'''
rf4=xfuncion(1,10000)
'''plt.plot(rf3[0], rf3[1], 'r', label='Reyleigh sem Dopple' ) 
#print(rf[1]) 
#plt.hist(rf1, color ='r', bins=100, density=True, label='Reyleigh sem Dopple')   # histograma da variavel gerada. 
plt.hist(rf2, color ='b', bins=100, density=True, label='Reyleigh com Dopple' )    '''
plt.plot(rf4[0], rf4[1], 'r', label='Reyleigh sem Dopple' )  

plt.xlabel('r')
plt.ylabel('p(r)')
#plt.xlim(-rf[2],rf[2])
plt.legend()
plt.show()



