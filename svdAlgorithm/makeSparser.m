function sparseM = makeSparser( M, P )
% M should be of type double. Can have any number of dimensions.
% Returns a version of M in which 100*P percent of the entries are NAN

sparseM = M;
toAlter = false(size(M));
total = numel(M);

if P < 0.5
    numPixels = nearest(P*total);
else
    numPixels = nearest((1-P)*total);
end

for i = 1:numPixels
    index = randi(total);
    while toAlter(index)
        index = randi(total);
    end
    toAlter(index) = true;
end

if ~(P < 0.5)
    toAlter = ~toAlter;
end

sparseM(toAlter) = 0;

end

