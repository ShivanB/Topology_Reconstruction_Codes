function value = objfunc(rho)

l12=rho(1); l13=rho(2); l14=rho(3);...
l23=rho(4);l34=rho(5);

value =...
objfun(l12, l13, l14, l23, l34);
       
end