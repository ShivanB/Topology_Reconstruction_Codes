
function KGamma_M =...
    kirchhoffs(l12, l14, l15, l16,...
    l23, l26, l34, l36, l45, l46, l56)

    [~, r13star, r14star, r34star,...
    ~, ~, ~,...
    r12,~,~,r15,r16,r23,r24,r25,r26,~,...
    r35,r36,r45,r46,r56] =...
    network_struct(l12, l14, l15,...
    l16, l23, l26, l34, l36, l45, l46, l56);


%  KGamma_M = r12+r23+r24+r13star+r14star+r34star;
   KGamma_M = r12+r13star+r14star+r15+r16...
                 +r23+r24+r25+r26...
                 +r34star+r35+r36...
                 +r45+r46...
                 +r56;

   
end
