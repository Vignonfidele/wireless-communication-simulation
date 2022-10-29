'''Para reproducir este script será necesario instalar as bibliotecas numpy ,  matplotlib, scipy'''
import numpy as np                          #Biblioteca para operacao matematica
from scipy.stats import uniform
import matplotlib.pyplot as plt 

####### Parameters #####

size=100000  
 
def xfunction_numeric(B, size): 
    x= uniform.rvs( -B ,2*B, size).reshape(size,1)
    y= uniform.rvs( -B, 2*B, size).reshape(size,1)
    Sv1=x+1j*y 
    Sv=np.abs(Sv1)             #Calcula o modulo  
    return Sv 

####### Trazar a funcao definida por parte  
def xfunction(B):
    r = np.linspace(0, 10, num=size) 
    pr_analitica = np.piecewise(r, [((r>=0)&(r<=B)),\
        ((r>=B)&(r<=np.sqrt(2)*B))], \
        [lambda r: ((np.pi*r)/(2*(B**2))), \
            lambda r: (r/B**2)*(-np.arccos(B/r)+np.arcsin(B/r))])
    return pr_analitica 

######## Plote #################################
pr_analitica1=xfunction(2)
pr_analitica2=xfunction(6)

pr_numerico1 = xfunction_numeric(2, size) 
pr_numerico2 = xfunction_numeric(6, size)  

r = np.linspace(0, 10, num=size)

fig, (ax1, ax2) = plt.subplots(1, 2)
fig.suptitle("Distribuição de h(t) para B=2 e B=6")
ax1.plot(r, pr_analitica1, label='B=2')
ax2.plot(r, pr_analitica2, label='B=6') 
ax1.hist(pr_numerico1,color ='g', \
     bins=100, density=True, label='Histogram') 
ax2.hist(pr_numerico2, color ='g', \
     bins=100, density=True, label='Histogram') 

ax1.set(xlabel='r')
ax1.set(ylabel='p(r)')
ax2.set(xlabel='r') 
plt.show()  