function paths = find_paths_adjacency_list(adj_list)
    num_nodes = length(adj_list);
    visited = false(num_nodes, 1); 
    paths = {} % Cell array to store paths

    % Recursive depth-first search function
    function explore(current_node, current_path)
        visited(current_node) = true
        current_path = [current_path, current_node]

        for neighbor = adj_list{current_node}
            if ~visited(neighbor) 
                % Tree arc
                explore(neighbor, current_path) 
            else
                % Back edge (frond) 
                current_path = [current_path, neighbor]
                paths = [paths, current_path] 

                % Start a new search from the parent of the back edge node
                parent_node = current_path(end-1) 

                % Check if parent is fully explored and find unvisited neighbor
                if ~visited(parent_node)
                   for neighbor = adj_list{parent_node}
                       if ~visited(neighbor)
                          explore(neighbor, [parent_node, neighbor])
                          return; % Stop further exploration from parent
                       end
                   end
                end
            end
        end
    end

    % Start the search from node 1
    explore(1, [])

end
