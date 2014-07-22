Reconstructing Images using Singular Value Decomposition:
A Directed Research Project

Ryen Krusinga and Igor L. Markov

-----------------------------------

This project uses the alternating least squares algorithm
to reconstruct images that are missing pixels. The only
file the user needs to directly interact with is example.m.

Files and Folders:

README

COPYRIGHT - Copyright information

images - The default folder for loading images and saving
	 results. Should already contain two images, "beach"
	 and "boats"

code - a folder containing the following Matlab files:

example.m - a script that can be used to run the algorithm
            on images and save the results

ALS.m  - The file implementing the alternating least
	 squares algorithm.

makeSparse.m - Removes pixels from a full image

patchIm.m - Fills in the sparse image

makeIm.m - Makes an image matrix from its inputs

psnrDb.m - Calculates the peak signal to noise ratio, in 
	   decibels (dB), between two images
