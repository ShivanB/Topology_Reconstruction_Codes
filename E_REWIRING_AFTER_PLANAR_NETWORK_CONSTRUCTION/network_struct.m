function [L,r13star,r14star,r34star,...
    r12hat, r23hat, r24hat,...
    r12,r13,r14,r15,r16,r23,...
    r24,r25,r26,r34,r35,r36,...
    r45,r46,r56] =...
    network_struct(l12, l14, l15,...
    l16, l23, l26, l34, l36, l45, l46, l56)

d1 = (l12+l14+l15+l16);
d2 = (l12+l23+l26);
d3 = (l23+l34+l36);
d4 = (l14+l34+l45+l46);
d5 = (l15+l45+l56);
d6 = (l16+l26+l36+l46+l56);

L=[d1   -l12    0  -l14   -l15  -l16
  -l12    d2  -l23   0      0   -l26 
   0    -l23    d3  -l34    0   -l36
  -l14    0   -l34   d4   -l45  -l46
  -l15    0     0   -l45   d5   -l56
  -l16  -l26  -l36  -l46  -l56   d6];

%Measured resistance distance
r13star=1.4985;
r14star=1.3509;
r34star=1.0795;
%estimated resistance distance
r12hat=1.3065;
r23hat=1.1464;
r24hat=1.3207;
%%
b12=[1;-1;0;0;0;0];
b13=[1;0;-1;0;0;0];
b14=[1;0;0;-1;0;0];
b15=[1;0;0;0;-1;0];
b16=[1;0;0;0;0;-1];

b23=[0;1;-1;0;0;0];
b24=[0;1;0;-1;0;0];
b25=[0;1;0;0;-1;0];
b26=[0;1;0;0;0;-1];  

b34=[0;0;1;-1;0;0];
b35=[0;0;1;0;-1;0];
b36=[0;0;1;0;0;-1];

b45=[0;0;0;1;-1;0];
b46=[0;0;0;1;0;-1];

b56=[0;0;0;0;1;-1];


r12=transpose(b12)*pinv(L)*b12;
r13=transpose(b13)*pinv(L)*b13;
r14=transpose(b14)*pinv(L)*b14;
r15=transpose(b15)*pinv(L)*b15;
r16=transpose(b16)*pinv(L)*b16;

r23=transpose(b23)*pinv(L)*b23;
r24=transpose(b24)*pinv(L)*b24;
r25=transpose(b25)*pinv(L)*b25;
r26=transpose(b26)*pinv(L)*b26;

r34=transpose(b34)*pinv(L)*b34;
r35=transpose(b35)*pinv(L)*b35;
r36=transpose(b36)*pinv(L)*b36;

r45=transpose(b45)*pinv(L)*b45;
r46=transpose(b46)*pinv(L)*b46;

r56=transpose(b56)*pinv(L)*b56;

end
