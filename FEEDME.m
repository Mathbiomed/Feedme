clear

%%% Jae Kyoung Kim & Eduardo Sontag, Reduction of Multiscale Stochastic Biochemical Reaction Networks using Exact Moment Derivation, PLoS Computational Biology (2017) 

%%% user enters initial data here.  
%%% the code is illustrated with an example described in Fig 3 and Table 2 of Kim and Sontag.

%% WARNING: SAFEST TO USE SINGLE LETTERS WITH SUBSCRIPTS for params and vars
%%          not sure if e.g. "monomials" muPAD command works OK otherwise

% enter the variables and the parameters:
syms S_1 S_2 S_3 S_4 S_5 S_6 A_1 B_1 A_2 B_2 A_3 B_3 A_4 B_4 A_5 B_5 A_6 B_6 V real  %real needed when transposing
% M P E F Q R aM bM aP bP aE bE aF bF aQ bQ aR bR Omega in Table 2.  

% repeat here
params = [S_1 S_2 A_1 B_1 A_2 B_2 A_3 B_3 A_4 B_4 A_5 B_5 A_6 B_6 V] %slow species (S_1, S_2)=(M, P) and parameters which are treated as constant during momment calculation

% repeat here

species = [S_3 S_4 S_5 S_6] % fast species = [ E F Q R]


% fast reactions, one per column of the following stoichioetry matrix G
R = [ A_3  B_3*S_3  A_4  B_4*S_4   A_5*S_2*S_3  B_5*S_5 A_6*S_5*S_4 B_6*S_6] % R = [aE bE*E aF bF*F aQ*P*E bQ*Q aR*Q*F bR*R]


% stoichiometry matrix, rows are species and columns are reactions:
%Feedforward 
G = [  1 -1 0 0 0 0 0 0;%E
       0  0  1  -1   zeros(1,4);       %F
       0  0  0   0    1  -1 zeros(1,2);%Q
       0  0  0   0    0   0  1   -1]   %R
   


% the moment that we are interested in (i.e. <R> and <R^2> in Fig. 3), to start the process:
startexponents = [0 0 0 2;
                  0 0 0 1]   

%%% program starts here

nospecies = length(species);
zeroexponents = zeros(1,nospecies);
oldexponents = [zeroexponents;startexponents];
all_new_exponents = startexponents;
d_monom_all = [];


while(1) % start loop
 display('start new iteration now, computing d/dt for these exponents:')
 newexponents = all_new_exponents
 [d_monom,all_new_monomials,all_new_exponents] = feedforward_one_iteration(oldexponents,newexponents,G,species,R,params);
 display('equations so far: exponents and derivatives as follows:')
 d_monom_all = [d_monom_all,d_monom];
 exponents = oldexponents(2:end,:)  % remember the first one is zero
 derivatives = collect(d_monom_all,species)'
 if length(all_new_exponents)==0
   display('done')
   break
 else
   display('must do the following ones:')
   monomials_to_do = all_new_monomials'
   ie_these_exponents = all_new_exponents
 end
    m=input('Do you want to continue, Y/N [Y]:','s');
    if m=='N'|m=='n'
    break
 end
 oldexponents=[oldexponents;all_new_exponents];
end %while
