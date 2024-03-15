
function KGamma_M = kirchhoffs(Lapval, t, r13star,r14star,r34star)

   r12 = det(Lapval(3:end,3:end))/t;
   r23 = det(Lapval( [1,4:end] , [1,4:end] ))/t;
   r24 = det(Lapval( [1,3,5:end] , [1,3,5:end] ))/t;
   
   KGamma_M = r12+r23+r24+r13star+r14star+r34star;
   
end
