function [ U, V ] = ALSC(  R, k, epsilon, lambda, maxIter )
% Convergent ALS
% Performs the alternating least squares algorithm to approximate the
% singular value decomposition of R
%   R is a matrix of type double, where NAN entries are considered
%   unknown values
%   k is the number of features
%   epsilon is for testing RMSE convergence
%   lambda is the regularization constant, usually 0.05
%   maxIter is the maximum number of iterations to be performed
%       30 usually works well

Defined = ~isnan(R);
m = size(R,1);
n = size(R,2);

% Uniform entries in (0,1)
U = rand(m, k);

%Initialize the first column of U to the means, as suggested by
%  Zhou et al.
for i = 1:m
    row = R(i,:);
    U(i,1) = mean(row(Defined(i,:)));
end
%-----------------------------------%

V = zeros(n,k);
oldRMSE = RMSE(R(Defined));
rmseTest = 2*epsilon;
count = 0;
wb = waitbar(0,'Progress');
while rmseTest > epsilon && count < maxIter
    newU = zeros(size(U));
    newV = zeros(size(V));
    
    %Solve for V given U
    for i = 1:n
        col = R(:,i);
        defcol = Defined(:,i);
        if any(defcol) %Columns may contain no known entries
            A = U(defcol,:);
            Y = col(defcol);
            left = A'*A+lambda*eye(size(A,2));
            right = A'*Y;
            newV(i,:) = (left\right)';
        end
    end
    
    %Solve for U given V
    for j = 1:m
        col = R(j,:)';
        defcol = Defined(j,:)';
        if any(defcol)
            A = newV(defcol,:);
            Y = col(defcol);
            left = A'*A+lambda*eye(size(A,2));
            right = A'*Y;
            newU(j,:) = (left\right)';
        end
    end
    U = newU;
    V = newV;
    
    % Compute the change in RMSE
    pred = U*V';
    newRMSE = RMSE(R(Defined) - pred(Defined));
    rmseTest = abs(newRMSE - oldRMSE);
    oldRMSE = newRMSE;
    
    count = count + 1;
    tick = count / maxIter;
    waitbar(tick, wb, sprintf('%f%%', 100*tick));
end
delete(wb);

end

function [result] = RMSE(v)
result = sqrt(sumsqr(v)/numel(v));
end

