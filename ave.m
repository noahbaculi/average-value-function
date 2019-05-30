function f_ave = ave(f,num,varargin)
% AVE Calculate the average value of a function
% Function AVE calculates the avaerage value of a function f by
% calculating the value of 'num' number of points on an interval [a b] or
% set of intervals specified for each variable using a uniform,
% pseudo-random, or quasi-random (using the Halton sequence) method for
% distribution of points.
% 
% Calling sequence:
%     f_ave = ave(f, num, [a b], 'method')
% 
% Define variables:
%     f        -- Function of which the average is to be computed
%     num      -- Number of points to be evaluated per variable
%     a        -- Lower boundary on interval of function
%     b        -- Upper boundary on interval of function
%     'method' -- The method used to determine the points used to calculate
%                 the average. 'Uniform' prompts a uniform distribution of
%                 points. 'Random' prompts a pseudo-random distribution of
%                 points. 'Halton' prompts a quasi-random distribution of
%                 points. Unspecified, the method is automatically set to
%                 prompt a uniform distribution of points.
% 
% If the function is multidimensional, additional intervals may be
% specified for each variable like so:
%     Calling sequence where f is a function of 3 variables:
%         f_ave = ave(f, num, [a b], [c d], [e f], 'method')
% 
% Record of revisions:
%      Date        Programmer        Descrition of change
%      ====        ==========        ====================
%    10/17/17      Noah Baculi       Original code
%    05/20/17      Noah Baculi       Update and review
% 
% See also UNIFORM, RAND, HALTON

%check that the number of input arguments is greater than 2
narginchk(3,1000000000)

%check that input for f is function handle
if isa(f,'function_handle')
%    fprintf('The input for f is a function handle.\n')
else
    error('The input provided for f is not a function handle.')
end

%check if last input provided is method or interval
N = nargin - 2;
if isa(varargin{N},'char')
    method = varargin{N};
    N = N - 1;
else
    method = 'uniform';
end

% check N equals the number of input arguments for f or it is equal to one
if N ~= nargin(f) && N ~= 1
    error('The number of dimensions is not equal to the number of input arguments for f or it is not equal to one.')
else
%    fprintf('The number of dimensions is  equal to the number of input arguments for f or it is equal to one.\n')
end

%check that num is of integer class
if ~isa(num,'numeric')
    error('The variable num is not an integer.\n')
else
%    fprintf('The variable num is an integer.\n')
end

%initialize a and b
a = zeros(1,nargin(f));
b = zeros(1,nargin(f));

%check interval configuration
if (isa(varargin{nargin-2},'char') && length(varargin) == 2) || (length(varargin) == 1)
    if isnumeric(varargin{1}) && numel(varargin{1})
        a(:) = varargin{1}(1);
        b(:) = varargin{1}(2);
    else
        error('One or more of the inputs intended for intervals is not a numeric 1x2 array.')
    end
    N = nargin(f);
elseif (isa(varargin{nargin-2},'char') && nargin(f) == length(varargin) - 1) || (isa(varargin{nargin-2},'numeric') && nargin(f) == length(varargin))
    for ii = 1:nargin(f)
        if isnumeric(varargin{ii}) && numel(varargin{ii})
            a(ii) = varargin{ii}(1);
            b(ii) = varargin{ii}(2);
        else
            error('One or more of the inputs intended for intervals is not a numeric 1x2 array.')
        end
    end
else
    error('The number of intervals provided for the function is not one for all dimensions nor one for each dimension.')
end
    
%sum calculation
method = lower(method);
f_sum = 0;

for ii = 1:fix(num^N)
    if method(1:6) == 'unifor'
        point = uniform(ii,N,num);
    elseif method == 'random'
        point = rand(1,N);
    elseif method == 'halton'
        point=halton(ii,N);
    else
        error('The suggested method is not ''Uniform,'' ''Random'', nor ''Halton.''')
    end
    x = num2cell(a + point.*(b-a));
    f_sum = f_sum + f(x{:});
end
f_ave = f_sum/ii;
end
