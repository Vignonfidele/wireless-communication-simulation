clear
B=0.5;
gama=[3,1000];
fun1 = @(x) (B*(-sqrt(-B^2+sqrt(-B^2+(x.^2./gama))))).*exp(-(x.^2./2)); 
A1=integral(fun1,B,Inf,'ArrayValued',true);