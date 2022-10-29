 
import numpy as np # for numerical computing
import matplotlib.pyplot as plt # for plotting functions
#from matplotlib import cm # colormap for color palette
from numpy.random import standard_normal

from DigiCommPy.modem import PSKModem
from DigiCommPy.channels import awgn

#---------Input Fields------------------------
nSym = 10**6 # Number of symbols to transmit
EbN0dBs = np.arange(start=-20,stop = 36, step = 2) # Eb/N0 range in dB for simulation
N = [1,2,4,8,10] # [1,2,3,4,10,20] #number of diversity branches
M = 4 #M-ary PSK modulation

k=np.log2(M)
EsN0dBs = 10*np.log10(k)+EbN0dBs # EsN0dB calculation

fig, ax = plt.subplots(nrows=1,ncols = 1) #To plot figure

for nRx in N: #simulate for each # of received branchs
        #Random input symbols to modulator
        inputSyms = np.random.randint(low=0, high = M, size=nSym)
        modem = PSKModem(M)
        s = modem.modulate(inputSyms) #modulated PSK symbols

        #nRx signal branches
        s_diversity = np.kron(np.ones((nRx,1)),s);

        ser_sim = np.zeros(len(EbN0dBs)) # simulated symbol error rates

        for i,EsN0dB in enumerate(EsN0dBs):

                #Rayleigh flat fading channel as channel matrix
                h = np.sqrt(1/2)*(standard_normal((nRx,nSym))+1j*standard_normal((nRx,nSym)))
                signal = h*s_diversity #effect of channel on the modulated signal

                #Computing the signal power and adding noise
                gamma = 10**(EsN0dB/10) #converting EsN0dB to linear scale
                P = np.sum(np.abs(signal)**2,axis=1)/nSym #calculate power in each branch of signal
                N0 = P/gamma #required noise spectral density for each branch
                #Scale each row of noise with the calculated noise spectral density
                noise = (standard_normal(signal.shape)+1j*standard_normal(signal.shape))*np.sqrt(N0/2)[:,None]

                r = signal+noise #received signal branches

                #Receiver processing
                equalized = np.sum(r*np.conj(h),axis=0) #equalized signal

                detectedSyms = modem.demodulate(equalized) #demodulation decisions
                ser_sim[i] = np.sum(detectedSyms != inputSyms)/nSym

        #ax.grid(True,which='both');
        ax.semilogy(EbN0dBs,ser_sim,label='N='+str(nRx))#plot simulated error rates

ax.set_xlim(-20,35);ax.set_ylim(0.0001,1.1);ax.grid(True,which='both');
ax.set_xlabel('Eb/N0(dB)');ax.set_ylabel('Symbol Error Rate($P_s$)')
ax.set_title('SER performance for QPSK over Rayleigh fading channel with MRC')
ax.legend();fig.show()