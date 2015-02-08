%  Plane Search V0.2
%  executesearch.m
%  
%  flightpath

cells=101;
cells2=cells*cells;
%Set cells to the amount of cells per side of probability distribution

probDistrib=(abs(peaks(cells)/(sum(sum(abs(peaks(cells)))))));
%probDistrib is initial probability distribution, representing the probability
%that the plane is in each cell.
%This command populates it with the peaks data set of size
%cells x cells and converts it to a probability distribution
%(sum of all elements = 1)

ships=3;
shipPos=zeros(cells);
%ships = # of ships searching
%Initiliazes matrix shipPos;
%shipPos tracks the position of each ship

searchCount=zeros(cells);
%Initializes matrix searchCount;
%searchCount tracks the number of times each cell has been searched

shipAlpha = 0.45;

%shipAlpha is the probability of finding the plane while searching for it
%in a particular cell with a given technology.

initialShipDistrib = probDistrib;
maxP0valuesInit=zeros(1,ships);
maxP0locInit=zeros(1,ships);
for n=1:ships
    maxProbabilityPos = find(initialShipDistrib == max(initialShipDistrib(:)));
    shipPos(maxProbabilityPos) = 1;
    initialShipDistrib(maxProbabilityPos) = 0;
    maxP0valuesInit(n) = probDistrib(maxProbabilityPos);
    maxP0locInit(n) = maxProbabilityPos;
end

searchCount = searchCount .+ shipPos;

%This loop places the ships in the cells with the highest probability
%of conducting a successful search.
%It stores the maximum initial probDistrib values in the vector maxP0valuesInit
%and the original location of those values in the vector maxP0locInit

epsilonMat=zeros(cells,cells);
for n=1:cells2
    epsilonMat(n)=(probDistrib(n).*betaRef(n,shipAlpha,searchCount));
end

%Initiates and populates the epsilon matrix epsilonMat without
%the cost function.

for n=1:cells2
    probDistrib(n)=probDistrib(n).*((1/(1-(probDistrib(n).*betaRef(n,shipAlpha,searchCount)))));
end

%Applies Bayesian Search Theory for all cells using the unsearched
%state. The loop below applies the Bayesian Search Theory for all cells
%using the searched state for the searched cells.

for n=1:ships
    probDistrib(maxP0locInit(n))=maxP0valuesInit(n)*((1-betaRef(maxP0locInit(n),shipAlpha,searchCount))/...
        (1-probDistrib(n).*betaRef(n,shipAlpha,searchCount)));
end
