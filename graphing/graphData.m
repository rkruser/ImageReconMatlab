function [sparseAxis, featureAxis] = graphData( cellData, start, skip )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
num = numel(cellData);
sparseAxis = start:skip:start+skip*(num-1);
featureAxis = zeros(1,num);
for i = 1:num
    tic = cellData{i};
    [C, I] = min(tic(:,2));
    featureAxis(i) = tic(I,1);
end
%scatter(sparseAxis, featureAxis);

end

