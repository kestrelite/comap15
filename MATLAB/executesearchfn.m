function [netDiscoveryChance, distanceTraveled, numCellsSearched] = executesearchfn(searchIterations, shipCount, shipAlpha)

% Text comments removed in deference to code comments

% delete(findall(0, 'Type', 'Figure'))

netDiscoveryChance = 0;
distanceTraveled = 0;

cells = 80;
%searchIterations = 100; % Now a parameter
discoveryChanceByIteration = zeros(searchIterations);

probDistrib = (abs(peaks(cells) / (sum(sum(abs(peaks(cells)))))));
%figure(100); contour(probDistrib);

%shipCount=10; % Now a parameter
shipLocMatrix=zeros(cells);

searchCount=zeros(cells);
%shipAlpha = 0.45; % Now a parameter

initialShipDistrib = probDistrib;
shipLocations=zeros(1,shipCount);

%Gets positions of highest in array
tmp1 = unique(probDistrib(:));
highVals = tmp1(end-shipCount:end);
maxPosArray = ismember(probDistrib, highVals);
maxPositions = find(maxPosArray == 1);
for n=1:shipCount
    maxProbabilityPos = maxPositions(n);
    shipLocMatrix(maxProbabilityPos) = 1;
    initialShipDistrib(maxProbabilityPos) = 0;
    shipLocations(n) = maxProbabilityPos;
end
%Search iterations! (under assumption of failure)

for searchNum=1:searchIterations
    searchCount = searchCount + shipLocMatrix;
    betaMat = shipAlpha * ((1 - shipAlpha) .^ searchCount);    
    for n=1:shipCount
        shipLoc = shipLocations(n);
        netDiscoveryChance = netDiscoveryChance + betaMat(shipLoc)*probDistrib(shipLoc);
        tmpProbDist = probDistrib .* (1 / (1 - betaMat(shipLoc)*probDistrib(shipLoc)));
        tmpProbDist(shipLoc) = probDistrib(shipLoc) * ((1 - betaMat(shipLoc))/(1-probDistrib(shipLoc)*betaMat(shipLoc)));
        probDistrib = tmpProbDist;
    end
    
    newShipLocations = zeros(1,shipCount);
    newShipLocMatrix = zeros(cells,cells);
    for n=1:shipCount
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
        %perShipEpsilon = probDistrib; % Alternately, ignore distance
        perShipEpsilon = betaMat .* perShipEpsilon;
        perShipEpsilon = (1 - newShipLocMatrix) .* perShipEpsilon;
        
        maxProbabilityPos = find(perShipEpsilon == max(perShipEpsilon(:)));
        newShipLocMatrix(maxProbabilityPos) = 1;
        newShipLocations(n) = maxProbabilityPos;

        newShipRow = mod(maxProbabilityPos-1, cells) + 1;
        newShipCol = (shipLocations(n)-shipRow)/cells + 1;
        distanceTraveled = distanceTraveled + sqrt((shipRow - newShipRow)^2 + (shipCol - newShipCol)^2);
        
        %if searchNum == searchIterations 
            %figure(n); contour(perShipEpsilon);
        %end
    end
    
    shipLocations = newShipLocations;
    shipLocMatrix = newShipLocMatrix;
    %disp(netDiscoveryChance);
    discoveryChanceByIteration(searchNum) = netDiscoveryChance;
end

numCellsSearched = sum(size(find(searchCount >= 1)))-1;
%figure(shipCount+1); contour(probDistrib);
%figure(shipCount+2); HeatMap(searchCount);
%disp(netDiscoveryChance);
%disp(distanceTraveled);