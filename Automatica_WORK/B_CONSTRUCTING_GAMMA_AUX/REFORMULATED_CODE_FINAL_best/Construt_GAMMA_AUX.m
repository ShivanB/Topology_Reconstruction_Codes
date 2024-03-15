%REFORMULATED CODE: BEST RESULTS
clear all
clc
format short
%%
%OBTAINED FROM SOLVING OP1, OP2, OP3,OP4,OP5,OP6.
   %l12 l13 l14 l15 (l16) l17 
   %l114 l115 (l116) (l117) l118 l119
   %l23 l24 l28 l29 (l210) l220
   %l221 l222 l34 l411 l412 (l413)

%An excellent initial condition   

% x0=[0, 0, 0, 0, 1, 0,...
%     0, 0, 1, 1, 0, 0,... 
%     0, 0, 0, 0, 1, 0,...
%     0, 0, 0, 0, 0, 1,...
%     0.5,1,1,0.5,0.5,1,...
%     1];

% % An excellent initial condition
x0 =[0, 0, 0, 1, 0, 0,...
        0, 1, 0, 1, 0, 0,... 
        0, 0, 0, 0, 1, 0,...
        0, 0, 0, 0, 0, 1,...
        0.5,1,1,0.5,0.5,1,...
        1];

initial_rho=x0;
%% a=x(25), b=x(26), c=x(27), d=x(28), e=x(29), f=x(30)

for i=1:4

A = []; 
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];

options = optimoptions('fmincon','Algorithm',...
'sqp','Display','iter',...
'MaxFunctionEvaluations',5000);

[x,fval,exitflag] =...
fmincon(@(x)objfun(x(1),x(2),x(3),x(4),x(5),x(6),...
       x(7),x(8),x(9),x(10),x(11),x(12),...
       x(13),x(14),x(15),x(16),x(17),x(18),...
       x(19),x(20),x(21),x(22),x(23),x(24),...
       x(25),x(26),x(27),x(28),x(29),x(30),...
       x(31)),...
       x0,A,b,Aeq,beq,lb,ub,...
       @(x)pol_cons(x(1),x(2),x(3),x(4),x(5),x(6),...
       x(7),x(8),x(9),x(10),x(11),x(12),...
       x(13),x(14),x(15),x(16),x(17),x(18),...
       x(19),x(20),x(21),x(22),x(23),x(24),...
       x(25),x(26),x(27),x(28),x(29),x(30),...
       x(31)),...
       options);

digits(3)
disp(transpose(x))
x0=x;
end

rho=transpose(x);

modifiedRho = round_down_algo1(rho,initial_rho);

booleanrho=modifiedRho

[tri123, tri124, kal1234_1, kal1234_2] =...
    constraint_check(modifiedRho)

[value_esti_boolean, value_orig_boolean,...
    value_optimal] =...
    struct_objfun_value(booleanrho,initial_rho,x)

[Resist_Dist_Matrix, Resist_Dist_Matrix_4node]=...
    compute_Rd(modifiedRho);
%%
% Lnet=network_structure(modifiedRho);

%% ALL FUNCTIONS
function [c,ceq] =...
pol_cons(l12, l13, l14, l15, l16, l17, l114, l115,...
l116, l117, l118,l119, l23, l24,...
l28, l29, l210, l220, l221, l222,...
l34, l411, l412, l413,a,bstar,dstar,e,f,gstar,gamma)
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

[L,r13star,r14star,r34star]=...
network_struct(l12, l13,l14, l15, l16, l17,...
l114, l115, l116, l117, l118, l119,...
l23, l24,l28, l29, l210, l220,...
l221, l222, l34, l411, l412,l413);

t=det(L(2:end,2:end));
%%
%Triangle inequality:123
c(25)=(r13star*t)-( det(L(3:end,3:end)) + ...
        det(L([1,4:end],[1,4:end])) ); 
%Triangle inequality:124
c(26)=(r14star*t)-( det(L(3:end,3:end)) + ...
        det(L([1,3,5:end],[1,3,5:end])) );
%%
%Kalmansons condition: 1234
c(27)=( det(L(3:end,3:end)) + (r34star*t) ) - ...
      ( (r13star*t) + det(L([1,3,5:end],[1,3,5:end])) );     
  
c(28)=( det(L([1,4:end],[1,4:end])) + (r14star*t) ) - ...
      ( (r13star*t) + det(L([1,3,5:end],[1,3,5:end])) ); 
%%
ub=0.9;
lb=0.5;
%a<=0.9
c(29)=a-ub;
%a>=0.5
c(30)=-a+lb;

%e<=0.9
c(31)=e-ub;
%e<=0.5
c(32)=-e+lb;

%c<=0.9
c(33)=f-ub;
%c>=0.5
c(34)=-f+lb;

%gammaub=
%gammalb=1
%gamma>=1
c(44)=1-gamma;
%gamma<=1
c(45)=gamma-1;

% ceq = [];

ceq(1)=bstar-1;
ceq(2)=dstar-1;
ceq(3)=gstar-1;
% ceq(4)=gamma-1;

end
   

