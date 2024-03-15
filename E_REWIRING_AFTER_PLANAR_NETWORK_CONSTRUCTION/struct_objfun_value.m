function [value_optimal, value_initial] =...
    struct_objfun_value(answer,initial_rho)

value_optimal = objfunc(answer);

value_initial = objfunc(initial_rho);

end