function indices = partition( length, pieces )
indices = 1:(length/pieces):(length+1);
indices = nearest(indices);
indices(numel(indices)) = length + 1;
end

