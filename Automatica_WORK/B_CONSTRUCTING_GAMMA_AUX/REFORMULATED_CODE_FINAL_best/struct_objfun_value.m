function [value_esti_boolean, value_orig_boolean,...
    value_optimal] =...
    struct_objfun_value(answer,initial_rho,opti_rho)

value_esti_boolean = objfunc(answer);

value_orig_boolean = objfunc(initial_rho);

value_optimal = objfunc(opti_rho);


% % r12hat=1.3065;
% % r23hat=1.1464;
% % r24hat=1.3207;
% 
% rdstar=[r13star;r14star;r34star];
% rdhat=[r13;r14;r34];
% 
% %%
% % Kirchhoffs Index computations
% KGamma_M = kirchhoffs(Lapval, t, r13star,r14star,r34star);
% %% objective function
% digits(4)
% value=...
% vpa((transpose((rdstar-rdhat))*(rdstar-rdhat))+...
% (KGamma_M-19.8)^2) 
%%
%
end