%% All Functions
function result = processRho_OLD(rho)
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
                rho_aux=rho(i);
                rho(i) = 0;
            else
                rho_aux=rho(i);
                rho(i) = 1;   
            end
         end
     end             
    % Return the modified rho
    result = rho;
end
%% ALL Functions
