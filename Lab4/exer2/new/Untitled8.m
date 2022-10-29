B=4;
g=10;
syms r x;
f= r*(asin(B/r)-acos(B/r))*exp(-x^2/2);
int1=int(f,r,B,x/sqrt(g))
f = @(x) int1;
int2= integral(f,  0, Inf )