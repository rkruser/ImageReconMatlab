%% Initialize parameters
imagePath = '../svdImages/beach.jpg'; 
writeIdentifier = 'beach'; % Set this to identify the image in the filename
writeDestination = '../svdImages/Processed/';
writeExtension = '.png'; %For lossless compression
isColor = false; % Don't forget to tell the program if the image is in color
sparsity = 0.7;
features = 20;
lambda = 0.05;
maxIter = 30;

%% Make the image sparse and reconstruct it
M = 1+double(imread(imagePath));
if isColor
    sparseM = sparse(makeSparser(M, sparsity));
    tic;
    [UR, VR] = ALSsparse(sparseM(:,:,1), features, lambda, maxIter);
    t1 = toc;
    [UG, VG] = ALSsparse(sparseM(:,:,2), features, lambda, maxIter);
    t2 = toc;
    [UB, VB] = ALSsparse(sparseM(:,:,3), features, lambda, maxIter);
    t = toc;
    patchR = patchsparseIm(sparseM(:,:,1), UR*VR');
    patchG = patchsparseIm(sparseM(:,:,2), UG*VG');
    patchB = patchsparseIm(sparseM(:,:,3), UB*VB');
    Final = makeIm(patchR-1, patchG-1, patchB-1); % The reconstruction
    sparseM = full(sparseM);
    sparseM(sparseM==0) = 256; %Set unknown pixels to max brightness
    sparseM = sparseM - 1;
    sparseImage = uint8(sparseM); % Make a viewable sparse image
else
   sparseM = sparse(makeSparser(M(:,:,1), sparsity));
   tic;
   [U, V] = ALSsparse(sparseM, features, lambda, maxIter);
   t = toc;
   patch = patchsparseIm(sparseM, U*V');
   Final = makeIm(patch-1, patch-1, patch-1);
   
   sparseM = full(sparseM);
   sparseM(sparseM==0) = 256;
   sparseImage = makeIm(sparseM-1, sparseM-1, sparseM-1);
end
M = uint8(M-1); % In case you want to view M from Matlab
image(Final); % Display the reconstructed image

% Compute the rmse and the peak signal to noise ratio in decibels
% The lower the rmse and the higher the psnr, the better the reconstruction
[rmse, psnr] = psnrDb(M, Final, 255); 
%% Write the files
% sparseName = sprintf('%s%s %i sparse%s', writeDestination, ...
%     writeIdentifier, 100*sparsity, writeExtension);
% reconName = sprintf('%s%s %i sparse %i features%s', writeDestination, ...
%     writeIdentifier, 100*sparsity, features, writeExtension);
% imwrite(sparseImage, sparseName);
% imwrite(Final, reconName);











