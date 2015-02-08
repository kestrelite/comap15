%  Plane Search V0.2
%  executesearch.m
%  
%  flightpath

delete(findall(0, 'Type', 'Figure'))

netDiscoveryChance = 0;
distanceTraveled = 0;

discoveryChanceByIteration = zeros(10000);
searchIterations = 10000;
cells = 200;
cells2 = cells * cells;
%Set cells to the amount of cells per side of probability distribution

probDistrib = (abs(peaks(cells) / (sum(sum(abs(peaks(cells)))))));
figure(100); contour(probDistrib);
%probDistrib is initial probability distribution, representing the probability
%that the plane is in each cell.
%This command populates it with the peaks data set of size
%cells x cells and converts it to a probability distribution
%(sum of all elements = 1)

ships=10;
shipLocMatrix=zeros(cells);
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
    shipLocMatrix(maxProbabilityPos) = 1;
    initialShipDistrib(maxProbabilityPos) = 0;
    shipLocations(n) = maxProbabilityPos;
end

%This loop places the ships in the cells with the highest probability
%of conducting a successful search.
%It stores the maximum initial probDistrib values in the vector maxP0valuesInit
%and the original location of those values in the vector maxP0locInit

%First iteration under assumption of failure

for searchNum=1:searchIterations
    searchCount = searchCount + shipLocMatrix;
    betaMat = shipAlpha * ((1 - shipAlpha) .^ searchCount);    
    for n=1:ships
        shipLoc = shipLocations(n);
        netDiscoveryChance = netDiscoveryChance + betaMat(shipLoc)*probDistrib(shipLoc);
        tmpProbDist = probDistrib .* (1 / (1 - betaMat(shipLoc)*probDistrib(shipLoc)));
        tmpProbDist(shipLoc) = probDistrib(shipLoc) * ((1 - betaMat(shipLoc))/(1-probDistrib(shipLoc)*betaMat(shipLoc)));
        probDistrib = tmpProbDist;
    end
    
    newShipLocations = zeros(1,ships);
    newShipLocMatrix = zeros(cells,cells);
    for n=1:ships
        distanceMatrix = zeros(cells, cells);
        shipRow = mod(shipLocations(n)-1, cells)+1; % Gets row based on single-dimension coord
        shipCol = (shipLocations(n)-shipRow)/cells+1; % Gets col based on single-dimension coord
        for epRow=1:cells
            for epCol=1:cells
                distanceMatrix(epRow, epCol) = sqrt((shipRow - epRow)^2+(shipCol - epCol)^2);
                if distanceMatrix(epRow, epCol) == 0
                    distanceMatrix(epRow, epCol) = Inf;
                end
            end
        end
        
        perShipEpsilon = (probDistrib ./ distanceMatrix);
        %perShipEpsilon = probDistrib;
        perShipEpsilon = betaMat .* perShipEpsilon;
        perShipEpsilon = (1 - newShipLocMatrix) .* perShipEpsilon;
        
        maxProbabilityPos = find(perShipEpsilon == max(perShipEpsilon(:)));
        newShipLocMatrix(maxProbabilityPos) = 1;
        newShipLocations(n) = maxProbabilityPos;

        newShipRow = mod(maxProbabilityPos-1, cells) + 1;
        newShipCol = (shipLocations(n)-shipRow)/cells + 1;
        distanceTraveled = distanceTraveled + sqrt((shipRow - newShipRow)^2 + (shipCol - newShipCol)^2);
        
        if searchNum == searchIterations 
            %figure(n); contour(perShipEpsilon);
        end
    end
    
    shipLocations = newShipLocations;
    shipLocMatrix = newShipLocMatrix;
    %disp(netDiscoveryChance);
    discoveryChanceByIteration(searchNum) = netDiscoveryChance;
end
figure(ships+1); contour(probDistrib);
figure(ships+2); HeatMap(searchCount);
disp(netDiscoveryChance);
disp(distanceTraveled);