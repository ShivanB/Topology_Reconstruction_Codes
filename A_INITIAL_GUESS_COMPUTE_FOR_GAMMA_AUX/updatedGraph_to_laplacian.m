function updatedCircuit =...
    updatedGraph_to_laplacian(updatedGraph,~,~)
    
[m, n] = size(updatedGraph);

% Create a mask for diagonal elements
diagonalMask = eye(m, n);

% Invert all elements except for the diagonal elements
updatedCircuit = 1 ./ updatedGraph .* (1 - diagonalMask) + diagonalMask;
for i=1:4
    for j=1:4
        if (i~=j && updatedCircuit(i,j)==Inf)
        updatedCircuit(i,j)=0;
        end
    end
end
for i=1:4
   updatedCircuit(i,i)=-(sum(updatedCircuit(i,:))-updatedCircuit(i,i));
end

end