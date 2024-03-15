function [updatedLaplacian, deletedNodesDegrees] =...
    deleteEdge(laplacian, edgeToDelete)
    % edgeToDelete is a pair of vertices representing the edge to delete

    % Compute the degree of the nodes that were
    %incident to the deleted edge

        laplacian(edgeToDelete(1), edgeToDelete(2)) = 0;
        laplacian(edgeToDelete(2), edgeToDelete(1)) = 0;

    % Update the Laplacian matrix by adjusting the diagonal elements
        updatedLaplacian = laplacian;

        updatedLaplacian(edgeToDelete(1), edgeToDelete(1)) =...
        updatedLaplacian(edgeToDelete(1), edgeToDelete(1)) - 1;

        updatedLaplacian(edgeToDelete(2), edgeToDelete(2)) =...
        updatedLaplacian(edgeToDelete(2), edgeToDelete(2)) - 1;

        % Update the set of deleted edges
        deletedEdgesSet = [deletedEdgesSet; edgeToDelete];

        deletedNodesDegrees =...
        [nnz(updatedLaplacian(edgeToDelete(1), :))-1,...
        nnz(updatedLaplacian(edgeToDelete(2), :))-1];

end


