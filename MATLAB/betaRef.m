function a=betaRef(j,alpha,searchCount)
% Calculates the beta value of the j'th cell by referencing
% the matrix searchCount with respect to the success rate
% of searching by means of a given technology alpha.
%% NOTE: This is using the formula:
%% alpha*(1-alpha)^k-1, with k-1 replaced with k.
%% The implementation of this function, primarily in populating
%% the epsilonMat matrix, requires that this substitution be made
%% in order to accurately report the search effectiveness (epsilon)
%% for the next search in any given cell.
    a=alpha.*(1-alpha).^(searchCount(j));
end