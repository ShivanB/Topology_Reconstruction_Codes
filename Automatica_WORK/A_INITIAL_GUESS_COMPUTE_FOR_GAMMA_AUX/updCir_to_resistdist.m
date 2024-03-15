function rd=updCir_to_resistdist(upCircuit)

n=size(upCircuit);
rd=zeros(n(1));


for i=1:n(1)
    for j=1:n(1)
        if (i==j) 
            rd(i,j)=0;
        else
            b=zeros(n(1),1);
            b(i)=1;
            b(j)=-1;
            rd(i,j)=vpa(transpose(b)*pinv(upCircuit)*b);
        end
    end
end



end
