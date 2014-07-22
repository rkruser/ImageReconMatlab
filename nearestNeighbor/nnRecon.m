%% Initialize parameters
imagePath = '../images/beach.jpg'; 
writeIdentifier = 'beach'; % Set this to identify the image in the filename
writeDestination = '../moreImages/';
writeExtension = '.png'; %For lossless compression
isColor = false; % Don't forget to tell the program if the image is in color
sparsity = 0.7;
kNearest = 16;

addpath('../code');

%% Naively reconstruct the image
M = double(imread(imagePath));
if isColor
    sparseM = makeSparse(M, sparsity);
    Rrecon = veryNaiveRecon(sparseM(:,:,1), kNearest);
    Grecon = veryNaiveRecon(sparseM(:,:,2), kNearest);
    Brecon = veryNaiveRecon(sparseM(:,:,3), kNearest);
    Final = makeIm(Rrecon, Grecon, Brecon);
    
    sparseM(isnan(sparseM)) = 255;
    sparseM = uint8(sparseM);
else
    sparseM = makeSparse(M(:,:,1), sparsity);
    recon = veryNaiveRecon(sparseM, kNearest);
    Final = makeIm(recon,recon,recon);
        
    sparseM(isnan(sparseM)) = 255;
    sparseM = makeIm(sparseM, sparseM, sparseM);
end

[rmse, psnr] = psnrDb(M, Final, 255); 
M = uint8(M);
image(Final);

%% Write files
sparseName = sprintf('%s%s %i sparse%s', writeDestination, ...
    writeIdentifier, 100*sparsity, writeExtension);
reconName = sprintf('%s%s %s %i sparse %i nearest%s', writeDestination, ...
    'naive', writeIdentifier, 100*sparsity, kNearest, writeExtension);
imwrite(sparseM, sparseName);
imwrite(Final, reconName);
