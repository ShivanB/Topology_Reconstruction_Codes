%%
%computation of estimates of resistant distances.
clc 
format short
clc
clear all
%% 
%ORIGINAL NETWORK
l12star=-1/2.2;
l13star=0;
l14star=-1/3.1;
l15star=-1/2.3;
l16star=0;
l11star=-(l12star+l13star+l14star+l15star+l16star);

l21star=l12star;
l23star=-1/1.2;
l24star=0;
l25star=0;
l26star=-1/2.5;
l22star=-(l21star+l23star+l24star+l25star+l26star);

l31star=l13star;
l32star=l23star;
l34star=-1/1.6;
l35star=0;
l36star=-1/3.4;
l33star=-(l31star+l32star+l34star+l35star+l36star);

l41star=l14star;
l42star=l24star;
l43star=l34star;
l45star=-1/2.5;
l46star=0;
l44star=-(l41star+l42star+l43star+l45star+l46star);

l51star=l15star;
l52star=l25star;
l53star=l35star;
l54star=l45star;
l56star=-1/1.6;
l55star=-(l51star+l52star+l53star+l54star+l56star);

l61star=l16star;
l62star=l26star;
l63star=l36star;
l64star=l46star;
l65star=l56star;
l66star=-(l61star+l62star+l63star+l64star+l65star);


Lstar=[l11star l12star l13star l14star l15star l16star
    l12star l22star l23star l24star l25star l26star
    l13star l23star l33star l34star l35star l36star
    l14star l24star l34star l44star l45star l46star
    l15star l25star l35star l45star l55star l56star
    l16star l26star l36star l46star l56star l66star];

digits(3);
Lstar=vpa(Lstar);
nodes=6;
boun_node=4;
Lstar*ones(nodes,1)
J=ones(nodes,nodes);

Xstar=inv(Lstar+(1/nodes)*J);
Xbarstar = diag([Xstar(1,1),Xstar(2,2),Xstar(3,3),Xstar(4,4),Xstar(5,5),Xstar(6,6)]);

Rdstar=J*Xbarstar + Xbarstar*J -2*Xstar;
Kstar = 0.5*sum(sum(Rdstar));

rd14=Rdstar(1,4);
rd15=Rdstar(1,5);
rd16=Rdstar(1,6);
rd45=Rdstar(4,5);
rd46=Rdstar(4,6);
rd56=Rdstar(5,6);


%%
syms  x11 x12 x13 x14 x15 x16...
      x12 x22 x23 x24 x25 x26...
      x13 x23 x33 x34 x35 x36...
      x14 x24 x34 x44 x45 x46...
      x15 x25 x35 x45 x55 x66...
      x16 x26 x36 x46 x56 x66

X=[x11 x12 x13 x14 x15 x16
      x12 x22 x23 x24 x25 x26
      x13 x23 x33 x34 x35 x36
      x14 x24 x34 x44 x45 x46
      x15 x25 x35 x45 x55 x66
      x16 x26 x36 x46 x56 x66];

rd12=x11+x22-2*x12;
rd13=x11+x33-2*x13;

rd23=x22+x33-2*x23;
rd24=x22+x44-2*x24;
rd25=x22+x55-2*x25;
rd26=x22+x66-2*x26;

rd34=x33+x44-2*x34;
rd35=x33+x55-2*x35;
rd36=x33+x66-2*x36;

Rd=[0 rd12 rd13 rd14 rd15 rd16
      rd12 0 rd23 rd24 rd25 rd26
      rd13 rd23 0 x34 rd35 rd36
      rd14 rd24 rd34 0 rd45 rd46
      rd15 rd25 rd35 rd45 0 rd56
      rd16 rd26 rd36 rd46 rd56 0];

%eqns3=0.2*ones(1,6)*Rd*ones(6,1)==0;

eqns1=[
x11+x44-2*x14==2.82,
x11+x55-2*x15==1.18,
x11+x66-2*x16==0.824,
x44+x55-2*x45==2.59,
x44+x66-2*x46==3.29,
x55+x66-2*x56==1.41,
0.5*ones(1,6)*Rd*ones(6,1)==19.7721
];

eqns2=X*ones(6,1)==ones(6,1);
eqns=[eqns1;eqns2];
[A,b] = equationsToMatrix(eqns)
%% Inequality constraint
ineqns=[
rd12+rd23-rd13==0
rd12+rd24-rd14==0
rd12+rd25-rd15==0
rd12+rd26-rd16==0
rd13+rd34-rd14==0
rd13+rd35-rd15==0
rd13+rd36-rd16==0
%ik+jl-(ij+kl)>=0
% ijkl=1234
 rd13+rd24-(rd12+rd34)==0   
% i j k l=1 2 3 5
 rd13+rd25-(rd12+rd35)==0   
 % i j k l=1 2 3 6
 rd13+rd26-(rd12+rd36)==0   
 % i j k l=1 2 4 5
 rd14+rd25-(rd12+rd45)==0   
 % i j k l=1 2 4 6
 rd14+rd26-(rd12+rd46)==0   
 % i j k l=1 2 5 6
 rd15+rd26-(rd12+rd56)==0 
 % i j k l=1 3 4 5
 rd14+rd35-(rd13+rd45)==0 
% i j k l=1 3 4 6
 rd14+rd36-(rd13+rd46)==0 
% i j k l=1 3 5 6
 rd15+rd36-(rd13+rd56)==0 
 %ik+jl-(il+jk)>=0
 % ijkl=1234
 rd13+rd24-(rd14+rd23)==0   
% i j k l=1 2 3 5
 rd13+rd25-(rd15+rd23)==0   
 % i j k l=1 2 3 6
 rd13+rd26-(rd16+rd23)==0   
 % i j k l=1 2 4 5
 rd14+rd25-(rd15+rd24)==0   
 % i j k l=1 2 4 6
 rd14+rd26-(rd16+rd24)==0   
 % i j k l=1 2 5 6
 rd15+rd26-(rd16+rd25)==0 
 % i j k l=1 3 4 5
 rd14+rd35-(rd15+rd34)==0 
% i j k l=1 3 4 6
 rd14+rd36-(rd16+rd34)==0 
% i j k l=1 3 5 6
 rd15+rd36-(rd16+rd35)==0 
 ];

variable=[x11; x12; x13; x14; x15; x16;...
      x22; x23; x24; x25; x26;...
      x33; x34; x35; x36;...
      x44; x45; x46;...
      x55; x56;...
      x66];

[Aineq Bineq]=equationsToMatrix(ineqns,variable)
%% 
%Convex optimization
 W=10*eye(13);
 W(13,13)=20; W(12,12)=20;W(11,11)=20; W(10,10)=20;W(9,9)=20;W(8,8)=20;
 
n=21;
cvx_begin
    variables y(n) gama 

    Y=[y(1) y(2) y(3) y(4) y(5) y(6)
          y(2) y(7) y(8) y(9) y(10) y(11)
          y(3) y(8) y(12) y(13) y(14) y(15)
          y(4) y(9) y(13) y(16) y(17) y(18)
          y(5) y(10) y(14) y(17) y(19) y(20)
          y(6) y(11) y(15) y(18) y(20) y(21)];

    minimize( norm( sqrt(W)*(double(A) * y - double(b)), 2 ) )
    subject to
     double(Aineq) * y >= double(Bineq);
     gama>=0
     gama<=10
     Y-(gama*eye(6))>=0;
     %Y*ones(6,1)==ones(6,1);

cvx_end
%%


sol=y;

Xhat=double(vpa([sol(1) sol(2) sol(3) sol(4) sol(5) sol(6)
      sol(2) sol(7) sol(8) sol(9) sol(10) sol(11)
      sol(3) sol(8) sol(12) sol(13) sol(14) sol(15)
      sol(4) sol(9) sol(13) sol(16) sol(17) sol(18)
      sol(5) sol(10) sol(14) sol(17) sol(19) sol(20)
      sol(6) sol(11) sol(15) sol(18) sol(20) sol(21)]))
eig(Xhat)
Xhat*ones(6,1)
Xbarhat = double(vpa([sol(1) 0 0 0 0 0
                                   0 sol(7) 0 0 0 0
                                   0 0 sol(12) 0 0 0
                                   0 0 0 sol(16) 0 0
                                   0 0 0 0 sol(19) 0
                                   0 0 0 0 0 sol(21)]));

Rdhat=ones(6,6)*Xbarhat + Xbarhat*ones(6,6) - 2*Xhat
Rdstar=double(Rdstar)
Khat = 0.5*sum(sum(Rdhat))
Kstar
% Lhat = inv(Xhat)-((1/6)*eye(6))
% Xhat =
% 
%     0.3870    0.2903    0.2903    0.0000    0.0000    0.0726
%     0.2903    0.3702    0.3702    0.0000    0.0000    0.1711
%     0.2903    0.3702    0.3702    0.0000    0.0000    0.1711
%     0.0000    0.0000    0.0000    2.2769    0.0000    0.0000
%     0.0000    0.0000    0.0000    0.0000    0.6298    0.0000
%     0.0726    0.1711    0.1711    0.0000    0.0000    0.6190