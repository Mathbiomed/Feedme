
%Substitute appropraite values to parameters to calculate desired
%moment


ep=100;  %1/Epsilon in Fig 3 and Table 2 of Kim and Sontag, PLoS Biol (2017)
params3=[ A_3, B_3, A_4, B_4, A_5, B_5, A_6, B_6, S_1, S_2]
paramsv=[ ep*V, ep, ep*V, ep, ep/V, ep,ep/V, ep, S_1, S_2]; %Parameter values   

A3 = subs(A,params3,paramsv)
b3 = subs(b,params3,paramsv)

B=-inv(A3)*b3

expand(B)
simplify(B)


