function [reconIm, svdIm, rmse1, rmse2] = naiveReconstruct( sparseIm, p, ...
features, k )
%Naively reconstruct the sparse image sparseIm
%   sparseIm is 2d of type double and is sparse
reconIm = veryNaiveRecon(sparseIm, k);
[rmse1, blah] = psnrDb(M2, uint8(reconIm), 255);
reconIm = makeIm(reconIm, reconIm, reconIm);

[ U, V] = ALS(sparseIm, features, 0.05, 30);
med = patchIm(sparseIm, U*V');
[rmse2, blah] = psnrDb(M2, uint8(med), 255);
svdIm = makeIm(med, med, med);
end

