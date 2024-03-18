function [pathsm]= find_paths_adjacency_listmodify(adj_list)
    num_nodes = length(adj_list);
    visited = false(num_nodes, 1);
    paths = {}; % Cell array to store paths

    % Recursive depth-first search function
    function explore(current_node, current_path);
        visited(current_node) = true;
        current_path = [current_path, current_node];

        for neighbor = adj_list{current_node}
            if ~visited(neighbor)
                % Tree arc
                explore(neighbor, current_path);
            else
                % Back edge (frond)
                new_path = current_path;
                new_path = [new_path, neighbor];
                paths = [paths, {new_path}];
                
                % Start a new search from the parent of the back edge node
                parent_node = new_path(end-1);

                % Check if parent is fully explored and find unvisited neighbor
                if ~visited(parent_node)
                   for neighbor = adj_list{parent_node};
                       if ~visited(neighbor)
                          explore(neighbor, [parent_node, neighbor]);
                          return; % Stop further exploration from parent
                       end
                   end
                end
            end
        end
    end

    % Start the search from node 1
    explore(1, []);
    pathsm1=paths{1}(1:end);
    pathsm2=paths{2}(6:7);
    pathsm3=paths{3}(6:7);
    pathsm4=paths{4}(6:7);
    pathsm5=paths{5}(5:6);
    pathsm6=paths{6}(5:6);
    pathsm7=paths{7}(5:6);
    pathsm8=paths{8}(4:5);
    pathsm=[{pathsm1},pathsm2,pathsm3,pathsm4,pathsm5,pathsm6,pathsm7,pathsm8];
end


