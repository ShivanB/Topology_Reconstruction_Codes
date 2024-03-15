clc
format short
syms l15 l16 l17 l18 l19 l110 l111 l112 l113 l114 l115 l116...
         l25 l26 l27 l28 l29 l210 l211 l212 l213 l214 l215 l216...
         l35 l36 l37 l38 l39 l310 l311 l312 l313 l314 l315 l316...
         l45 l46 l47 l48 l49 l410 l411 l412 l413 l414 l415 l416...
    l56 l78 l910 l1112 l1314 l1516 d1 d2 d3 d4 d5 d6 d7 d8 d9 d10...
    d11 d12 d13 d14 d15 d16 
%%
a=1;
[poly12x,poly12,poly13x,poly13,poly14x,poly14,poly23x,poly23,poly24x,...
    poly24,poly34x,poly34,L] = polygen(a);

%%
      %l15  l16  l27 l28  l39 l310  l411 l412  l113  l114  l415  l416 
solut=[0    1    1    0     0    1      0       1        1     0       0     0   ];

[r120, r130, r140, r230, r240, r340,Lapval] = delr_delp(L, solut);

r12star=1.4182
err12=(r120-r12star)
r13star=1.3636
err13=(r130-r13star)
r14star=1.4182
err14=(r140-r14star)
r23star=1.6909
err23=(r230-r23star)
r24star=2.4
err24=(r240-r24star)
r34star=1.6909
err34=(r340-r34star)

toterr=err12+err13+err14+err23+err24+err34
Kfstar=r12star+r13star+r14star+r23star+r24star+r34star
Kf1=r120+r130+r140+r230+r240+r340
 
%%
%Changes in connection
                        %l15  l16  l27 l28  l39 l310  l411 l412  l113  l114  l415  l416 
unit_con_change=[0    1    1     0     1    0      0       1      1      0       0      0 ];% unit connection changes compared to solut

[r120x, r130x, r140x, r230x, r240x, r340x] = delr_delp(L, unit_con_change);
r120x;
err12x=(r120x-r12star);
r130x;
err13x=(r130x-r13star);
r140x;
err14x=(r140x-r14star);
r230x;
err23x=(r230x-r23star);
r240x;
err24x=(r240x-r24star);
r340x;
err34x=(r340x-r34star);
rd_change=[r120x, r130x, r140x, r230x, r240x, r340x];
rd_change=vpa(rd_change,4)
err_change=[err12x, err13x, err14x, err23x, err24x, err34x];
err_change=vpa(err_change,4)
%%
%%% resistance distance using the Laplacian definition
b12=[1;-1; 0; 0;zeros(12,1)];
% L=[1.1667 -1/3 -1/3 -1/2;-1/3 2/3 -1/3 0;-1/3 -1/3 1.1667 -1/2; -1/2 0 -1/2 1];
r12=transpose(b12)*pinv(Lapval)*b12