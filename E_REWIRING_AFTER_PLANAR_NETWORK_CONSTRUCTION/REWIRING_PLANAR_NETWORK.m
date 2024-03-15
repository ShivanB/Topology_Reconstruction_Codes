clear all
clc
format short
%%
%Original edge conductances  
orig_l12=1/2.2;
orig_l14=1/3.1;
orig_l15=1/2.3;
orig_l16=0;
orig_l23=1/1.2;
orig_l26=1/2.5;
orig_l34=1/1.6;
orig_l36=1/3.4;
orig_l45=1/2.5;
orig_l46=0;
orig_l56=1/1.6;

orig_rho =...
[orig_l12;orig_l14;orig_l15;...
 orig_l16;orig_l23;orig_l26;...
 orig_l34;orig_l36;orig_l45;...
 orig_l46;orig_l56;1;1;1;1;...
 1;1;1];
%%
% Initial condition  
% l120=1/3.1;
% l140=1/1;
% l150=1/1;%1/1;
% l160=1/1;%1/1;%0
% l230=1/2.125;
% l260=1/1;
% l340=1/2.166;
% l360=1/1;
% l450=1/1;
% l460=0;%1/1;%0
% l560=0.25;%1/1;

resultx=transpose([ 0.3905
    0.3228
    0.4601
    0.2500
    0.5930
    0.3679
    0.7008
    0.2855
    0.3277
         0
    0.7382]);

a0=0.5;
bstar0=1;
dstar0=1;
e0=0.5;
f0=0.5;
gstar0=1;

kalman_gain0=0.67;

x0=[resultx,a0,bstar0,dstar0,e0,f0,gstar0,...
    kalman_gain0];

% x0 =[l120,l140,l150,l160,l230,...
%     l260,l340,l360,l450,l460,l560,...
%     a0,bstar0,dstar0,e0,f0,gstar0,...
%     kalman_gain0];

%initial_rho=x0;
initial_rho=transpose(x0);
%%
for i=1:20

A = []; 
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];

options =...
optimoptions('fmincon','Algorithm',...
'sqp','Display','iter-detailed','ObjectiveLimit',0.18);

[x,fval,exitflag] =...
fmincon( @(x)objfun(x(1),x(2),x(3),x(4),x(5),...
x(6),x(7),x(8),x(9),x(10),x(11),...
x(12),x(13),x(14),x(15),x(16),x(17),...
x(18)),...
x0,A,b,Aeq,beq,lb,ub,...
@(x)pol_cons(x(1),x(2),x(3),x(4),x(5),...
x(6),x(7),x(8),x(9),x(10),x(11),...
x(12),x(13),x(14),x(15),x(16),x(17),...
x(18)),...
options );

digits(3)
disp(transpose(vpa(x)))

% origx0=x;
% 
% conduct =...
%     replaceGreaterThan4(origx0)
% 
% resistance = 1./conduct

x0=x;
end

rho=transpose(x);

%%
optimalVector = rho;

% Find indices of non-zero elements
nonZeroIndices = find(optimalVector ~= 0);

% Initialize a new vector with zeros
inverseNonZeroVector = zeros(size(optimalVector));

% Take the inverse of non-zero elements
inverseNonZeroVector(nonZeroIndices) = 1 ./ optimalVector(nonZeroIndices);

disp('Edge Conductance:');
disp(optimalVector(1:11));
disp('Original Edge Conductance')
disp(orig_rho(1:11))
disp('Edge Resistance:');
disp(vpa(inverseNonZeroVector(1:11)));
%%

[tri123, tri124, kal1234_1, kal1234_2] =...
   constraint_check(rho)

[L, r13star, r14star, r34star,...
    r12hat, r23hat, r24hat,...
    r12,r13,r14,r15,r16,r23,r24,r25,r26,r34,...
    r35,r36,r45,r46,r56] =...
    network_struct(rho(1), rho(2),...
    rho(3), rho(4), rho(5),rho(6), rho(7),...
    rho(8), rho(9), rho(10), rho(11));

Rd_esti = [r12 r12hat;r13 r13star;...
r14 r14star;r23 r23hat;r24 r24hat;r34 r34star]

Rd_esti1 = [ r12,r13,r14,r15,r16,r23,r24,r25,r26,r34,...
    r35,r36,r45,r46,r56 ];
%%
[value_optimal, value_initial, value_orig] =...
Check(initial_rho, x, orig_rho)
%% ALL FUNCTIONS
function [c,ceq] =...
pol_cons(l12, l14, l15,...
    l16, l23, l26, l34,...
    l36, l45, l46, l56,...
    a,bstar,dstar,e,f,gstar,...
    kalman_gain)

[L, r13star, r14star, r34star,...
    r12hat, r23hat, r24hat,...
    r12,r13,r14,r15,r16,r23,r24,r25,r26,r34,...
    r35,r36,r45,r46,r56] =...
    network_struct(l12, l14, l15,...
    l16, l23, l26, l34, l36, l45, l46, l56);

gamma_min=0;
c(1)=gamma_min-l12;
c(2)=gamma_min-l14;
c(3)=gamma_min-l15;
c(4)=gamma_min-l16;
c(5)=gamma_min-l23;
c(6)=gamma_min-l26;
c(7)=gamma_min-l34;
c(8)=gamma_min-l36;
c(9)=gamma_min-l45;
c(10)=gamma_min-l46;
c(11)=gamma_min-l56;
%%
%Triangle inequality:123
c(12)=r13star-( r12 + r23 ); 
%Triangle inequality:124
c(13)=r14star-( r12 + r24 ); 
%%
%Kalmansons condition: 1234
c(14)=( r12 + r34star )-( r13star + r24 );       
c(15)=( r23 + r14star )-( r13star + r24 ); 
%%
gamma_max=1;
c(16)=l12-gamma_max;
c(17)=l14-gamma_max;
c(18)=l15-gamma_max;
c(19)=l16-gamma_max;
c(20)=l23-gamma_max;
c(21)=l26-gamma_max;
c(22)=l34-gamma_max;
c(23)=l36-gamma_max;
c(24)=l45-gamma_max;
c(25)=l46-gamma_max;
c(26)=l56-gamma_max;

lowbound=0.7;
upbound=0.9;
c(27)=a-upbound;
c(28)=e-upbound;
c(29)=f-upbound;

c(30)=lowbound-a;
c(31)=lowbound-e;
c(32)=lowbound-f;

kalman_up=1;
kalman_down=1;
c(33)=kalman_gain-kalman_up;
c(34)=kalman_down-kalman_gain;

ceq(1)=bstar-1;
ceq(2)=dstar-1;
ceq(3)=gstar-1;
%ceq=[];
end
   

