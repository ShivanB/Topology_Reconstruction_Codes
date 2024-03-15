function [maxValue, maxIndex] =...
    findMaxAbsoluteValue(matrix)

    % Find the maximum absolute value
    [maxValue, linearIndex] = max(abs(matrix(:)));

    % Convert linear index to matrix indices
    [row, col] = ind2sub(size(matrix), linearIndex);


    % Return the indices
    maxIndex = [row, col];
end