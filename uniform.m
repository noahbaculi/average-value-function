function point = uniform(s,N,b)
% UNIFORM returns a point from a uniform grid over a hypercube
%
% point = uniform(s,N,b)
%
% N = number of dimensions of hypercube
% b = number of points per dimension
% s = index of desired point in sequence, 1 <= s <= b^N
%
% point = 1-by-N row vector of elements in the interval [0,1]
%

%{
% Skip error checking for speed
error(nargchk(3,3,nargin));
error(nargoutchk(0,1,nargout));
if ~(isnumeric(s) && isnumeric(N) && isnumeric(b))
    error('Input arguments must be numeric.');
elseif length(s)*length(N)*length(b) ~= 1
    error('Input arguments must be scalars.');
elseif ~isreal([s N b])
    error('Input arguments must be real.');
elseif any(fix([s N b]) ~= [s N b])
    error('Input arguments must be integers.');
elseif any([N b] < 1) || any([N b] == Inf)
    error('Wrong number of dimensions or points per dimension.');
elseif (s < 1) || (s > b^N)
    error('Index out of range.');
end
%}


point = ones(1,N)/(b+1);
k = 1;

s = s - 1;
while s > 0
    remainder = mod(s,b);
    point(k) = (remainder+1)/(b+1);
    s = fix(s/b);
    k = k + 1;
end
