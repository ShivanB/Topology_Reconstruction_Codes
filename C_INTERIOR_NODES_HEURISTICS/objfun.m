function value =...
objfun(l12, l13, l14, l23, l34)
                    
[~, r13star, r14star, r34star,...
    r12hat, r23hat, r24hat,...
    r12,r13,r14,r23,r24,r34] =...
    network_struct(l12, l13, l14, l23, l34);

% vector of unknown variables
% rho = [l12, l13, l14, l23, l34];
%%
% Kirchhoffs Index computations
KGamma_M =kirchhoffs(l12, l13, l14, l23, l34);
%% Objective function 

Rdstar=[r12hat;r13star;r14star;...
              r23hat;r24hat;r34star];
Rd = [r12;r13;r14;r23;r24;r34];

W=diag([1,1,1,1,1,1]);

value=transpose(Rdstar-Rd)*W*(Rdstar-Rd)+...
1*(KGamma_M-19.8)^2;

% Rdstar=[0 r12hat r13star r14star
%         r12hat 0 r23hat  r24hat
%         r13star r23hat 0 r34star
%         r14star r24hat r34star 0];
%     
% Rdhat = [0 r12 r13 r14
%          r12 0 r23 r24
%          r13 r23 0 r34
%          r14 r24 r34 0]; 
%      
% value=norm(Rdstar-Rdhat,"fro")+...
% 1*(KGamma_M-19.8)^2;

end 
