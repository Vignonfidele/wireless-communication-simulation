import numpy as np
import matplotlib.pyplot as plt

n=10     #Número de amostras
xfunction=np.array([])   

for i in range(n):
    x1=np.random.uniform(0,1)  # gerar una primero variavel uniforme
    x2=np.random.uniform(0,1)  # gerar una secunda variavel uniforme
    
    while (x2 >=(27/4)*x1*pow((1-x1),2)):   #Enquento a segunda variavel é maior o igual que f(x)/c(g(x)) gerar uma nova x1 e x2
        x1=np.random.uniform(0,1)
        x2=np.random.uniform(0,1)
    xfunction = np.append(xfunction, x1) #adicionar x1 a xfunction declarado no inicio do codigo
print(xfunction)  #printaear  

X=np.arange(0,1, 0.1)
fx=12*X*pow((1-X),2)      #pdf
plt.plot(X,fx)  # plotar a pdf 
plt.hist(xfunction,bins=100,density=True)   # histograma da variavel gerada.
plt.show()