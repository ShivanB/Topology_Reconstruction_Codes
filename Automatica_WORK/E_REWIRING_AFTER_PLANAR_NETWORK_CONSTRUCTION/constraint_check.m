function [tri123, tri124, kal1234_1, kal1234_2] =...
constraint_check(modifiedRho)

[L, r13star, r14star, r34star,...
    r12hat, r23hat, r24hat,...
    r12,r13,r14,r23,r24,r34] =...
    network_struct(modifiedRho(1), modifiedRho(2),...
    modifiedRho(3), modifiedRho(4), modifiedRho(5),...
    modifiedRho(6), modifiedRho(7), modifiedRho(8),...
    modifiedRho(9), modifiedRho(10), modifiedRho(11));

b12=[1;-1;0;0;0;0];
b13=[1;0;-1;0;0;0];
b14=[1;0;0;-1;0;0];
b23=[0;1;-1;0;0;0];
b24=[0;1;0;-1;0;0];
b34=[0;0;1;-1;0;0];
%%
%Triangle inequality:123
tri123=r13star-( transpose(b12)*pinv(L)*b12 +...
    transpose(b23)*pinv(L)*b23 ); 
%Triangle inequality:124
tri124=r14star-( transpose(b12)*pinv(L)*b12 +...
    transpose(b24)*pinv(L)*b24 );
%%
%Kalmansons condition: 1234
kal1234_1=( transpose(b12)*pinv(L)*b12 + r34star )-...
    (r13star + transpose(b24)*pinv(L)*b24  ); 

kal1234_2=( transpose(b23)*pinv(L)*b23 + r14star )-...
    (r13star + transpose(b24)*pinv(L)*b24  ); 
end