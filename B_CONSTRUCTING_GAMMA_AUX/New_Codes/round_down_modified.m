clc
rho=[ 0
   -0.0000
    0.0277
    0.0481
    0.0312
    0.0001
    0.8408
    0.8992
    0.2579
    0.9854
    0.5829
    0.0011
    0.0026
    0.0116
    0.1405
    0.0006
    0.0017
    0.0083
    0.0032
    0.0149
    0.6490
    0.0000
    0.0245
    0.0238]; 

Opti_rho=transpose(rho);
%%
% x0=[0, 0, 0, 0, 1, 0,...
%       0, 0, 1, 1, 0, 0,... 
%       0, 0, 0, 0, 1, 0,...
%       0, 0, 0, 0, 0, 1];

x0 = [0, 0, 0, 1, 0, 0,...
         0, 1, 0, 1, 0, 0,... 
         0, 0, 0, 0, 1, 0,...
         0, 0, 0, 0, 0, 1];

orig_rho=(x0);
%%
% Example vector
modifiedRho = transpose(processRho(rho));
transpose(modifiedRho)
l=transpose({'l12', 'l13', 'l14', 'l15', 'l16', 'l17', 'l114', 'l115', 'l116',...
'l117', 'l118', 'l119', 'l23', 'l24', 'l28', 'l29', 'l210', 'l220',...
'l221', 'l222', 'l34', 'l411', 'l412', 'l413'});
   
disp('Original_rho Rounded_rho:');
for i=1:length(l)
fprintf('%s %d %d\n',l{i},vpa(orig_rho(i)),vpa(modifiedRho(i)));
end

%% All Functions
function result = processRho(rho)
    % Objective function f_0
    f_0 = @(x) objfunc(x); 

    % Iterate over each element of rho
    for i = 1:length(rho)
        % Check if the element is between 0 and 1
        if rho(i) > 0 && rho(i) < 1
            % Calculate the derivative of f_0 at the current element
            rho_temp1 = rho;
            rho_temp1(i) = 1;
            derivative1 = f_0(rho_temp1);

            rho_temp0 = rho;
            rho_temp0(i) = 0;
            derivative0 = f_0(rho_temp0);

            df_0 = derivative1 - derivative0

            % Convert the element based on the sign of the derivative
            if df_0 > 0
                rho_aux=rho(i);
                rho(i) = 0;
                [tri123, tri124, kal1234_1, kal1234_2] = constraint_check(rho);
                if(tri123<0 && tri124<0 && kal1234_1<0 && kal1234_2<0)
                    rho(i)=0;
                else
                    rho(i)=rho_aux;    
                end
            else
                rho(i) = 1;
                [tri123, tri124, kal1234_1, kal1234_2] = constraint_check(rho);
                if(tri123<0 && tri124<0 && kal1234_1<0 && kal1234_2<0)
                    rho(i)=0;
                else
                    rho(i)=rho_aux;    
                end
            end
         end             
    end
    % Return the modified rho
    result = rho;
end
%%
function value = objfunc(rho)

l12=rho(1); l13=rho(2); l14=rho(3); l15=rho(4); l16=rho(5); l17=rho(6); 
l114=rho(7); l115=rho(8);l116=rho(9);l117=rho(10); l118=rho(11); 
l119=rho(12); l23=rho(13); l24=rho(14); l28=rho(15); l29=rho(16);
l210=rho(17); l220=rho(18);l221=rho(19); l222=rho(20); l34=rho(21); 
l411=rho(22); l412=rho(23);l413=rho(24);

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

% rdstar=[r12hat; r13star; r14star; r23hat; r24hat; r34star];
% rdhat=[r12;r13;r14;r23;r24;r34];

rdstar=[r13star; r14star; r34star];
rdhat=[r13;r14;r34];
%%
% Kirchhoffs Index computations
KGamma_M =...
kirchhoffs(Lapval, t, r13star,r14star,r34star);
%% objective function
value=(transpose((rdstar-rdhat))*(rdstar-rdhat))...
                                    +1*(KGamma_M-19.8)^2;
end 

