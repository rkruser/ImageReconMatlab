lambda = 0.05;
maxIter = 30;
maxDev = 255;

M = double(imread('../images/einstein.jpg'));
sparseM = makeSparse(M(:,:,1), 0.2);

result = zeros(18,3);
for features = 10:10:90
    [U, V] = ALS(sparseM, features, lambda, maxIter);
    patch = uint8(patchIm(sparseM, U*V'));
    [rmse, psnr] = psnrDb(M(:,:,1), patch, maxDev);
    index = features / 10
    result(index, 1) = features;
    result(index, 2) = rmse;
    result(index, 3) = psnr;
end

for features = 100:50:500
    [U, V] = ALS(sparseM, features, lambda, maxIter);
    patch = uint8(patchIm(sparseM, U*V'));
    [rmse, psnr] = psnrDb(M(:,:,1), patch, maxDev);
    index = 10 + (features - 100) / 50
    result(index, 1) = features;
    result(index, 2) = rmse;
    result(index, 3) = psnr;
end