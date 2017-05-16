# Feedme
Matlab codes to calculate stationary moments of feed forward network and complex balanced network

This folder has MATLAB scripts for:

1. Generation of time-evolution equations for feedforward networks:

the script FEEDME.m includes stoichiometry and reaction definitions, and this example can be easily adapted to any other problem.

2. Calculation of steady states for moments for feedforward networks:

run in the same MATLAB session the script feedforward_solve_steady_state.m in order to get a matrix form for the solution and solve for steady state moments.
[WARNING: if there are conservation laws, then matrix is singular, and the code will terminate with an error condition because X = -inv(A1)*b1 is not defined (see "if" condition).  In that case, one should eliminate variables first, and then solve.]

3. calculation of steady state moments using complex balancing

The script competitive_binding_mean_D_using_normalized.m illustrated this method.  
The script needs arguments: L, K, and the vector of total conserved quantities, assuming for simplicity that n_B=1.
Sample usage:
   competitive_binding_mean_D(3,8,[4,1,7])
is used when L=3, M=8, n_A=4, and n_C=7 (and n_B=1).
