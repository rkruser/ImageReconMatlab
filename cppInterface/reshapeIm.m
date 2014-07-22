function shuffle = reshapeIm( M, dim1, dim2, dim3 )
%UNTITLED Summary of this function goes here
%   dim1, dim2, dim3 should be true dimensions
M = reshape(M, dim2, dim1, dim3);
shuffle(:,:,1) = M(:,:,1)';
shuffle(:,:,2) = M(:,:,2)';
shuffle(:,:,3) = M(:,:,3)';
shuffle = uint8(shuffle);

end

