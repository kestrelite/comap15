%  Plane Search V0.2
%  executesearch.m
%  
%  flightpath

cells = 150;
cells2 = cells * cells;
%Set cells to the amount of cells per side of probability distribution

probDistrib = (abs(peaks(cells) / (sum(sum(abs(peaks(cells)))))));
%probDistrib is initial probability distribution, representing the probability
%that the plane is in each cell.
%This command populates it with the peaks data set of size
%cells x cells and converts it to a probability distribution
%(sum of all elements = 1)

ships=56;
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
shipLocations=zeros(1,ships);
for n=1:ships
    maxProbabilityPos = find(initialShipDistrib == max(initialShipDistrib(:)));
    shipPos(maxProbabilityPos) = 1;
    initialShipDistrib(maxProbabilityPos) = 0;
    shipLocations(n) = maxProbabilityPos;
end

%This loop places the ships in the cells with the highest probability
%of conducting a successful search.
%It stores the maximum initial probDistrib values in the vector maxP0valuesInit
%and the original location of those values in the vector maxP0locInit

betaMat = shipAlpha * ((1 - shipAlpha) .^ searchCount);
betaMat;

epsilonMatNoCost = probDistrib .* betaMat;

% Then, assume searching has failed.

for n=1:ships
    shipLoc = shipLocations(n);
    tmpProbDist = probDistrib .* (1 / (1 - betaMat(shipLoc)*probDistrib(shipLoc)));
    tmpProbDist(shipLoc) = probDistrib(shipLoc) * ((1 - betaMat(shipLoc))/(1-probDistrib(shipLoc)*betaMat(shipLoc)));
    probDistrib = tmpProbDist;
end

