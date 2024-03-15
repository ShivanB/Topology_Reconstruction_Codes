function updatedLaplacian =...
    increaseEdgeWeight(laplacian, vertex1, vertex2)
    
    updatedLaplacian = laplacian;
    
    updatedLaplacian(vertex1, vertex2) =...
        (updatedLaplacian(vertex1, vertex2) - 1);

    updatedLaplacian(vertex2, vertex1) =...
        (updatedLaplacian(vertex2, vertex1) - 1);
    
    updatedLaplacian(vertex1, vertex1) =...
        -(sum(updatedLaplacian(vertex1,:))-updatedLaplacian(vertex1,vertex1));
    
    updatedLaplacian(vertex2, vertex2) =...
        -(sum(updatedLaplacian(vertex2,:))-updatedLaplacian(vertex2,vertex2));
    
end