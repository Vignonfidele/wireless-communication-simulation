import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, ifft
import os  
os.system ("cls")

# Simulation Params, feel free to tweak these 
Fs = 0.001      # sample rate of simulation
Ts=1/Fs
N = 100000     # number of amostras to sum 
fd =5          #Maximum Doppler shift (Hz) 
t = np.arange(0,N)*Ts       # time vector. (start, stop, step) 
n=100
X = np.zeros(len(t))
Y = np.zeros(len(t))
#Fs/fd
mu=0
sigma=1
for i in range(n):  
    X= X + np.random.normal(mu, sigma)
    Y= Y + np.random.normal(mu, sigma)
s=np.sqrt(1/(np.pi*fd*np.sqrt(1-0.3**2)))
print(s)    
#Para a variavel x:
out1x = fft(X)
out2x = out1x*s
out3x = ifft(out2x).real
out4x = out3x**2  
#Para a variavel y: 
out1y = fft(Y)
out2y = out1y*s 
out3y = ifft(out2y).real
out4y = out3y**2
Y= Y + out4y 
print(np.size(Y))
z = (1/np.sqrt(n)) * (X + 1j*Y) # this is what you would actually use when simulating the channel
print(np.size(z))
z_mag = np.abs(z) # take magnitude for the sake of plotting
z_mag_dB = 10*np.log10(z_mag) # convert to dB

print((z_mag_dB))
print((t))
# Plot fading over time
plt.plot(t, z_mag_dB)
plt.plot([0, 1], [0, 0], ':r') # 0 dB
plt.legend(['Rayleigh Fading', 'No Fading'])
#plt.axis([0, 1, -15, 5])
plt.show()