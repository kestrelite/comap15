%  Plane Search V0.2
%  executesearch.m
%  
%  flightpath

cells=51;
%Set cells to the amount of cells per side of probability distribution

P0=(abs(peaks(cells)/(sum(sum(abs(peaks(cells)))))));
%P0 is initial probability distribution, representing the probability
%that the plane is in each cell.
%This command populates it with the peaks data set of size
%cells x cells and converts it to a probability distribution
%(sum of all elements = 1)

ships=10;
shipPos=zeros(cells);
%ships = # of ships searching
%Initiliazes matrix shipPos;
%shipPos tracks the position of each ship

searchCount=zeros(cells);
%Initializes matrix searchCount;
%searchCount tracks the number of times each cell has been searched

alpha = 0.45;

%Alpha is the probability of finding the plane while searching for it
%in a particular cell with a given technology.


%%%epsilonMat=(P0.*alpha.*((1-alpha).^(k-1)))/(1+d);
%Initializes the matrix epsilonMat, which stores the value for epsilon
%in each cell.

betaref=alpha.*(1-alpha).^(searchCount-1)
%Initializes the matrix betaref, which serves as a reference for the value
%of beta at any cell. It takes into account the

maxP0=find(P0 == max(P0(:)));
shipPos(maxP0)=1;
%P0(maxP0)=(P0(maxP0)*(1-alpha*(1-alpha)^(searchCount(maxP0)-1))/ ...
%    (1-P0(maxP0))

