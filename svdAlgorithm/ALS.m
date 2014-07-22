function [ U, V ] = ALS( R, k, lambda, maxIter )
% Performs the alternating least squares algorithm to approximate the
% singular value decomposition of R
%   R is a matrix of type double, where NAN entries are considered
%   unknown values
%   k is the number of features
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
    U(i,1) = mean(R(i,Defined(i,:)));
end
%-----------------------------------%

V = zeros(n,k);
count = 0;
wb = waitbar(0,'Progress');
while count < maxIter
    newU = zeros(size(U));
    newV = zeros(size(V));
    
    % Solve for V given U
    for i = 1:n
        defcol = Defined(:,i);
        if any(defcol) %Columns may contain no known entries
            A = U(defcol,:);
            Y = R(defcol,i);
            left = A'*A+lambda*eye(size(A,2));
            right = A'*Y;
            newV(i,:) = (left\right)';
        end
    end
    
    % Solve for U given V
    for j = 1:m
        defrow = Defined(j,:);
        if any(defrow)
            A = newV(defrow,:);
            Y = R(j,defrow)';
            left = A'*A+lambda*eye(size(A,2));
            right = A'*Y;
            newU(j,:) = (left\right)';
        end
    end
    
    U = newU;
    V = newV; 
    count = count + 1;
    tick = count / maxIter;
    waitbar(tick, wb, sprintf('%f%%', 100*tick));
end
delete(wb);

end
