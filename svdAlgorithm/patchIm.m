function corrected = patchIm( M, P )
%Combines the sparse image M with its predicted completion, P
corrected = M;
holes = isnan(M);
corrected(holes) = P(holes);
end

