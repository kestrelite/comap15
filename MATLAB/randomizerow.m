function r=randomizerow(columns,min,max)
%columns = #columns
%min = minimum value of output
%max = maximum value of output
    r=(max-min).*rand(1,columns) + min;

end

