function [traversedEdges, parents] = dfsEdgeTraversal(L)

  numNodes = size(L, 1);
  visitedEdges = false(numNodes);  % Use visitedEdges for both directions
   parents = cell(1, numNodes); % Cell array to store parents dynamically

  traversedEdges = [];

  % --- Depth-First Search with Backtracking & Edge Direction Check ---
  visited = false(1, numNodes);  % Track visited nodes (not just edges)
  for node = 1:numNodes
    if ~visited(node)
      dfsEdgeVisit(node);
    end
  end

  % --- Display Results --- 
  disp('Edges Traversed During DFS:');
  for i = 1:size(traversedEdges, 1)
    fprintf('Edge: (%d, %d)\n', traversedEdges(i, 1), traversedEdges(i, 2));
  end

  % --- Recursive DFS Edge Traversal Helper Function ---
  function dfsEdgeVisit(node)
    visited(node) = true;  % Mark node as visited

    neighbors = find(L(node, :) ~= 0);
    neighbors = setdiff(neighbors, node); % Exclude diagonal element

    for neighbor = neighbors 
      if ~visited(neighbor)  % Explore unvisited nodes
        visitedEdges(node, neighbor) = true; % Mark the forward edge
        traversedEdges = [traversedEdges; [node, neighbor]];
        parents{neighbor} = node;  % Store the parent
        dfsEdgeVisit(neighbor); 
      elseif ~visitedEdges(neighbor, node) % Edge to visited node with reverse direction 
        visitedEdges(neighbor, node) = true;  % Mark the reverse direction 
        traversedEdges = [traversedEdges; [node, neighbor]];        
      end
    end
  end
end


