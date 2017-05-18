% 'using normalized' means that I avoid "nA !" which casuses numerical problems
%    by both dividing numerator and denominator Z function by it

% for the following system:
% A+B <--> D  with rates --> k_{B,+} and <-- k_{B,-}
% A+C <--> E  with rates --> k_{C,+} and <-- k_{C,-}
% and letting
% L = k_{B,+} / k_{B,-}
% M = k_{C,+} / k_{C,-}
% this computes the mean of "D" conditioned on
% A+D+E = n_A
%   B+D = n_B = 1
%   C+E = n_C
% assumes that n_B=1 to get simpler formula, but can easily generalize
% sample usage:
% competitive_binding_mean_D(3,8,[4,1,7])
%    gives answer:  0.2633
% when L=3, M=8, n_A=4, n_C=7

function meanD = meanD(L,K,b)

% L and K are lambda and mu; b is the conservation vector
% assumes that n_B=1 to get simpler formula, but can easily generalize

nA=b(1);
nB=b(2);
nC=b(3);

if nB~=1
   display('error: program only works for n_B=1 but your n_B is:')
   nB
   display('panic stop')
   return
end
%
%
%bminus1(1) = nA-1;
%bminus1(2) = 0;
%bminus1(3) = nC;

meanD = L * nA*Qtilde(nA-1,nC) /  ( Qtilde(nA,nC) + L*nA*Qtilde(nA-1,nC) );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I now changed index i to J -- not sure if I was not inheriting i from top
function tot = Qtilde(p,n)
 m1 = min([p,n]);
 tot = 0;
 for J=0:m1
    tot = tot + nchoosek(p,J) * K^J / factorial(n-J);
 end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 end
