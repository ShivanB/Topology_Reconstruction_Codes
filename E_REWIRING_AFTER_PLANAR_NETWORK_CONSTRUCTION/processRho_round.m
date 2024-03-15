function result = processRho_round(rho)
    % Objective function f_0
    f_0 = @(x) objfunc_round(x); 

    % Iterate over each element of rho
    for i = 1:length(rho(1:end))
        % Check if the element is between 0 and 1
  i
        if rho(i) <= 0.25  && rho(i) >=  0
            % Calculate the derivative of f_0 at the current element
            rho_temp1 = rho;
            rho_temp1(i) = 0
            derivative1 = f_0(rho_temp1)

            rho_temp2 = rho;
            rho_temp2(i) = 0.25
            derivative2 = f_0(rho_temp2)

            df_0 = derivative2 - derivative1

            % Update rho(i) based on the sign of df_0
            if df_0 > 0
                % Update rho(i) to 0
                rho_aux=rho(i)
                rho(i) = 0

                % Recalculate additional constraints based on updated rho
                [tri123, tri124, kal1234_1, kal1234_2]...
                    = constraint_check(rho)

                % Check if all additional constraints are satisfied
                if ( tri123 < 0 && tri124 < 0 &&... 
                        kal1234_1 < 0 && kal1234_2 < 0 )
                    % Additional constraints are satisfied; rho(i) remains 0
                else
                    % Additional constraints not satisfied; revert rho(i) to the original value
                    rho(i) = 0.25
                end
            else
                % Update rho(i) to 1 when df_0 < 0
                rho_aux=rho(i)
                rho(i) = 0.25

                % Recalculate additional constraints based on updated rho
                [tri123, tri124, kal1234_1, kal1234_2]...
                    = constraint_check(rho);

                % Check if all additional constraints are satisfied
                if (tri123 < 0 && tri124 < 0 &&...
                        kal1234_1 < 0 && kal1234_2 < 0)
                    % Additional constraints are satisfied; rho(i) remains 1
                else
                    % Additional constraints not satisfied; revert rho(i) to the original value
                    rho(i) = 0
                end
            end
        end
    end
    % Return the modified rho
    result = rho;
end
