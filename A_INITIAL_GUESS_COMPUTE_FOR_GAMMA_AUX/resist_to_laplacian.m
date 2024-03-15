function inverseMatrix = inverseWithSignExceptDiagonal(matrix)
    % matrix is the input matrix

    % Check if the input matrix is square
    [rows, cols] = size(matrix);

    % Initialize the inverse matrix
    inverseMatrix = zeros(rows, cols);

    % Compute the inverse with sign change, excluding the diagonal elements
    for i = 1:rows
        for j = 1:cols
            if i ~= j
                inverseMatrix(i, j) = -1 / matrix(i, j);
            end
        end
    % Set the diagonal element to the negative sum of the non-diagonal elements in the row
        inverseMatrix(i, i) = -sum(inverseMatrix(i, :));
    end
    
end
