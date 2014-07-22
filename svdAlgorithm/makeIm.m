function G = makeIm( M, N, O )
% Uses M, N, O to an image matrix G capable of being
% interpreted by the matlab "image" function
% M, N, O should be the same size
G(:,:,1) = M;
G(:,:,2) = N;
G(:,:,3) = O;
G = uint8(G);
end

