lambda = 0.05;
maxIter = 30;
maxDev = 255;
M = double(imread('../images/boats.jpg'));
results = cell(1,6);
for sparsity = 15:15:90
    sparsity
    sparseM = makeSparse(M, sparsity / 100);
    data = zeros(20,3);
    for features = 5:5:100
        features
        [UR,VR] = ALS(sparseM(:,:,1), features, lambda, maxIter);
        [UG, VG] = ALS(sparseM(:,:,2), features, lambda, maxIter);
        [UB, VB] = ALS(sparseM(:,:,3), features, lambda, maxIter);
        patchR = patchIm(sparseM(:,:,1), UR*VR');
        patchG = patchIm(sparseM(:,:,2), UG*VG');
        patchB = patchIm(sparseM(:,:,3), UB*VB');
        patch = makeIm(patchR, patchG, patchB);
        [rmse, psnr] = psnrDb(M, patch, maxDev);
        index = features / 5;
        data(index,1) = features;
        data(index,2) = rmse;
        data(index,3) = psnr;
    end
    cellIndex = sparsity / 15;
    results{cellIndex} = data;
end
