
clc
format short

syms l12 	l13	l14	l15 	l16	l17	l114	l115	l116	l117	l118	l119...
    l12 	l23	l24 l28	l29	l210	l220	l221	l222 l13	l23	l341...
    l14	l24	l34	l411	l412	l413 l15 l16 l17 l28 l29 l210 l411 l412 l413...
    l114 l115 l116l117...
    l118...
    l119...
    l220...
    l221...
    l222
%%
%OBTAINED FROM SOLVING OP1, OP2, OP3,OP4,OP5,OP6.
   %l12 l13 l14 l15 (l16) l17 
   %l114 l115 (l116) (l117) l118 l119
   %l23 l24 l28 l29 (l210) l220
   %l221 l222 l34 l411 l412 (l413)   
x0=[0, 0, 0, 1, 0, 0,...
    0, 0, 1, 1, 0, 0,... 
    0, 0, 0, 0, 1, 0,...
    0, 0, 0, 0, 0, 1];
                    
%      
% x0 = [0, 0, 0, 1, 0, 0,...
%          0, 1, 0, 1, 0, 0,... 
%          0, 0, 0, 0, 1, 0,...
%          0, 0, 0, 0, 0, 1];
     
[L,r13star,r14star,r34star]=...
network_struct(l12, l13, l14, l15, l16, l17, l114, l115, l116,...
               l117, l118, l119, l23, l24, l28, l29, l210, l220,...
               l221, l222, l34, l411, l412, l413);

% vector of unknown variables
rho = [l12, l13, l14, l15, l16, l17, l114, l115, l116,...
     l117, l118, l119, l23, l24, l28, l29, l210, l220,...
                   l221, l222, l34, l411, l412, l413];
%%
  solut=transpose([ 0.0001
    0.1091
    0.1266
    0.2422
    0.0048
    0.1294
    0.3829
    0.1536
    0.2788
    0.9012
    0.0151
    0.0333
    0.0004
    0.0002
    0.0000
    0.0001
    0.0001
    0.0003
    0.0000
    0.0002
    0.1986
    0.2893
    0.1642
    0.7792
]);

% solut=x0;

Lapval=subs(L,[l12  l13   l14    l15     l16  l17    l114   l115   l116...
    l117	l118	l119 	l23 l24 l28 l29 l210 l220 l221 l222 l34...
    l411 l412	 l413],solut);

rho = subs(rho,[l12  l13   l14    l15     l16  l17    l114   l115   l116...
    l117 l118 l119 l23 l24 l28 l29 l210 l220 l221 l222 l34 l411...
    l412 l413],solut);

% Lapval=(Lapval);

t=det(Lapval([2:end],[2:end]));

r12=det(Lapval([3:end],[3:end]))/t;
r13=det(Lapval([2,4:end],[2,4:end]))/t;
r14=det(Lapval([2,3,5:end],[2,3,5:end]))/t;
r23=det(Lapval([1,4:end],[1,4:end]))/t;
r24=det(Lapval([1,3,5:end],[1,3,5:end]))/t;
r34=det(Lapval([1,2,5:end],[1,2,5:end]))/t;

% r12hat=1.3065;
% r23hat=1.1464;
% r24hat=1.3207;

rdstar=[r13star;r14star;r34star];
rdhat=[r13;r14;r34];

%%
% Kirchhoffs Index computations
KGamma_M = kirchhoffs(Lapval, t, r13star,r14star,r34star);
%% objective function
digits(4)
value=...
vpa((transpose((rdstar-rdhat))*(rdstar-rdhat))+...
(KGamma_M-19.8)^2) 

%orig_value=111.7;