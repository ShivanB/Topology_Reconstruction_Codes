% nb=4
% maximal planar graph=6 edges
format short
clc
clear all
%%
% initial edge resistance values  
r(1,2)=1;r(1,3)=1;r(1,4)=1;

r(2,1)=r(1,2);r(2,2)=0;r(2,3)=1;r(2,4)=1;

r(3,1)=r(1,3);r(3,2)=r(2,3);r(3,3)=0;r(3,4)=1;

r(4,1)=r(1,4);r(4,2)=r(2,4);r(4,3)=r(3,4);r(4,4)=0;
%%
% Resistance distance matrix
Rdstar=[0    1.3065 1.4984 1.351    
            1.3065   0   1.1464 1.3207    
            1.4984  1.1464   0  1.0795    
            1.351   1.3207 1.0795,   0]; 
%%
l12= -1/r(1,2);l13= -1/r(1,3);l14= -1/r(1,4);
l11=-(l12+l13+l14);

l23= -1/r(2,3);l24= -1/r(2,4);
l22=-(l12+l23+l24);

l34=-1/r(3,4);
l33=-(l13+l23+l34);

l44=-(l14+l24+l34);

% Initial Laplacian matrix 
L(:,:,1)=[ l11 l12 l13 l14
                l12 l22 l23 l24
                l13 l23 l33 l34
                l14 l24 l34 l44]; 

updatedCircuit(:,:,1)=L(:,:,1);   

for k=1:7


    rd(:,:,k)=updCir_to_resistdist(updatedCircuit(:,:,k));
    disp('resistance distance')
    disp(rd(:,:,k))
    error_rd(:,:,k)=rd(:,:,k)-Rdstar;
    disp('error resistance distance')
    disp(error_rd(:,:,k))
    [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k))
    deletedEdgesSet={};

%%
%operation OP1: Edge deletion
if (error_rd(maxIndex(1),maxIndex(2),k)<0 &&...
        -L(maxIndex(1),maxIndex(2),k)~=0)
    disp('Operation OP1: Edge Deletion Operation')

     edgeToDelete=[maxIndex(1),maxIndex(2)]

    [updatedLaplacianop1, deletedNodesDegrees] =...
    deleteEdge(L(:,:,k), edgeToDelete)
    
        %degree conditions check
     if (deletedNodesDegrees(1) > 1 &&...
             deletedNodesDegrees(2) > 1)

            Lop1=updatedLaplacianop1;
            updatedCircuitop1 = updatedGraph_to_laplacian...
                (updatedLaplacianop1, maxIndex(1), maxIndex(2))

            rdop1=updCir_to_resistdist(updatedCircuitop1);
            error_rdop1=rdop1-Rdstar

        if (abs(error_rdop1(maxIndex(1), maxIndex(2)))<...
                abs(error_rd(maxIndex(1), maxIndex(2),k)))
             disp('go to OP2')
            else
                disp('Invalid operation')
                updatedLaplacianop1= L(:,:,k);
                Lop1=L(:,:,k);

                updatedCircuitop1 = updatedGraph_to_laplacian...
                    (updatedLaplacianop1, maxIndex(1), maxIndex(2));

                rdop1=updCir_to_resistdist(updatedCircuitop1);
                error_rdop1=rdop1-Rdstar;
                disp('go to OP2')
        end
    else
    updatedLaplacianop1= L(:,:,k);
    Lop1=L(:,:,k);

    updatedCircuitop1 = updatedGraph_to_laplacian...
        (updatedLaplacianop1, maxIndex(1), maxIndex(2));

    rdop1=updCir_to_resistdist(updatedCircuitop1);
    error_rdop1=rdop1-Rdstar;
    disp('go to OP2')

     end
end
%%
%operation OP2: Increase edge resistance by 1 ohm
disp('Operation OP2: Increase the edge resistance by 1 ohm')
if(error_rd(maxIndex(1),maxIndex(2),k)<0 &&...
        -L(maxIndex(1),maxIndex(2),k)<=4)
    
    updatedGraph = increaseEdgeWeight...
        (L(:,:,k), maxIndex(1), maxIndex(2));

    Lop2=updatedGraph;
    disp(updatedGraph);

    updatedCircuitop2= updatedGraph_to_laplacian...
        (Lop2, maxIndex(1), maxIndex(2))

    disp(updatedCircuitop2);
    rdop2=updCir_to_resistdist(updatedCircuitop2);
    error_rdop2=rdop2-Rdstar
    %%
    % OPERATION-1 AND OPERATION-2 ARE WORKING PERFECTLY
    %%
    %ALGORITHM-4: Choosing an operation among OP1 and OP2

    if ( abs(error_rdop1(maxIndex(1), maxIndex(2))) < abs(error_rd(maxIndex(1), maxIndex(2),k)) &&...
            abs(error_rdop2(maxIndex(1), maxIndex(2))) < abs(error_rd(maxIndex(1), maxIndex(2),k)) )

            if (abs(error_rdop1(maxIndex(1), maxIndex(2)))<abs(error_rdop2(maxIndex(1), maxIndex(2))))
                disp('Operation OP1 is good')
                l=k+1;
                updatedCircuit(:,:,l)=updatedCircuitop1;
                error_rd(:,:,l)=error_rdop1
                L(:,:,l)=Lop1;
                rd(:,:,l)=rdop1;
                [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k));
            else
                disp('Operation OP2 is good')
                l=k+1;
                updatedCircuit(:,:,l)=updatedCircuitop2;
                error_rd(:,:,l)=error_rdop2
                L(:,:,l)=Lop2;
                rd(:,:,l)=rdop2;
                [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k));
            end

    elseif ( abs(error_rdop1(maxIndex(1), maxIndex(2))) < abs(error_rd(maxIndex(1), maxIndex(2),k)) &&...
            abs(error_rdop2(maxIndex(1), maxIndex(2))) > abs(error_rd(maxIndex(1), maxIndex(2),k)) ) 
         disp('Operation OP1 is good')
         l=k+1;
         updatedCircuit(:,:,l)=updatedCircuitop1;
         error_rd(:,:,l)=error_rdop1
         L(:,:,l)=Lop1;
         rd(:,:,l)=rdop1;
         [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k));
%(abs(error_rdop1(maxIndex(1), maxIndex(2))) > error_rd(maxIndex(1), maxIndex(2),k) &&...
%abs(error_rdop2(maxIndex(1), maxIndex(2))) < error_rd(maxIndex(1), maxIndex(2),k))
    else  
         disp('Operation OP2 is good')
         l=k+1;
         updatedCircuit(:,:,l)=updatedCircuitop2;
         error_rd(:,:,l)=error_rdop2
         L(:,:,l)=Lop2;
         rd(:,:,l)=rdop2;
         [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k));
    end
else
    disp('Operation OP1 is good')
     l=k+1;
     updatedCircuit(:,:,l)=updatedCircuitop1;
     error_rd(:,:,l)=error_rdop1;
     L(:,:,l)=Lop1;
     rd(:,:,l)=rdop1;
     [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k));
end

%%
if error_rd(maxIndex(1),maxIndex(2),k)>0 && -L(maxIndex(1),maxIndex(2),k)~=0
disp('Operation OP4: Decrease the edge resistance by 1 ohm')    
    if -L(maxIndex(1),maxIndex(2),k)>=2
    
        updatedGraph =...
        decrease_edge_resistance(L(:,:,k), maxIndex(1), maxIndex(2));
        Lop4=updatedGraph;
        disp(Lop4);

        updatedCircuitop4=...
        updatedGraph_to_laplacian(Lop4, maxIndex(1), maxIndex(2));
        disp(updatedCircuitop4);

        rdop2=updCir_to_resistdist(updatedCircuitop4);

        error_rdop4=rdop4-Rdstar;
        
        if( abs(error_rdop4(maxIndex(1), maxIndex(2))) <...
                abs(error_rd(maxIndex(1), maxIndex(2),k)) )
                disp('Operation OP4 is good')
                l=k+1;
                updatedCircuit(:,:,l)=updatedCircuitop4;
                error_rd(:,:,l)=error_rdop4;
                L(:,:,l)=Lop4;
                rd(:,:,l)=rdop4;
                [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k));
        else
                disp('OP4 is an invalid operation')
                l=k+1;
                updatedCircuit(:,:,l)=updatedCircuit(:,:,k);
                error_rd(:,:,l)=error_rd(:,:,k);
                L(:,:,l)=L(:,:,k);
                rd(:,:,l)=rd(:,:,k);
                [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k));
        end
    %% not completed yet
%     elseif -L(maxIndex(1),maxIndex(2),k)==1
%                 
%         
%         disp('Decreasing edge resistance not possible. Therefore find next maximum abs error resistance distance')
      %%  
    end
end
%%
if ( error_rd(maxIndex(1),maxIndex(2),k)>0 &&...
        -L(maxIndex(1),maxIndex(2),k)==0 )

disp('operation OP3: Edge addition with edge resistance by 1 ohm')
    updatedGraph = add_edge(L(:,:,k), maxIndex(1),maxIndex(2));
    Lop3=updatedGraph;
    disp(Lop3);

    updatedCircuitop3=...
        updatedGraph_to_laplacian(Lop3, maxIndex(1), maxIndex(2));
    disp(updatedCircuitop3);
    rdop3=updCir_to_resistdist(updatedCircuitop3);

    error_rdop3=rdop3-Rdstar;
    if ( abs( error_rdop3(maxIndex(1), maxIndex(2) )) <...
         abs( error_rd(maxIndex(1), maxIndex(2),k) ) ) 

        disp('Operation OP3 is good')
         l=k+1;
         updatedCircuit(:,:,l)=updatedCircuitop3;
         error_rd(:,:,l)=error_rdop3;
         L(:,:,l)=Lop3;
         rd(:,:,l)=rdop3;
         [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k));
      
    else
        disp('Operation OP3 is an invalid operation')

        [updated_Graph, ~] =...
                deleteEdge(L(:,:,k), maxIndex(1),maxIndex(2));
        Lop3=updatedGraph;
        disp(Lop3);

        updatedCircuitop3=...
            updatedGraph_to_laplacian(Lop3, maxIndex(1), maxIndex(2));
        disp(updatedCircuitop3);
        rdop3=updCir_to_resistdist(updatedCircuitop3);

        error_rdop3=rdop3-Rdstar;
        
         l=k+1;
         updatedCircuit(:,:,l)=updatedCircuitop3;
         error_rd(:,:,l)=error_rdop3;
         L(:,:,l)=Lop3;
         rd(:,:,l)=rdop3; 
         [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k));
    end

end


end