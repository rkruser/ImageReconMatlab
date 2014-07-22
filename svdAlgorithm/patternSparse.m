function out = patternSparse( M )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

out = M;
for i=1:size(out,3)
    for j = 1:size(out,1)
        offset = mod(j,2);
        for k=1:2:size(out,2)
            out(j, k+offset, i) = nan;
        end
    end
end


end

