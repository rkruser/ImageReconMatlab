%%Oldtic
lambda = 0.05;
maxIter = 30;
maxDev = 255;
M = double(imread('../images/einstein.jpg'));
results = cell(1,19);
for sparsity = 5:5:95
    sparsity
    sparseM = makeSparse(M(:,:,1), sparsity / 100);
    data = zeros(20,3);
    for features = 5:5:100
        features
        [U,V] = ALS(sparseM, features, lambda, maxIter);
        patch = uint8(patchIm(sparseM, U*V'));
        [rmse, psnr] = psnrDb(M(:,:,1), patch, maxDev);
        index = features / 5;
        data(index,1) = features;
        data(index,2) = rmse;
        data(index,3) = psnr;
    end
    cellIndex = sparsity / 5;
    results{cellIndex} = data;
end

%% Newtic
sparseAxis = 5:5:95;
featureAxis = zeros(1,19);
for i = 1:19
    tic = results{i};
    [C, I] = min(tic(:,2));
    featureAxis(i) = tic(I,1);
end
scatter(sparseAxis, featureAxis);