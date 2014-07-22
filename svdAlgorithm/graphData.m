function [sparseAxis, featureAxis] = graphData( cellData, start, skip )
% Graphs cell array minima
%   Given a cell array of data in the relevant format, 
%    extracts the minimum relevant value in each array
%    Returns sparseAxis, the sparsity values
%    Returns featureAxis, the optimal feature counts associated
%    This function is not friendly to outside users because it requires
%       implementation knowledge to use
num = numel(cellData);
sparseAxis = start:skip:start+skip*(num-1);
featureAxis = zeros(1,num);
for i = 1:num
    tic = cellData{i};
    [C, I] = min(tic(:,2));
    featureAxis(i) = tic(I,1);
end

end

