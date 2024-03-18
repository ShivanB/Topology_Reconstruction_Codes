function adjacencyList = laplacianToAdjacencyList(L)
    % Check if the matrix is symmetric
    if ~issymmetric(L)
        error('Input matrix must be symmetric (Laplacian matrix).');
    end

    % Check if the matrix is positive semi-definite
    [~, p] = chol(L);
    if p ~= 0
        error('Input matrix must be positive semi-definite (Laplacian matrix).');
    end

    % Get the number of nodes in the graph
    numNodes = size(L, 1);

    % Initialize adjacency list cell array
    adjacencyList = cell(1, numNodes);

    % Construct adjacency list from Laplacian matrix
    for i = 1:numNodes
        neighbors = find(L(i, :) ~= 0);

        % Exclude self-loop (diagonal entry in Laplacian matrix)
        neighbors = setdiff(neighbors, i);

        adjacencyList{i} = neighbors;
    end
end
