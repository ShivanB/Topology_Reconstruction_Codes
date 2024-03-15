function updated_L = decrease_edge_resistance(L, node1, node2)
    % L is the original Laplacian matrix
    % node1 and node2 specify the nodes connected by the edge
    
    % Find the corresponding indices in the Laplacian matrix
    index1 = node1;
    index2 = node2;
    
    % Update the Laplacian matrix by decreasing the conductance of the edge
    L(index1, index2) = L(index1, index2) + 1;
    L(index2, index1) = L(index2, index1) + 1;
    
    % Update the diagonal elements to maintain the balance
    L(index1, index1) = L(index1, index1) - 1;
    L(index2, index2) = L(index2, index2) - 1;
    
    % Return the updated Laplacian matrix
    updated_L = L;
end