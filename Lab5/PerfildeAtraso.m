 
a1=[0.9, 0.75 , - 0.1 ] ;
a2=[0.75 , - 0.25 ,  0.15  ];
a3=[0.6, - 0.2] ;
coe=10^(-6);
t1=[0 , 0.15*coe , 0.35*coe  ] ;
t2=[0 , 0.25*coe ,  0.4*coe ];
t3=[0 , 0.6*coe];
A=0;
B=0;
for i= 1:1:2
    A=A+(a3(i)^2*t3(i)^2);
    B=B+a3(i)^2;
end
Res1=A/B
A=0;
B=0;
for i= 1:1:2
    A=A+(a3(i)^2*t3(i)^2);
    B=B+a3(i)^2;
end

Res=A/B
A=0;
B=0;

for i= 1:1:2
    A=A+(a3(i)^2*t3(i)^2);
    B=B+a3(i)^2;
end
Res=A/B
