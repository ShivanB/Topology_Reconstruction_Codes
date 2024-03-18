function [traversedEdges, treeArcs, backEdges] = dfsEdgeTraversal_using_ADJLIST(adjacencyList)
    numNodes = length(adjacencyList);

    % Initialize visited array for edges
    visitedEdges = false(numNodes);

    % Initialize arrays to store traversed edges, tree arcs, and back edges
    traversedEdges = [];
    treeArcs = [];
    backEdges = [];

    % Perform depth-first search for edge traversal
    for node = 1:numNodes
        if ~any(visitedEdges(node, :))
            dfsEdgeVisit(node, 0); % Initial call with a dummy parent (0)
        end
    end

    % Recursive function for DFS edge visit
    function dfsEdgeVisit(currentNode, parent)
        neighbors = adjacencyList{currentNode};

        for i = 1:length(neighbors)
            nextNode = neighbors(i);
            if ~visitedEdges(currentNode, nextNode)
                visitedEdges(currentNode, nextNode) = true;
                visitedEdges(nextNode, currentNode) = true;

                traversedEdges = [traversedEdges; [currentNode, nextNode]];

                if parent > 0
                    % Check if the edge is a tree arc or a back edge
                    if currentNode < nextNode
                        treeArcs = [treeArcs; [currentNode, nextNode]];
                    else
                        backEdges = [backEdges; [currentNode, nextNode]];
                    end
                end

                dfsEdgeVisit(nextNode, currentNode);
            end
        end
    end
end
