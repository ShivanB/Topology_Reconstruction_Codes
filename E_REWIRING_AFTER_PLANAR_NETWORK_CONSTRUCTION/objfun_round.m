function value =...
objfun_round(l12, l14, l15,...
l16, l23, l26, l34,...
l36, l45, l46, l56)
                    
[~, r13star, r14star, r34star,...
    r12hat, r23hat, r24hat,...
    r12,r13,r14,r23,r24,r34] =...
    network_struct(l12, l14, l15,...
    l16, l23, l26, l34, l36, l45, l46, l56);

% vector of unknown variables
rho = [l12, l14, l15, l16, l23,...
    l26, l34, l36, l45, l46, l56];
%%
% Kirchhoffs Index computations
KGamma_M =...
kirchhoffs(l12, l14, l15, l16,...
l23, l26, l34, l36, l45, l46, l56);
%% Objective function 
Rdstar=[r12hat;r13star;r14star;...
              r23hat;r24hat;r34star];
Rd = [r12;r13;r14;r23;r24;r34];


value=...
transpose(Rdstar-Rd)*(Rdstar-Rd)+(KGamma_M-19.7719)^2;

end 