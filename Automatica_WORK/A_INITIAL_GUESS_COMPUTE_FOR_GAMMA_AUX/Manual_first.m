% nb=4
% maximal planar graph=6 edges
format short
clc
%%
% initial edge resistance values  
r(1,2)=1;r(1,3)=1;r(1,4)=1;

r(2,1)=r(1,2);r(2,2)=0;r(2,3)=1;r(2,4)=1;

r(3,1)=r(1,3);r(3,2)=r(2,3);r(3,3)=0;r(3,4)=1;

r(4,1)=r(1,4);r(4,2)=r(2,4);r(4,3)=r(3,4);r(4,4)=0;
% edge resistance matrix, entry 0 means there are no edges.
r;
%%
% Known resistance distance
Rdstar=[0    1.3067 1.4985 1.3509    
    1.3067      0   1.1464 1.3208    
    1.4985   1.1464     0  1.0795    
    1.3509   1.3208 1.0795,   0]; 
%%
l12= -1/r(1,2);
l13= -1/r(1,3);
l14= -1/r(1,4);
l11=-(l12+l13+l14);
l23= -1/r(2,3);
l24= -1/r(2,4);
l22=-(l12+l23+l24);
l34=-1/r(3,4);
l33=-(l13+l23+l34);
l44=-(l14+l24+l34);
% edge resistance and the connection 
L(:,:,1)=[l11 l12 l13 l14
          l12 l22 l23 l24
          l13 l23 l33 l34
          l14 l24 l34 l44]; 
updatedCircuit(:,:,1)=L(:,:,1);   

k=1;

    rd(:,:,k)=updCir_to_resistdist(updatedCircuit(:,:,k));
    disp('resistance distance')
    disp(rd(:,:,k))
    error_rd(:,:,k)=rd(:,:,k)-Rdstar;
    disp('resistance distance')
    disp(error_rd(:,:,k))
    [maxValue, maxIndex] = findMaxAbsoluteValue(error_rd(:,:,k))
%%
%operation OP1: Edge deletion
disp('Operation OP1: Delete Edge')
if(error_rd(maxIndex(1),maxIndex(2),k)<0 && -L(maxIndex(1),maxIndex(2),k)~=0)

    edgeToDelete=[maxIndex(1),maxIndex(2)]
    [updatedLaplacianop1, deletedNodesDegrees] = deleteEdge(L(:,:,k), edgeToDelete)
        %degree conditions check
     if deletedNodesDegrees(1) ~= 1 && deletedNodesDegrees(2) ~= 1
    Lop1=updatedLaplacianop1;
    updatedCircuitop1 = updatedGraph_to_laplacian(updatedLaplacianop1, maxIndex(1), maxIndex(2))
    rdop1=updCir_to_resistdist(updatedCircuitop1);
     error_rdop1=rdop1-Rdstar
        if (abs(error_rdop1(maxIndex(1), maxIndex(2)))<abs(error_rd(maxIndex(1), maxIndex(2),k)))
             disp('go to OP2')
            else
                disp('Invalid operation')
                updatedLaplacianop1= L(:,:,k);
                Lop1=L(:,:,k);
                updatedCircuitop1 = updatedGraph_to_laplacian(updatedLaplacianop1, maxIndex(1), maxIndex(2));
                rdop1=updCir_to_resistdist(updatedCircuitop1);
                error_rdop1=rdop1-Rdstar;
                disp('go to OP2')
        end
    else
    updatedLaplacianop1= L(:,:,k);
    Lop1=L(:,:,k);
    updatedCircuitop1 = updatedGraph_to_laplacian(updatedLaplacianop1, maxIndex(1), maxIndex(2));
    rdop1=updCir_to_resistdist(updatedCircuitop1);
    error_rdop1=rdop1-Rdstar;
    disp('go to OP2')
     end
end
%%
%operation OP2: Increase edge resistance by 1 ohm
disp('Operation OP2: Increase the edge resistance by 1 ohm')
if(error_rd(maxIndex(1),maxIndex(2),k)<0 && -L(maxIndex(1),maxIndex(2),k)<=4)
    
    updatedGraph = increaseEdgeWeight(L(:,:,k), maxIndex(1), maxIndex(2));
    Lop2=updatedGraph;
    disp(updatedGraph);
    updatedCircuitop2= updatedGraph_to_laplacian(Lop2, maxIndex(1), maxIndex(2));
    disp(updatedCircuitop2);
    rdop2=updCir_to_resistdist(updatedCircuitop2);
    error_rdop2=rdop2-Rdstar;
    %%
    %Operation OP3: Choosing operation from op1 and op2
    if( abs(error_rdop1(maxIndex(1), maxIndex(2))) < abs(error_rdop2(maxIndex(1), maxIndex(2))) )
        l=k+1;
        updatedCircuit(:,:,l)=updatedCircuitop1;
        error_rd(:,:,l)=error_rdop1
        L(:,:,l)=Lop1;
        rd(:,:,l)=rdop1;
        else
        l=k+1;
        updatedCircuit(:,:,l)=updatedCircuitop2;
        error_rd(:,:,l)=error_rdop2
        L(:,:,l)=Lop2;
        rd(:,:,l)=rdop2;
    end

else
    disp('implement OP1')
     l=k+1;
    updatedCircuit(:,:,l)=updatedCircuitop1;
    error_rd(:,:,l)=error_rdop1
    L(:,:,l)=Lop1;
    rd(:,:,l)=rdop1;
end

%%
%operation OP4: Decrease edge resistance by 1 ohm
disp('Operation OP4: Decrease the edge resistance by 1 ohm')
if error_rd(maxIndex(1),maxIndex(2),k)>0 && -L(maxIndex(1),maxIndex(2),k)~=0
    
    if -L(maxIndex(1),maxIndex(2),k)>=2
    
        updatedGraph = decrease_edge_resistance(L(:,:,k), maxIndex(1), maxIndex(2));
        Lop4=updatedGraph;
        disp(updatedGraph);
        updatedCircuitop4= updatedGraph_to_laplacian(Lop4, maxIndex(1), maxIndex(2));
        disp(updatedCircuitop4);
        rdop2=updCir_to_resistdist(updatedCircuitop4);
        error_rdop4=rdop4-Rdstar;
        %choosing operation from op1 and op2
        if( abs(error_rdop4(maxIndex(1), maxIndex(2))) < abs(error_rd(maxIndex(1), maxIndex(2),k)) )
            l=k+1;
            updatedCircuit(:,:,l)=updatedCircuitop4;
            error_rd(:,:,l)=error_rdop4
            L(:,:,l)=Lop4;
            rd(:,:,l)=rdop4;
        else
            disp('OP4 is an invalid operation')
            l=k+1;
            updatedCircuit(:,:,l)=updatedCircuit(:,:,k);
            error_rd(:,:,l)=error_rd(:,:,k)
            L(:,:,l)=L(:,:,k);
            rd(:,:,l)=rd(:,:,k);
        end  

    end
end
%%
%operation OP5: Edge addition with edge resistance by 1 ohm
disp('operation OP5: Edge addition with edge resistance by 1 ohm')
