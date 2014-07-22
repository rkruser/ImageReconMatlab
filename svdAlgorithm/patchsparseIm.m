function corrected = patchsparseIm( M, P )
%Combines the sparse image M with its predicted completion, P
corrected = full(M);
holes = ~M;
corrected(holes) = P(holes);
end

