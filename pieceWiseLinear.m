
function y = pieceWiseLinear(p, x)
% ds 2019-11-08
% unpack params
p_c = p(1);
h = p(2);
m = p(3);

y = nan(size(x));
% do the bit above p_c: easy
y(x>p_c) = h;
% the bit below and including the knee point... make sure it goes through
% that point...
y(x<=p_c) = m.*(x(x<=p_c))  + h - m .* p_c;

end