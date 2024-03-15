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

            df = derivative1 - derivative0;
            % Convert the element based on the sign of the derivative
            if df > 0
                rho(i) = 0;   
            else
                rho(i) = 1;   
            end
         end
     end             
    % Return the modified rho
    result = rho;
end


%% ALL Functions
function value = objfunc(rho)

l12=rho(1); l13=rho(2); l14=rho(3);...
l15=rho(4); l16=rho(5); l17=rho(6);...
l114=rho(7); l115=rho(8);l116=rho(9);...
l117=rho(10); l118=rho(11);l119=rho(12);...
l23=rho(13);l24=rho(14);l28=rho(15);l29=rho(16);...
l210=rho(17); l220=rho(18);l221=rho(19);...
l222=rho(20); l34=rho(21);l411=rho(22);...
l412=rho(23);l413=rho(24);...
a=rho(25);bstar=rho(26);...
dstar=rho(27);e=rho(28);f=rho(29);...
gstar=rho(30);gamma=rho(31);

value =...
objfun(l12, l13, l14, l15, l16,...
l17, l114, l115, l116, l117, l118,...
l119, l23, l24, l28, l29, l210, l220,...
l221, l222, l34, l411, l412, l413,...
a,bstar,dstar,e,f,gstar,gamma);
       
end