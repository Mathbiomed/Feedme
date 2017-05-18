function [new_exponents,new_monomials] = return_new_exponents(oldexponents,species,params,input_mon)

prodsp = prod(species);
nopars = length(params);
nospecies = length(species);
onevecspecies = ones(1,nospecies);
onevecpars = ones(1,length(params));

%NEW CODE, WAS WRONG BECAUSE "monomials" doesn't work with arrays!
% OLD:
%mons=feval(symengine,'monomials',input_mon);
% NEW:
howmanyexpressions=length(input_mon)
mons=[];
for i=1:howmanyexpressions
   mons=[mons,feval(symengine,'monomials',input_mon(i))];
end
% this returns monomials
% it is silly but cannot get all variables unless I do this: add a degree and
%   then take it out!
howmanymons = length(mons);
mons = subs(mons,params,onevecpars)*prodsp;
allexponents = [];
 for i = 1:howmanymons
 allexponents = [feval(symengine,'degreevec',mons(i))-onevecspecies;allexponents];
 end


%EDS 31 Aug 2016:
% I have no idea why this is needed, but somehow allexponents end up being
%  symbolic variables, so I am making them integers; must figure out sometime!
allexponents = int8(allexponents)


allexponents=sortrows(allexponents);
% pick new exponent vectors
new_exponents=setdiff(allexponents,oldexponents,'rows');

sne = size(new_exponents);
howmany_new_exponents = sne(1);
new_monomials=[];
for i = 1:howmany_new_exponents
  new_monomials = [new_monomials,prod(species.^new_exponents(i,:))];
end

end
