addpath('../../iminf/textimages/');
addpath('images');

file = 'sparse.txt';
compareTo = 'beach.jpg';
f = fopen(file);
testIm = fscanf(f,'%u');
fclose(f);
Im = imread(compareTo);
sizeOfIm = size(Im);
testIm = reshapeIm(testIm, sizeOfIm(1), sizeOfIm(2), sizeOfIm(3));

image(testIm);