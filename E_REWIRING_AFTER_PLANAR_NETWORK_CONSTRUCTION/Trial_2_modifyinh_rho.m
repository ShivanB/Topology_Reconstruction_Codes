clear all
clc
optimal_rho=[0.3917
    0.3332
    0.4786
    0.1273
    0.5780
    0.3913
    0.6623
    0.3281
    0.2842
    0.0247
    0.6971];



% f_0 = @(x) objfunc_round(x); 
% 
% derivative1 = f_0(optimal_rho2)
% derivative2 = f_0(optimal_rho)
% 
% 
% 
% df_0 = derivative2 - derivative1

result = processRho_round(optimal_rho)