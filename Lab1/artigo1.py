import numpy as np
import matplotlib.pyplot as plt
from scipy import special as sp
from scipy.stats import nakagami 
#########Parametro
size=10000
Size1=41
mu=0
mi=10
tau=3
d_s_r=5
d_r_1=1
d_r_2=3
R1=0.2
R2=0.1
phi1=pow(2,2*R1)-1
phi2=pow(2,2*R2)-1
alpha1=0.9
alpha2=1-alpha1
Belta1=0.2
Belta2=1-Belta1
E_r_dB=-15  ##SIC
E_r=10**(E_r_dB/20)
 
E_1_dB=-15  ##SIC
E_1=10**(E_1_dB/20)
 


sigma_s_r=mi*pow(d_s_r,-tau)
sigma_r_1=mi*pow(d_r_1,-tau)
sigma_r_2=mi*pow(d_r_2,-tau)




####### Gera canal CN
h_sr = np.random.normal(mu, (sigma_s_r), size=(size, 2)).view(np.complex128)
h_r1 = np.random.normal(mu, (sigma_r_1), size=(size, 2)).view(np.complex128)
h_r2 = np.random.normal(mu, (sigma_r_2), size=(size, 2)).view(np.complex128)
print(pow(h_sr,2))
 


def FunctionName(Value):
    #####SINR
    P_OUT=[]
    P_OUT1=[]
    OUT_AnalyD1=[]
    OUT_AnalyD2=[]
    AsympOUT_AnalyD1=[]
    AsympOUT_AnalyD2=[]
    K_sr=Value  ##CSI
    K_r1=K_sr ##CSI
    K_r2=K_sr ##CSI
    #####Gera os hchapeau
    sigmaChap_s_r=(sigma_s_r-K_sr)
    sigmaChap_r_1=(sigma_r_1-K_r1)
    sigmaChap_r_2=(sigma_r_2-K_r2)

    hChap_sr = np.random.normal(mu,  np.sqrt(sigmaChap_s_r/2), size=(size, 2)).view(np.complex128)
    hChap_r1 = np.random.normal(mu,  np.sqrt(sigmaChap_r_1/2), size=(size, 2)).view(np.complex128)
    hChap_r2 = np.random.normal(mu,  np.sqrt(sigmaChap_r_2/2), size=(size, 2)).view(np.complex128)
    for rhodB in range(Size1):

        rho=pow(10,(rhodB/10))
        #out_analy = np.piecewise(alpha1,Belta1,[(alpha1>(alpha2*phi1)) & \
        #(Belta1>(Belta2*E_1*phi1))],[lambda alpha1,Belta1: \
       # ])

       #Expressao exacta
        Ana1D1=phi1*(1+(K_sr*rho))
        Ana2D1=rho*sigmaChap_s_r*(alpha1-(alpha2*phi1))
        Ana3D1=phi1*(1+(K_r1*rho))
        Ana4D1=rho*sigmaChap_r_1*(Belta1-(Belta2*phi1*E_1))
        out_analyD1=1-np.exp(-(Ana1D1/Ana2D1)-(Ana3D1/Ana4D1))
        OUT_AnalyD1=np.append(OUT_AnalyD1, out_analyD1)

        Ana1D2=phi2*(1+(K_sr*rho))
        Ana2D2=rho*sigmaChap_s_r*(alpha2-(alpha1*E_r*phi2))
        Ana3D2=phi2*(1+(K_r2*rho))
        Ana4D2=rho*sigmaChap_r_2*(Belta2-(Belta1*phi2))
        out_analyD2=1-np.exp(-(Ana1D2/Ana2D2)-(Ana3D2/Ana4D2))
        OUT_AnalyD2=np.append(OUT_AnalyD2, out_analyD2)
        
        #Expressao asymp
        Asymp1D1=phi1*(1+(K_sr*rho))
        Asymp2D1=rho*sigmaChap_s_r*(alpha1-(alpha2*phi1))
        Asymp3D1=phi1*(1+(K_r1*rho))
        Asymp4D1=rho*sigmaChap_r_1*(Belta1-(Belta2*phi1*E_1))
        Asympout_analyD1=(Asymp1D1/Asymp2D1)+(Asymp3D1/Asymp4D1)
        AsympOUT_AnalyD1=np.append(AsympOUT_AnalyD1, Asympout_analyD1)

        AsympAna1D2=phi2*(1+(K_sr*rho))
        AsympAna2D2=rho*sigmaChap_s_r*(alpha2-(alpha1*E_r*phi2))
        AsympAna3D2=phi2*(1+(K_r2*rho))
        AsympAna4D2=rho*sigmaChap_r_2*(Belta2-(Belta1*phi2))
        Asympout_analyD2=(AsympAna1D2/AsympAna2D2)+(AsympAna3D2/AsympAna4D2)
        AsympOUT_AnalyD2=np.append(AsympOUT_AnalyD2, Asympout_analyD2)

        OUT=[]
        OUT1=[]
        for i in range(size):
            #print(hChap_sr(i))

            SINR_1_sr=(rho*alpha1*pow(abs(hChap_sr[i]),2))/((rho*alpha2*pow(abs(hChap_sr[i]),2))+(K_sr*rho)+1)
            SINR_2_sr=(rho*alpha2*pow(abs(hChap_sr[i]),2))/((E_r*rho*alpha1*pow(abs(hChap_sr[i]),2))+(K_sr*rho)+1)
            SINR_1_r1=(rho*Belta1*pow(abs(hChap_r1[i]),2))/((E_1*rho*Belta2*pow(abs(hChap_r1[i]),2))+(K_r1*rho)+1)
            SINR_2_r2=(rho*Belta2*pow(abs(hChap_r2[i]),2))/((rho*Belta1*pow(abs(hChap_r2[i]),2))+(K_r2*rho)+1)
            Num1=np.log2(1+SINR_1_sr)
            Num2=np.log2(1+SINR_1_r1)
            Num3=(1/2)*min(Num1,Num2)
            out=Num3<R1
            OUT=np.append(OUT,out)
            Num11=np.log2(1+SINR_2_sr)
            Num21=np.log2(1+SINR_2_r2)
            Num31=(1/2)*min(Num11,Num21)
            out1=Num31<R2
            OUT1=np.append(OUT1,out1)
        P_out=sum(OUT)/size
        P_OUT=np.append(P_OUT,P_out)
        P_out1=sum(OUT1)/size
        P_OUT1=np.append(P_OUT1,P_out1)
        outarray = np.concatenate([P_OUT,P_OUT1,OUT_AnalyD1,OUT_AnalyD2,AsympOUT_AnalyD1,AsympOUT_AnalyD2])      
    return outarray

P_OUT11=FunctionName(0)
P_OUT2=FunctionName(0.001)
rhodb=np.arange(0,Size1)

#Numerico com K_sr=0
plt.semilogy(rhodb,P_OUT11[0:Size1], 'r*' )
plt.semilogy(rhodb,P_OUT11[Size1:2*Size1], 'r*' )

#Analitico com K_sr=0
plt.semilogy(rhodb,P_OUT11[2*Size1:3*Size1],'k--')
plt.semilogy(rhodb,P_OUT11[3*Size1:4*Size1],'k--')


#Numerico com K_sr=0.001
plt.semilogy(rhodb,P_OUT2[0:Size1], 'ko' )
plt.semilogy(rhodb,P_OUT2[Size1:2*Size1], 'ko' )

#Analitico com K_sr=0
plt.semilogy(rhodb,P_OUT2[2*Size1:3*Size1],'k--')
plt.semilogy(rhodb,P_OUT2[3*Size1:4*Size1],'k--')


#Analitico com K_sr=0
plt.semilogy(rhodb,P_OUT11[4*Size1:5*Size1],'b--')
plt.semilogy(rhodb,P_OUT11[5*Size1:6*Size1],'b--')

#Analitico com K_sr=0.001
plt.semilogy(rhodb,P_OUT2[4*Size1:5*Size1],'b--')
plt.semilogy(rhodb,P_OUT2[5*Size1:6*Size1],'b--')

#plt.semilogy(rhodb,P_OUT2[0:Size1])
#plt.semilogy(rhodb,P_OUT2[Size1:2*Size1])

plt.xlim(0,Size1-1)
plt.ylim(0.0001, 10)
#plt.xlabel('SNR[dB]')
#plt.ylabel('Outage probability')
#plt.legend()
plt.grid(True, which="both", ls="-")
plt.show()       
 
 