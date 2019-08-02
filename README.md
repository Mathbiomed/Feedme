This folder has MATLAB scripts for:

1. Generation of time-evolution equations for feedforward networks:

the script 
FEEDME.m
includes stoichiometry and reaction definitions for the fast subnetwork of Fig. 3 and Table 2 in Kim and Sontag, PLoS Com Biol (2017):
0 → E → 0
0 → F → 0
E+P → E+P+Q
Q → 0
F+Q → F+Q+R
R → 0

To apply to a different network, simply change the following variables:

●	syms  (include here symbols for all species and all parameters)
●	params (repeat here only the parameters and slow species)
●	species (repeat here only the fast species)
●	G (the stoichiometry matrix of fast reactions)
●	R (the vector of fast reactions, given as a row)
●	startexponents (the list of derived moments, for example [1 3 0 1] would mean <S1S23S4> )

2. Derive the equation for stationary moments for feedforward networks:

run in the same MATLAB session the script 
feedforward_solve_steady_state.m 
in order to get a matrix form for stationary moments.
[WARNING: if there are conservation laws, then matrix is singular, and the code will terminate with an error condition because X = -inv(A1)*b1 is not defined (see "if" condition).  In that case, one should eliminate variables first, and then solve.]

3. Calculate the stationary moments for feedforward networks:

run in the same MATLAB session the script 
moment_calculation.m 
in order to solve the matrix equation for stationary moments derived from feedforward_steady_state.m. paramsv (parameter values)

4. calculation of steady state moments using complex balancing:

The script 
competitive_binding_mean_D_using_normalized.m 
illustrates this method.  
The script needs arguments: L, K, and the vector of total conserved quantities, assuming for simplicity that n_B=1.
Sample usage:
competitive_binding_mean_D(3,8,[4,1,7])
is used when L=3, M=8, n_A=4, and n_C=7 (and n_B=1).

Reference: 
Jae Kyoung Kim & Eduardo Sontag, Reduction of Multiscale Stochastic Biochemical Reaction Networks using Exact Moment Derivation, PLoS Computational Biology (2017)


