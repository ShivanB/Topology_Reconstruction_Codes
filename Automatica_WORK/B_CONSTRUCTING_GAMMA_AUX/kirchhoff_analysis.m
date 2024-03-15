clc

syms l12 	l13	l14	l15 	l16	l17	l114	l115	l116	l117	l118	l119...
    l12 	l23	l24 l28	l29	l210	l220	l221	l222 l13	l23	l341...
    l14	l24	l34	l411	l412	l413 l15 l16 l17 l28 l29 l210 l411 l412 l413...
    l114 l115 l116l117...
    l118...
    l119...
    l220...
    l221...
    l222
   x=[l12 l13 l14 l15 l16 l17 l114 l115 l116	l117	l118	l119 	l23 l24 l28 l29 l210 l220 l221 l222 l34 l411 l412	l413]; 
%%
a=1;
 [r13star, r14star, r34star, L] = polygen(a);

%%
           %l12 l13 l14 l15 l16 l17 l114 l115 l116	l117	l118	l119 	l23 l24 l28 l29 l210 l220 l221 l222 l34 l411 l412	l413
% solut=[0     0     0     1    0      0      1       0       0     0     0     0    1      0      0      1     0     0];

% Lapval=subs(L,[l12 l13 l14 l15 l16  l111 l112 l113 l114 l23 l24 l27 l28 l215 l216 l34 l39 l310],solut);
Lapval=L;

t=det(Lapval([2:16],[2:16]));
% r12=det(Lapval([3:16],[3:16]))/t;
r13=det(Lapval([2,4:16],[2,4:16]))/t;
r14=det(Lapval([2,3,5:16],[2,3,5:16]))/t;
% r23=det(Lapval([1,4:16],[1,4:16]))/t;
% r24=det(Lapval([1,3,5:16],[1,3,5:16]))/t;
r34=det(Lapval([1,2,5:16],[1,2,5:16]))/t;

rdstar=[ r13star; r14star;  r34star];
%r12star;r23star; r24star;
rdhat=[r13;r14;r34];
%r12;;r23;r24

objfun=transpose((rdstar-rdhat))*(rdstar-rdhat);
%objfunh=matlabFunction(objfun,'vars',{x});
 
[c,ceq] = pol_cons(x);
constraint=[c,ceq];
%constrainth=matlabFunction(constraint,'vars',{x});
   %  l12  l13   l14    l15     l16  l17    l114   l115   l116	l117	l118	l119 	l23 l24 l28 l29 l210 l220 l221 l222 l34 l411 l412	 l413
x0 = [0,   0,     0,      0,      1,    0,       1,      0,      0,       0,     0,     0,    0,   0,  0,   0,   1,     0,     0,    0,    0,    0,    0,   0];
A = []; 
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
x = fmincon(objfun,x0,A,b,Aeq,beq,lb,ub,constraint)

