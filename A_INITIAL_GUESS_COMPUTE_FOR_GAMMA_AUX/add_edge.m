function updated_L = add_edge(L, node1, node2)
    % L is the Laplacian matrix
    % node1 and node2 specify the nodes to connect with a 1-ohm resistor
    
    % Find the corresponding indices in the Laplacian matrix
    index1 = node1;
    index2 = node2;
    
    % Add the edge by setting its conductance to -1 (assuming 1 ohm resistance)
    L(index1, index2) = L(index1, index2) - 1;
    L(index2, index1) = L(index2, index1) - 1;
    
    % Update the diagonal elements to maintain the balance
    L(index1, index1) = L(index1, index1) + 1;
    L(index2, index2) = L(index2, index2) + 1;
    
    % Return the updated Laplacian matrix
    updated_L = L;
end
