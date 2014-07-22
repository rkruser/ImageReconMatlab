%% Initialize parameters
imagePath = '../images/einstein.jpg'; 
writeIdentifier = 'einstein'; % Set this to identify the image in the filename
writeDestination = '../images/';
writeExtension = '.png'; %For lossless compression
isColor = false; % Don't forget to tell the program if the image is in color
sparsity = 0.7;
features = 15;
lambda = 0.05;
maxIter = 30;

%% Make the image sparse and reconstruct it
M = double(imread(imagePath));
if isColor
    sparseM = makeSparse(M, sparsity);
    tic;
    [UR, VR] = ALS(sparseM(:,:,1), features, lambda, maxIter);
    t1 = toc;
    [UG, VG] = ALS(sparseM(:,:,2), features, lambda, maxIter);
    t2 = toc;
    [UB, VB] = ALS(sparseM(:,:,3), features, lambda, maxIter);
    t = toc;
    patchR = patchIm(sparseM(:,:,1), UR*VR');
    patchG = patchIm(sparseM(:,:,2), UG*VG');
    patchB = patchIm(sparseM(:,:,3), UB*VB');
    Final = makeIm(patchR, patchG, patchB); % The reconstruction
    sparseM(isnan(sparseM)) = 255; %Set unknown pixels to max brightness
    sparseImage = uint8(sparseM); % Make a viewable sparse image
else
   sparseM = makeSparse(M(:,:,1), sparsity);
   tic;
   [U, V] = ALS(sparseM, features, lambda, maxIter);
   t = toc;
   patch = patchIm(sparseM, U*V');
   Final = makeIm(patch, patch, patch);
   
   sparseM(isnan(sparseM)) = 255;
   sparseImage = makeIm(sparseM, sparseM, sparseM);
end
M = uint8(M); % In case you want to view M from Matlab
image(Final); % Display the reconstructed image

% Compute the rmse and the peak signal to noise ratio in decibels
% The lower the rmse and the higher the psnr, the better the reconstruction
[rmse, psnr] = psnrDb(M, Final, 255); 
%% Write the files
sparseName = sprintf('%s%s %i sparse%s', writeDestination, ...
    writeIdentifier, 100*sparsity, writeExtension);
reconName = sprintf('%s%s %i sparse %i features%s', writeDestination, ...
    writeIdentifier, 100*sparsity, features, writeExtension);
imwrite(sparseImage, sparseName);
imwrite(Final, reconName);











