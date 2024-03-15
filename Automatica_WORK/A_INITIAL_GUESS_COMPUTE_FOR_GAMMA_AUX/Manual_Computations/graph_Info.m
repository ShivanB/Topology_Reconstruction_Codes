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
l12= -1/(1+1); l13= 0; l14= -1/(1+1);
l11=-(l12+l13+l14);

l23= -1/(1+1); l24= 0;
l22=-(l12+l23+l24);

l34=-1/(1);
l33=-(l13+l23+l34);

l44=-(l14+l24+l34);

% Initial Laplacian matrix 
L            =[ l11 l12 l13 l14
                l12 l22 l23 l24
                l13 l23 l33 l34
                l14 l24 l34 l44];


rd=updCir_to_resistdist(L)

error_rd = rd - Rdstar

[maxValue, maxIndex] =...
    findMaxAbsoluteValue(error_rd)
%%
function rd=updCir_to_resistdist(L)

n=size(L);
rd=zeros(n(1));


for i=1:n(1)
    for j=1:n(1)
        if (i==j) 
            rd(i,j)=0;
        else
            b=zeros(n(1),1);
            b(i)=1;
            b(j)=-1;
            rd(i,j)=vpa(transpose(b)*pinv(L)*b);
        end
    end
end



end

function [maxValue, maxIndex] =...
    findMaxAbsoluteValue(matrix)

    % Find the maximum absolute value
    [maxValue, linearIndex] = max(abs(matrix(:)));

    % Convert linear index to matrix indices
    [row, col] = ind2sub(size(matrix), linearIndex);


    % Return the indices
    maxIndex = [row, col];
end