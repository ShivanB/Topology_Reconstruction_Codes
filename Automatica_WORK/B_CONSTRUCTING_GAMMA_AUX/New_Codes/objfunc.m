function value = objfunc(rho)

l12=rho(1); l13=rho(2); l14=rho(3); l15=rho(4); l16=rho(5); l17=rho(6); 
l114=rho(7); l115=rho(8);l116=rho(9);l117=rho(10); l118=rho(11); 
l119=rho(12); l23=rho(13); l24=rho(14); l28=rho(15); l29=rho(16);
l210=rho(17); l220=rho(18);l221=rho(19); l222=rho(20); l34=rho(21); 
l411=rho(22); l412=rho(23);l413=rho(24);

value =...
objfun(l12, l13, l14, l15, l16, l17,...
l114, l115, l116,l117, l118, l119,...
l23, l24, l28, l29, l210, l220,...
l221, l222, l34, l411, l412, l413);

end 

