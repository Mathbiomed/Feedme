% interactively compute moments
% inputs:
% G = stoichiometry matrix Gamma n by n: n species, m reactions
% X = vector [X1 X2 ... Xn] of species
% R = vector [r1 r2 ... rm] of reactions (mass-action) (in same order as in G)
     % can contain kinetic constant as symbols
% M = moment to find dM/dt of

function dMdt = compute_moments_stoch(G,X,R,M)

%nospecies = length(X);
noreactions = length(R);

dMdt = 0;

 for j = 1:noreactions
    Z = (X'+G(:,j))';  % I am using rows but they are columns in theory
    dMdt = R(j)*(subs(M,X,Z)-M) + dMdt;
 end
 dMdt = expand(dMdt);

end
