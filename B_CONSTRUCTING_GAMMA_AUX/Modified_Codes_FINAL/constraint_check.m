function [tri123, tri124, kal1234_1, kal1234_2] = constraint_check(modifiedRho)
[L,r13star,r14star,r34star]=...
network_struct(modifiedRho(1), modifiedRho(2), modifiedRho(3),...
modifiedRho(4), modifiedRho(5), modifiedRho(6), modifiedRho(7),...
modifiedRho(8), modifiedRho(9), modifiedRho(10), modifiedRho(11),...
modifiedRho(12), modifiedRho(13), modifiedRho(14), modifiedRho(15),...
modifiedRho(16), modifiedRho(17), modifiedRho(18), modifiedRho(19),...
modifiedRho(20), modifiedRho(21), modifiedRho(22), modifiedRho(23),...
modifiedRho(24));

t=det(L(2:end,2:end));
%%
%Triangle inequality:123
tri123=(r13star*t)-( det(L(3:end,3:end)) +...
                                det(L([1,4:end],[1,4:end])) ) ;
%Triangle inequality:124
tri124=(r14star*t)-( det(L(3:end,3:end)) +...
                                det(L([1,3,5:end],[1,3,5:end])) );
%%
%Kalmansons condition: 1234
kal1234_1=( det(L(3:end,3:end)) + (r34star*t) ) -...
                    ( (r13star*t) + det(L([1,3,5:end],[1,3,5:end])) )   ; 

kal1234_2=( det(L([1,4:end],[1,4:end])) + (r14star*t) ) -...
                    ( (r13star*t) + det(L([1,3,5:end],[1,3,5:end])) ) ;
end