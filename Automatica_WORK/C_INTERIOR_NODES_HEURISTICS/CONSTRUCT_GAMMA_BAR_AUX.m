
clear all
clc
format short
%%
% An excellent initial condition
%   l12 l13 l14 l23  l34
x0 =[1/3.1,  1/4,  1/2.5,  1/2.125,  1/2.166];
% x0=[8.5742 4.2000 1.7876 6.7358 1.2311];
initial_rho=x0;
%%
for i=1:5

A = []; 
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];

options = optimoptions('fmincon','Algorithm',...
'sqp','Display','iter');

[x,fval,exitflag] =...
fmincon(@(x)objfun(x(1),x(2),x(3),x(4),x(5)),...
x0,A,b,Aeq,beq,lb,ub,...
@(x)pol_cons(x(1),x(2),x(3),x(4),x(5)),...
options);

digits(3)
disp(transpose(x))
x0=x;
end

rho=transpose(x);
edge_resistance = x.^(-1)

[tri123, tri124, kal1234_1, kal1234_2] =...
   constraint_check(rho)

[L, r13star, r14star, r34star,...
    r12hat, r23hat, r24hat,...
    r12,r13,r14,r23,r24,r34] =...
    network_struct(rho(1), rho(2),...
    rho(3), rho(4), rho(5));
Rdesti = [r12 r12hat;r13 r13star;...
r14 r14star;r23 r23hat;r24 r24hat;r34 r34star]
%%
%Compute resistance distance matrix

% n=size(L);
% J=ones(n(1));
% X=inv( L + ((1/n(1))*J) )-((1/n(1))*J);
% Xbar=diag([X(1),X(2),X(3),X(4)]);
% Rdesti= J*Xbar + Xbar*J - 2*X
%%
[value_optimal, value_initial] =...
    Check(initial_rho,x)
% 
% [Resist_Dist_Matrix, Resist_Dist_Matrix_4node]=...
%     compute_Rd(modifiedRho);
%%
% Lnet=network_structure(modifiedRho);

%% ALL FUNCTIONS
function [c,ceq] =...
pol_cons(l12, l13, l14, l23, l34)

c(1)=-l12;
c(2)=-l13;
c(3)=-l14;
c(4)=-l23;
c(5)=-l34;

[L, r13star, r14star, r34star,...
r12hat, r23hat, r24hat,...
r12,r13,r14,r23,r24,r34] =...
network_struct(l12, l13, l14, l23, l34);
%%
%Triangle inequality:123
c(6)=r13star-( r12 + r23 ); 
%Triangle inequality:124
c(7)=r14star-( r12 + r24 ); 
%%
%Kalmansons condition: 1234
c(8)=( r12 + r34star )-( r13star + r24 );       
c(9)=( r23 + r14star )-( r13star + r24 ); 
%%

% c(10)=-r12;
% c(11)=-r13;
% c(12)=-r14;
% c(13)=-r23;
% c(14)=-r24;
% c(15)=-r34;

%%
ceq=[];

end
   

