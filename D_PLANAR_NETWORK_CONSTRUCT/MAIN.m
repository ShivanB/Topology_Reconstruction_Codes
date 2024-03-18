% Example Laplacian matrix (replace this with your Laplacian matrix)
clc
clear all
L =[ 4 -1  0 -1 -1  -1
      -1  4 -1  0  -1 -1
       0 -1  4 -1 -1 -1
      -1  0 -1  4 -1 -1
      -1 -1 -1 -1  5 -1
      -1 -1 -1 -1 -1 5];

% Compute adjacency list from Laplacian matrix
adjacencyList = laplacianToAdjacencyList(L); 

%%
% Display the adjacency list
disp('Adjacency List:');
for i = 1:numel(adjacencyList)
    fprintf('Node %d: %s\n', i, num2str(adjacencyList{i}));
end
%%
[traversedEdges, ~, ~] =...
    dfsEdgeTraversal_using_ADJLIST(adjacencyList);

disp('Traversed edges using the ADJACENCY LIST');
disp(traversedEdges);

ordered_Adj_List = {[2], [3], [4], [5,1],...
    [6,3,2,1], [1,2,3,4]};

disp('Ordered Adjacency List');
disp(transpose(ordered_Adj_List));
 

paths = find_paths_adjacency_listmodify(ordered_Adj_List);


paths=transpose(paths);

disp('Paths from Ordered Adjacency List')
disp(paths);



