import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, ifft
import os  
os.system ("cls")
# Simulation Params, feel free to tweak these
v_mph = 60 # velocity of either TX or RX, in miles per hour
center_freq = 200e6 # RF carrier frequency in Hz
Fs = 0.1 # sample rate of simulation
N = 100 # number of sinusoids to sum
N1=10000
v = v_mph * 0.44704 # convert to m/s
fd = 1# max Doppler shift


print("max Doppler shift:", fd)
t = np.arange(0, N1*(1/Fs) , 1/Fs ) # time vector. (start, stop, step)

X = np.zeros(len(t))
Y = np.zeros(len(t))
for i in range(N):
    mu=0
    sigma=1
    s=np.sqrt(1/(np.pi*fd*np.sqrt(1-0.3**2)))
    #Para a variavel x:
    x= np.random.normal(mu, sigma, size=N).reshape(N,1) 
    out1x = fft(x).real
    out2x = out1x*s
    out3x = ifft(out2x).real
    out4x = out3x**2 
    X= X + out4x
    #Para a variavel y: 
    y= np.random.normal(mu, sigma, size=N).reshape(N,1) 
    out1y = fft(y).real 
    out2y = out1y*s 
    out3y = ifft(out2y).real
    out4y = out3y**2
    Y= Y + out4y

    ''' 
    alpha = (np.random.rand() - 0.5) * 2 * np.pi
    phi = (np.random.rand() - 0.5) * 2 * np.pi
    x = x + np.random.randn() * np.cos(2 * np.pi * fd * t * np.cos(alpha) + phi)
    y = y + np.random.randn() * np.sin(2 * np.pi * fd * t * np.cos(alpha) + phi)'''
 
# z is the complex coefficient representing channel, you can think of this as a phase shift and magnitude scale
print(Y)

z = (1/np.sqrt(N)) * (X + 1j*Y) # this is what you would actually use when simulating the channel

print(z)
z_mag = np.abs(z) # take magnitude for the sake of plotting
print(z_mag)
z_mag_dB = 10*np.log10(z_mag) # convert to dB

print(np.size(z_mag_dB))
print(np.size(t))
# Plot fading over time
plt.plot(t, z_mag_dB)
plt.plot([0, 1], [0, 0], ':r') # 0 dB
plt.legend(['Rayleigh Fading', 'No Fading'])
#plt.axis([0, 1, -15, 5])
plt.show()