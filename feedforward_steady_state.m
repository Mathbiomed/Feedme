syms Z real  % will be zero at the end
how_many_monomials=length(exponents);
all_monomials=[];
for i=1:how_many_monomials
	all_monomials = [all_monomials,prod(species.^exponents(i,:))];
end
%all_monomials';
%derivatives=expand(derivatives);  % avoid things like "S_2*(2*A_1 + B_1)*S_1"

% adding Z, to be made=0, so all monomials appear
zero_poly = sum(Z*all_monomials);
derivatives_plusZ=expand(derivatives+zero_poly);
% expand to avoid things like "S_2*(2*A_1 + B_1)*S_1"
breakflag=0;
AA=[];
TT=[];
fprintf('Working');
for i=1:how_many_monomials
    fprintf('.');
    [C,T]=coeffs(derivatives_plusZ(i),species);
    TTL = length(TT);
    TL = length(T);
    if (TTL < TL) && (i~=1)
       if TL > TTL+1
         display(' ')
	 display('**** error: too many cols T; panic stop ****')
         breakflag=1;
	 break % seems not to work
       end % too many new columns
       if T(end) ~= 1
         display(' ')
	 display('**** error: T(end) is not 1; panic stop ****')
         breakflag=1;
	 break % seems not to work
       end % last entry of T is not 1
       rowsTT = size(TT,1);
       TT = [TT ones(rowsTT,1)];
       AA = [AA zeros(rowsTT,1)];
    end
    if (TTL > TL) && (i~=1)
       if TTL > TL+1
         display(' ')
	 display('**** error: too few cols T; panic stop ****')
         breakflag=1;
	 break % seems not to work
       end % too many new columns
       rowsTT = size(TT,1);
       T = [T 1];
       C = [C 0];
    end
    AA = [AA;C];
    TT = [TT;T];
end
fprintf('\n');

if breakflag==1
   display('Sorry about that.  Please contact Eduardo sending all relevant files.')
   return
end

%debug:
size(AA);
size(TT);


display('Debug: this number should be zero:')

test_equal_rows_TT = sum((1/how_many_monomials)*sum(TT,1)-TT(1,:)) % average across rows

Azero = subs(AA,Z,0);

TTL = length(TT);  %test if there's a constant term
if TTL==how_many_monomials+1
   display('note: there is a constant term; this should be 1 if there are no bugs:')
   TT(end,TTL)
   A = Azero(:,1:how_many_monomials);
   b = Azero(:,TTL);
else
   A = Azero;
   b=zeros(how_many_monomials,1);
end
% this is the order of monomials in AM+b, but equations ordered as all_monomials
M = TT(1,1:how_many_monomials);
N = all_monomials;
%display('for moments N and M ordered respectively as follows:')
%[N' M']

[~,idx] = ismember(M,N);
%display('The mapping is:')
indices = 1:how_many_monomials;
[indices' idx'];
I =eye(how_many_monomials,how_many_monomials);
%display('This is the permutation matrix:')
P = I(idx,:);
%Nperm = (P*N')';
%display('This should be zero:')
%Nperm' - M'
A = P*A;
b = P*b;

display('debug: if this next expression is not zero, then there is something wrong with the matrix formalism!!')
test_matrix_formalism=sum(abs(A*M'+b-P*derivatives))

display('The equation for moments is dM/dt = AM + b, where:')
A
b
display('and moments are ordered as follows:')
M'


 rootname = 'feedforward_matrices';
 randomID=floor(10000000*rand());   % adding random sequence as unique barcode for filename
 underscore='_';
 extension = '.mat';
 filename = [rootname, underscore, num2str(randomID),extension];
 save(filename,'A','b');

display('A and b matrices are saved to this file:')

filename
