
clc
clear all
L =[   4 -1  0 -1 -1  -1
      -1  4 -1  0  -1 -1
       0 -1  4 -1 -1 -1
      -1  0 -1  4 -1 -1
      -1 -1 -1 -1  5 -1
      -1 -1 -1 -1 -1 5];

 [traversedEdges, parents] =...
     dfsEdgeTraversal(L)
