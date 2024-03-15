function NodeDegree=node_degree(edgeToDelete)

NodeDegrees =...
[nnz(laplacian(edgeToDelete(1), :)), nnz(laplacian(edgeToDelete(2), :))];

end