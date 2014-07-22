function corrected = splitALS( I, features, vSize, hSize )
%UNTITLED2 Summary of this function goes here
%  (vSize, hSize) are the desired dimensions of a patch of M
%   I is a 2d matrix
lambda = 0.05;
maxIter = 30;

m = size(I,1);
n = size(I,2);
vPieces = nearest(m / vSize);
hPieces = nearest(n / hSize);
total = vPieces*hPieces;
vertical = partition(m, vPieces);
horizontal = partition(n, hPieces);

corrected = zeros(size(I));
wb = waitbar(0,'Progress');
for a = 1:numel(vertical)-1
    for b = 1:numel(horizontal)-1
        i = vertical(a);
        j = vertical(a+1)-1;
        k = horizontal(b);
        l = horizontal(b+1)-1;
        patch = I(i:j, k:l);
        [U, V] = ALSnoWait(patch, features, lambda, maxIter);
        corPatch = patchIm(patch,U*V');
        corrected(i:j,k:l) = corPatch;

        
        tick = ((a-1)*hPieces + b)/total;
        waitbar(tick, wb, 'Progress');
    end
end
corrected = uint8(corrected);
delete(wb);

end

