function recon = veryNaiveRecon( M, k )
%Fills in missing pixels by averaging the k nearest pixels

m = size(M, 1);
n = size(M, 2);
recon = M;

wb = waitbar(0,'Progress');
for i=1:m
    for j=1:n
        if isnan(M(i,j))
            nearest = nearSet(M,i,j,k);
            recon(i,j) = mean(nearest(:,2));
        end
    end
    tick = i/m;
    waitbar(tick, wb, 'progress');
end
delete(wb);

end

