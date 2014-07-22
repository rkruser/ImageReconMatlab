%% Add paths
addpath('../nearestNeighbor');

%% Initialize parameters
imagePath = '../Images/beach.jpg'; 
writeType = 'nn';
writeIdentifier = 'beach'; % Set this to identify the image in the filename
writeDestination = '../Images/Processed/';
writeExtension = '.png'; %For lossless compression
isColor = false; % Don't forget to tell the program if the image is in color

%% 