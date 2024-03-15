
function KGamma_M =...
    kirchhoffs(l12, l13, l14, l23, l34)

   [L, r13star, r14star, r34star,...
    r12hat, r23hat, r24hat,...
    r12,r13,r14,r23,r24,r34] =...
    network_struct(l12, l13, l14, l23, l34);
   
%  KGamma_M = r12+r23+r24+r13star+r14star+r34star;
   KGamma_M = r12+r23+r24+r13+r14+r34;

   
end
