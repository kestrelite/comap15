%  Plane Search V0.2
%  executesearch.m
%  
%  flightpath

cells=51;
%Set cells to the amount of cells per side of probability distribution

P0=(abs(peaks(cells)/(sum(sum(abs(peaks(cells)))))));
%P0 is initial probability distribution.
%This command populates it with the peaks data set of size
%cells x cells and converts it to a probability distribution
%(sum of all elements = 1)

ships=10;
shipPos=zeros(cells);
%ships = # of ships searching
%Initiliazes matrix shipPos;
%shipPos tracks the position of each ship

searchMat=zeros(cells);
%Initializes matrix searchMat;
%searchMat tracks the number of times each cell has been searched

