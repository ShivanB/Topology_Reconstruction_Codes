
clc
format short
%  l12  l13   l14    l15     l16  l17    l114   l115   l116	l117	l118	l119 	l23 l24 l28 l29 l210 l220 l221 l222 l34 l411 l412	 l413
%%
%OBTAINED FROM SOLVING OP1, OP2, OP3,OP4,OP5,OP6.
   %l12 l13 l14 l15 l16 l17 
   %l114 l115 l116 l117 l118 l119
   %l23 l24 l28 l29 l210 l220
   %l221 l222 l34 l411 l412	l413

   
x0 = [0,   0,    0,      0,     1,   0,...       
      1,   1,    0,      1,     0,    0,...   
      0,   0,    0,      0,     1,    0,...    
      0,   0,    0,   0,     0,    1];

%%
A = []; 
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
options = optimoptions('fmincon','Algorithm', 'sqp','Display', 'iter')
%'Algorithm', 'sqp'
x = fmincon(@(x)objfun(x(1),x(2),x(3),x(4),x(5),x(6),...
    x(7),x(8),x(9),x(10),x(11),x(12), x(13),x(14),x(15),x(16),x(17),x(18),...
    x(19),x(20),x(21),x(22),x(23),x(24)),...
    x0,A,b,Aeq,beq,lb,ub,...
    @(x)pol_cons(x(1),x(2),x(3),x(4),x(5),x(6),...
    x(7),x(8),x(9),x(10),x(11),x(12), x(13),x(14),x(15),x(16),x(17),x(18),...
    x(19),x(20),x(21),x(22),x(23),x(24)),options);
digits(3)
disp(transpose(x))
%%
function value = objfun(l12, l13, l14, l15, l16, l17, l114, l115, l116,...
                        l117, l118, l119, l23, l24, l28, l29, l210, l220,...
                        l221, l222, l34, l411, l412, l413)
                    
[L,r13star,r14star,r34star]=network_struct(l12, l13, l14, l15, l16, l17, l114, l115, l116,...
                        l117, l118, l119, l23, l24, l28, l29, l210, l220,...
                        l221, l222, l34, l411, l412, l413);
% vector of unknown variables
rho = [l12, l13, l14, l15, l16, l17, l114, l115, l116,...
     l117, l118, l119, l23, l24, l28, l29, l210, l220,...
                   l221, l222, l34, l411, l412, l413];
%%
           %l12 l13 l14 l15 l16 l17 l114 l115 l116	l117	l118	l119 	l23 l24 l28 l29 l210 l220 l221 l222 l34 l411 l412	l413
% solut=[0     0     0     1    0      0      1       0       0     0     0     0    1      0      0      1     0     0];

% Lapval=subs(L,[l12 l13 l14 l15 l16  l111 l112 l113 l114 l23 l24 l27 l28 l215 l216 l34 l39 l310],solut);
Lapval=L;

t=det(Lapval([2:end],[2:end]));
r13=det(Lapval([2,4:end],[2,4:end]))/t;
r14=det(Lapval([2,3,5:end],[2,3,5:end]))/t;
r34=det(Lapval([1,2,5:end],[1,2,5:end]))/t;

rdstar=[ r13star; r14star;  r34star];
rdhat=[r13;r14;r34];
%%
% Kirchhoffs Index computations
KGamma_M = kirchhoffs(Lapval, t, r13star,r14star,r34star);
%% objective function
value=(transpose((rdstar-rdhat))*(rdstar-rdhat)) + (KGamma_M-19.8)^2 + 1*norm(rho,1);
end 

function [c,ceq] = pol_cons(l12, l13, l14, l15, l16, l17, l114, l115, l116, l117, l118,...
                                 l119, l23, l24, l28, l29, l210, l220, l221, l222, l34, l411, l412, l413)

c(1)=l12*(l12-1);
c(2)=l13*(l13-1);
c(3)=l14*(l14-1);
c(4)=l15*(l15-1);
c(5)=l16*(l16-1);
c(6)=l17*(l17-1);
c(7)=l114*(l114-1);
c(8)=l115*(l115-1);
c(9)=l116*(l116-1);
c(10)=l117*(l117-1);
c(11)=l118*(l118-1);
c(12)=l119*(l119-1);
c(13)=l23*(l23-1);
c(14)=l24*(l24-1);
c(15)=l28*(l28-1);
c(16)=l29*(l29-1);
c(17)=l210*(l210-1);
c(18)=l220*(l220-1);
c(19)=l221*(l221-1);
c(20)=l222*(l222-1);
c(21)=l34*(l34-1);
c(22)=l411*(l411-1);
c(23)=l412*(l412-1);
c(24)=l413*(l413-1);

[L,r13star,r14star,r34star]=network_struct(l12, l13, l14, l15, l16, l17, l114, l115, l116,...
                        l117, l118, l119, l23, l24, l28, l29, l210, l220,...
                        l221, l222, l34, l411, l412, l413);
t=det(L(2:end,2:end));
%%
%Triangle inequality:123
c(25)=(r13star*t)-( det(L(3:end,3:end)) + det(L([1,4:end],[1,4:end])) ); 
%Triangle inequality:124
c(26)=(r14star*t)-( det(L(3:end,3:end)) + det(L([1,3,5:end],[1,3,5:end])) );
%%
%Kalmansons condition: 1234
c(27)=( det(L(3:end,3:end)) + (r34star*t) ) -...
                    ( (r13star*t) + det(L([1,3,5:end],[1,3,5:end])) );                
c(28)=( det(L([1,4:end],[1,4:end])) + (r14star*t) ) -...
                    ( (r13star*t) + det(L([1,3,5:end],[1,3,5:end])) ); 
% c(29)=l16-1;
% c(30)=-l16;
% c(31)=l12-1;
% c(32)=-l12;
% c(33)=l13-1;
% c(34)=-l13;
% c(35)=l14-1;
% c(36)=-l14;
% c(37)=l15-1;
% c(38)=-l15;
% c(39)=l17-1;
% c(40)=-l17;
% 
% ceq(1)=l16-1;
% ceq(2)=l114-1;
% ceq(3)=l115-1;

 ceq = [];
end
   

