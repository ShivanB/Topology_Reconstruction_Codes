% Define your vector
function conduct = replaceGreaterThan4(x0)
% Calculate the inverse of each element
inverse_x0 = 1 ./ x0;

% Check for elements greater than 4 and replace with infinity
inverse_x0(inverse_x0 > 4) = Inf;

conduct = 1 ./ inverse_x0;

end