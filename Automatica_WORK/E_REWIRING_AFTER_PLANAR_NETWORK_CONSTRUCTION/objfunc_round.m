function value = objfunc_round(rho)


l12=rho(1); l14=rho(2); l15=rho(3); l16=rho(4);...

l23=rho(5); l26=rho(6); l34=rho(7); l36=rho(8);...
    
l45=rho(9); l46=rho(10); l56=rho(11);


value =...
objfun_round(l12, l14, l15,...
l16, l23, l26, l34,...
l36, l45, l46, l56);
       
end