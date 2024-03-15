function [value_optimal, value_initial] =...
    Check(initial_rho,opti_rho)



value_initial = objfunc(initial_rho);

value_optimal = objfunc(opti_rho);


end