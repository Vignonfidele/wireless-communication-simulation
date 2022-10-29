 
import numpy as np     
import matplotlib.pyplot as plt 
from scipy import special as sp
from scipy.stats import uniform

def qfunc(x):
    return 0.5-0.5*sp.erf(x/np.sqrt(2))


def function_SER(SNR_dB, M, B):
    size=1000000
    SNR=10**(SNR_dB/10)
    mi=(4*(np.sqrt(M)-1))/(np.sqrt(M))
    sita=3/(M-1)  
    
    x= uniform.rvs( -B ,2*B, size).reshape(size,1)
    y= uniform.rvs( -B, 2*B, size).reshape(size,1)
    Sv1=x+1j*y 
    r=np.abs(Sv1)             #Calcula o modulo  
    pe_num=[]
    for i in SNR:
        pe=mi*qfunc(np.sqrt(sita*(r**2)*i)) 
        pe_num1=np.mean(pe) 
        pe_num=np.append(pe_num,pe_num1)  
    return  pe_num

SNR_dB=np.linspace(0, 35, 20)
pe=function_SER(SNR_dB, 16, 1)
#print(pe) 

plt.semilogy(SNR_dB, pe, 'r', label='Aproximada' ) 
#plt.semilogy(SNR_dB, pe[1], '*', label='Simulada' ) 
  
plt.xlabel('SNR')
plt.ylabel('SER') 
plt.legend()
plt.axis([0, 35, 0.001, 10])
plt.grid(True)
plt.show() 