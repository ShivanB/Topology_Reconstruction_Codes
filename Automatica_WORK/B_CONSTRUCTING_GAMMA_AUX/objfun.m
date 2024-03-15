function value =...
    objfun(l12, l13, l14, l15, l16, l17, l114, l115, l116,...
           l117, l118, l119, l23, l24, l28, l29, l210, l220,...
           l221, l222, l34, l411, l412, l413)
                    
[L,r13star,r14star,r34star]=...
    network_struct(l12, l13, l14, l15, l16, l17, l114, l115, l116,...
                   l117, l118, l119, l23, l24, l28, l29, l210, l220,...
                   l221, l222, l34, l411, l412, l413);
r12hat=1.3065;
r23hat=1.1464;
r24hat=1.3207;
% vector of unknown variables
rho = [l12, l13, l14, l15, l16, l17, l114, l115, l116,...
       l117, l118, l119, l23, l24, l28, l29, l210, l220,...
       l221, l222, l34, l411, l412, l413];
%%
Lapval=L;

t=det(Lapval([2:end],[2:end]));
r12=det(Lapval([3:end],[3:end]))/t;
r13=det(Lapval([2,4:end],[2,4:end]))/t;
r14=det(Lapval([2,3,5:end],[2,3,5:end]))/t;
r23=det(Lapval([1,4:end],[1,4:end]))/t;
r24=det(Lapval([1,3,5:end],[1,3,5:end]))/t;
r34=det(Lapval([1,2,5:end],[1,2,5:end]))/t;


rdstar=[r12hat; r13star; r14star; r23hat; r24hat; r34star];
rdhat=[r12;r13;r14;r23;r24;r34];
%%
% Kirchhoffs Index computations
KGamma_M =...
    kirchhoffs(Lapval, t, r13star,r14star,r34star);
%% Objective function 
% Objective function has no one norm function.
value=...
    (transpose((rdstar-rdhat))*(rdstar-rdhat)) +...
    (KGamma_M-19.8)^2+1.1*norm(rho,1); 
%+2*norm(rho,1);
end 
