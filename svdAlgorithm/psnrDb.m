function [rmse, psnr] = psnrDb( imOriginal, imCorrected, max_pixel_value )
%Computes the root mean squared error and the peak signal to noise ratio in
%decibels of the corrected image
%   maxDev is usually 255, the maximum pixel value
%   This works for color images as well as black and white images
diff = double(imCorrected) - double(imOriginal);
sumTotal = sum(sum(sum(diff.*diff)));
rmse = sqrt(sumTotal / numel(diff));
psnr = 20*log10(max_pixel_value / rmse);
end

