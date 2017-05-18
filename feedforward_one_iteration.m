
function [d_monom,all_new_monomials,all_new_exponents] = feedforward_one_iteration(oldexponents,newexponents,G,species,R,params)

q = size(newexponents);
howmany_newexponents = q(1)
all_new_monomials=[];
all_new_exponents=[];
d_monom=[];
  
  for i=1:howmany_newexponents
        monom = prod(species.^newexponents(i,:));
        moments_derivs = moments_derivatives(G,species,R,monom)
        d_monom = [d_monom,moments_derivs];
% trap when derivative is zero (constant moment) -- return_new errors on setdiff
        if d_monom ~= 0
          [new_exponents,new_monomials] = ...
         	  return_new_exponents(oldexponents,species,params,d_monom);
          all_new_monomials = [all_new_monomials,new_monomials];
          all_new_exponents = [all_new_exponents;new_exponents];
        end %if
  end %for

all_new_monomials = unique(all_new_monomials);
all_new_exponents = unique(all_new_exponents,'rows'); %remove repeated ones
  
end %function
