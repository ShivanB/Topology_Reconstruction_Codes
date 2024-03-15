function [L, r13star, r14star, r34star,...
    r12hat, r23hat, r24hat,...
    r12,r13,r14,r23,r24,r34] =...
    network_struct(l12, l13, l14, l23, l34)

d1 = (l12 + l13 + l14);
d2 = (l12 + l23);
d3 = (l13 + l23 + l34);
d4 = (l14 + l34);


L=[d1 -l12 -l13 -l14
  -l12  d2 -l23   0
  -l13 -l23 d3  -l34
  -l14   0 -l34  d4];

%Measured resistance distance
r13star=1.4984;
r14star=1.351;
r34star=1.0795;
%estimated resistance distance
r12hat=1.3065;
r23hat=1.1464;
r24hat=1.3207;
%%
b12=[1;-1;0;0];
b13=[1;0;-1;0];
b14=[1;0;0;-1];
b23=[0;1;-1;0];
b24=[0;1;0;-1];
b34=[0;0;1;-1];

r12=transpose(b12)*pinv(L)*b12;
r13=transpose(b13)*pinv(L)*b13;
r14=transpose(b14)*pinv(L)*b14;
r23=transpose(b23)*pinv(L)*b23;
r24=transpose(b24)*pinv(L)*b24;
r34=transpose(b34)*pinv(L)*b34;

end
