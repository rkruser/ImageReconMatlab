%% Add paths
addpath('../nearestNeighbor');
addpath('../svdAlgorithm');

%% Initialize parameters
imagePath = '../Images/beach.jpg'; 
writeType = 'nn';
writeIdentifier = 'beach'; % Set this to identify the image in the filename
writeDestination = '../Images/Processed/';
writeExtension = '.png'; %For lossless compression
isColor = false; % Don't forget to tell the program if the image is in color

sparsity = 0.7;
numPixels = 16;
writeFile = true;


%% Make the Image Sparse
M = double(imread(imagePath));
if isColor
    sparseM = makeSparse(M, sparsity);
    tic;
    Recon(:,:,1) = veryNaiveRecon(sparseM(:,:,1),numPixels);
    Recon(:,:,2) = veryNaiveRecon(sparseM(:,:,2),numPixels);
    Recon(:,:,3) = veryNaiveRecon(sparseM(:,:,3),numPixels);
    time = toc;
    Recon = uint8(Recon);
    sparseM(isnan(sparseM)) = 255;
    sparseM = uint8(sparseM);
else
    sparseM = makeSparse(M(:,:,1), sparsity);
    tic;
    Recon = veryNaiveRecon(sparseM, numPixels);
    time = toc;
    Recon = makeIm(Recon, Recon, Recon);
    sparseM(isnan(sparseM)) = 255;
    sparseM = makeIm(sparseM, sparseM, sparseM);
end

M = uint8(M);

[rmse, psnr] = psnrDb(M, Recon, 255);
image(Recon);

%% Write image
if writeFile
    sparseName = sprintf('%s%s %s %i sparse%s', writeDestination, ...
         writeType, writeIdentifier, 100*sparsity, writeExtension);
    reconName = sprintf('%s%s %s %i sparse %i nearest%s', ...
        writeDestination, writeType, writeIdentifier, 100*sparsity, ...
        numPixels, writeExtension);
    imwrite(sparseM, sparseName);
    imwrite(Recon, reconName);
end











