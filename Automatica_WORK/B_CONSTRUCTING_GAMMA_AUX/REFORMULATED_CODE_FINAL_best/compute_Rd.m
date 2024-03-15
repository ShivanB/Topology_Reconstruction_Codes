function [Resist_Dist_Matrix, Resist_Dist_Matrix_4node]=compute_Rd(modifiedRho)

[L,~,~,~]=...
network_struct(modifiedRho(1), modifiedRho(2), modifiedRho(3),...
modifiedRho(4), modifiedRho(5), modifiedRho(6), modifiedRho(7),...
modifiedRho(8), modifiedRho(9), modifiedRho(10), modifiedRho(11),...
modifiedRho(12), modifiedRho(13), modifiedRho(14), modifiedRho(15),...
modifiedRho(16), modifiedRho(17), modifiedRho(18), modifiedRho(19),...
modifiedRho(20), modifiedRho(21), modifiedRho(22), modifiedRho(23),...
modifiedRho(24));

n=size(L);
J=ones(n(1));

XRd=inv( L+(1/n(1))*J );
Xbar = diag([XRd(1),XRd(2),XRd(3),XRd(4),XRd(5),...
                    XRd(6),XRd(7),XRd(8),XRd(9),XRd(10),...
                    XRd(11),XRd(12),XRd(13),XRd(14),XRd(15),...
                    XRd(16),XRd(17),XRd(18),XRd(19),XRd(20),...
                    XRd(21),XRd(22)]);

Resist_Dist_Matrix=J*Xbar + Xbar*J - 2*XRd;

Resist_Dist_Matrix_4node =...
Resist_Dist_Matrix(1:4,1:4) -...
( Resist_Dist_Matrix(1:4,5:n(1))*inv(Resist_Dist_Matrix(5:n(1),5:n(1)))*...
 transpose(Resist_Dist_Matrix(1:4,5:n(1))));                                            

end