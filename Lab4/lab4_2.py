 
from distutils.log import error
import numpy as np     
import matplotlib.pyplot as plt 
from scipy import special as sp


import numpy as np
from matplotlib import pyplot as plt
from sigproc import Signal

#################################
class Qam:

    #################################
    def __init__(self, modulation = {'0':(0,0), '1':(1,0)},bits_per_baud = 1):
        '''
        Create a modulator using OOK by default
        '''
        self.modulation    = modulation
        self.bits_per_baud = bits_per_baud

    #################################
    def generate_signal(self, data):
        '''
        Generate signal corresponding to the current modulation scheme to
        represent given binary string, data.
        '''
        def create_func(data):
            slot_data = []
            for i in range(0,len(data),self.bits_per_baud):
                slot_data.append(self.modulation[data[i:i+self.bits_per_baud]])

        func = create_func(data)
        s = Signal( func=func)
        return s







def qfunc(x):
    return 0.5-0.5*sp.erf(x/np.sqrt(2))


def function_SER_Nuerico(x, SNR_dB, M): 
    N=1000;
    N=0
    while  error<1000:
        N+=1; 
        sign_ran=np.random.randint(0, 16)
        S = qammod(x, M,'Gray')

    x = randi([0,M-1],N,1);
    k = log2(M); % bits per symbol

    tx = qammod(x, M,'Gray');
    err = zeros(1,7);
    for j = 1:numel(SNR_db)
        rx = awgn(tx, SNR_db(j),'measured');
        rx_demod = qamdemod( rx, M, 'Gray' );
        [~,err(j)] = biterr(x,rx_demod);
    


def function_SER(SNR_dB, M, segma):
    size=1000000
    SNR=10**(SNR_dB/10)
    mi=(4*(np.sqrt(M)-1))/(np.sqrt(M))
    sita=3/(M-1)
    gama=2*sita*(segma**2)*SNR
    pe_ana=(mi/2)*(1-np.sqrt(gama/(2+gama)))
    mu=0
    #nc=np.random.normal(mu, (segma), size=(size, 2)).view(np.complex128)
    #r=np.abs(nc).reshape(size,1) 
    pe_num=[]

    
        
    #pe=mi*qfunc(np.sqrt(sita*SNR))
    return pe_ana , pe_num

SNR_dB=np.linspace(0, 35, 20)
pe=function_SER(SNR_dB, 16, 1/np.sqrt(2))
 
#print(pe) 

plt.semilogy(SNR_dB, pe[0], 'r', label='Aproximada' ) 
plt.semilogy(SNR_dB, pe[1], '*', label='Simulada' ) 
  
plt.xlabel('SNR')
plt.ylabel('SER') 
plt.legend()
plt.axis([0, 35, 0.001, 10])
plt.grid(True)
plt.show() 