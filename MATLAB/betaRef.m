function a=betaRef(j,alpha,searchCount)
% Calculates the beta value of the j'th cell by reference
% the matrix searchCount with respect to the success rate
% of searching by means of a given technology alpha.
    a=alpha.*(1-alpha).^(searchCount(j)-1);
end
