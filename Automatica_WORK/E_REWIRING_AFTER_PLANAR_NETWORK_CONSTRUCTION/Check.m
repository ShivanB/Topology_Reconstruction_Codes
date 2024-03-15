function [value_optimal, value_initial, value_orig] =...
    Check(initial_rho,opti_rho,orig_rho)



value_initial = objfunc(initial_rho);

value_optimal = objfunc(opti_rho);

value_orig = objfunc(orig_rho);

end