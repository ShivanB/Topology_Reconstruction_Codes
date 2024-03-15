clc
clear all

ordered_Adj_List = { [2], [3], [4], [5,1],...
    [6,3,2,1], [1,2,3,4] };

start_node = 1;

% paths = find_paths_with_fronds...
%     (ordered_Adj_List, start_node);

% paths = find_paths...
%     (ordered_Adj_List, start_node)




paths = find_paths_adjacency_list(ordered_Adj_List)

paths = find_paths_adjacency_list(ordered_Adj_List)



