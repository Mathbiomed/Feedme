clear

%%% user enters initial data here

%% WARNING: SAFEST TO USE SINGLE LETTERS WITH SUBSCRIPTS for params and vars
%%          not sure if e.g. "monomials" muPAD command works OK otherwise

% Momdent calculation of R^2 for the following feedforward network.
% 0 ? M ? 0
% M ? M+P
% P ? 0
% 0 ? E ? 0
% 0 ? F ? 0
% E+P ? E+P+Q
% Q ? 0
% F+Q ? F+Q+R
% R ? 0



% enter the variables and the parameters:
syms S_1 S_2 S_3 S_4 S_5 S_6 A_1 B_1 A_2 B_2 A_3 B_3 A_4 B_4 A_5 B_5 A_6 B_6 real  %real needed when transposing

% repeat here
params = [A_1 B_1 A_2 B_2 A_3 B_3 A_4 B_4 A_5 B_5 A_6 B_6]

% repeat here
% species = [M P E F Q R]
species = [S_1 S_2 S_3 S_4 S_5 S_6]

% stoichiometry matrix, rows are species and columns are reactions:

%M
%P
%E
%F
%Q
%R
  
G = [...
1 -1 zeros(1,10);%M
0 0  1 -1 zeros(1,8);%P
0 0  0  0  1 -1 zeros(1,6);%E
0 0  0  0  0  0  1  -1 zeros(1,4);%F
0 0  0  0  0  0  0   0    1  -1 zeros(1,2);%Q
0 0  0  0  0  0  0   0    0   0  1   -1]   %R

% reactions, one per column of G
% R = [AM DM*M AP*M DP*P AE DE*E AF DF*F AQ*P*E BQ*Q AR*Q*F DR*R]
R = [A_1 B_1*S_1 A_2*S_1 B_2*S_2 A_3 B_3*S_3 A_4 B_4*S_4 A_5*S_2*S_3 B_5*S_5 A_6*S_5*S_4 B_6*S_6]

% the moment that we are interested in, to start the process:
startexponents = [0 0 0 0 0 2]   % could use a matrix, one row for each

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
