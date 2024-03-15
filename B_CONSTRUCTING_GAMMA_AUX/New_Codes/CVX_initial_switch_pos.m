clc
clear all

cvx_begin

    variables l12 l13 l14 l15 l16 l17 l114 l115 l116...
                        l117 l118 l119 l23 l24 l28 l29 l210 l220...
                        l221 l222 l34 l411 l412 l413
%%
[L,r13star,r14star,r34star]=network_struct(l12, l13, l14, l15, l16, l17, l114, l115, l116,...
                        l117, l118, l119, l23, l24, l28, l29, l210, l220,...
                        l221, l222, l34, l411, l412, l413);

% vector of unknown variables
rho = [l12, l13, l14, l15, l16, l17, l114, l115, l116,...
     l117, l118, l119, l23, l24, l28, l29, l210, l220,...
                   l221, l222, l34, l411, l412, l413];

Lapval=L;

t=det (Lapval([2:end],[2:end]));
r13=det_rootn (Lapval([2,4:end],[2,4:end]))/t;
r14=det (Lapval([2,3,5:end],[2,3,5:end]))/t;
r34=det (Lapval([1,2,5:end],[1,2,5:end]))/t;

rdstar=[ r13star; r14star;  r34star];
rdhat=[r13;r14;r34];


minimize( (transpose((rdstar-rdhat))*(rdstar-rdhat)) + (KGamma_M-19.8)^2 + 1*norm(rho,1) )

cvx_end