function proxyList = nearSet( M, i, j, k )
% Returns a list of the distances and values of the k nearest defined
% entries (defined = not nan) to the (i,j)th entry in matrix M
%   M is a matrix, possibly with some nan entries
%   i,j are valid indices
%   k < numel(M) is an integer

m = size(M,1);
n = size(M,2);
proxyList = zeros(k,2);
distance = 1;
index = 1;

while index <= k && distance <= max(m,n);
    top = i - distance;
    bottom = i + distance;
    left = j - distance;
    right = j + distance;
    yesTop = true;
    yesBottom = true;
    yesLeft = true;
    yesRight = true;
    if top < 1
        yesTop = false;
        top = 1;
    end
    if bottom > m
        yesBottom = false;
        bottom = m;
    end
    if left < 1
        yesLeft = false;
        left = 1;
    end
    if right > n
        yesRight = false;
        right = n;
    end
        
    
    if yesTop
        for h = left+1:right-1
            if index > k, break, end;
            if ~isnan(M(top, h))
                proxyList(index,1) = distance;
                proxyList(index,2) = M(top,h);
                index = index + 1;
            end
        end
    end
    if yesRight
        for v = top+1:bottom-1
            if index > k, break, end;
            if ~isnan(M(v,right))
                proxyList(index,1) = distance;
                proxyList(index,2) = M(v,right);
                index = index + 1;
            end
        end
    end
    if  yesBottom
        for h = left+1:right-1
            if index > k, break, end;
            if ~isnan(M(bottom,h))
                proxyList(index,1) = distance;
                proxyList(index,2) = M(bottom,h);
                index = index + 1;
            end
        end
    end
    if  yesLeft
        for v = top+1:bottom-1
            if index > k, break, end;
            if ~isnan(M(v,left))
                proxyList(index,1) = distance;
                proxyList(index,2) = M(v,left);
                index = index + 1;
            end
        end
    end
    
    if yesRight && yesTop && index <= k
        if ~isnan(M(top,right))
            proxyList(index,1) = distance;
            proxyList(index,2) = M(top,right);
            index = index + 1;
        end
    end
    if yesRight && yesBottom && index <= k
        if ~isnan(M(bottom,right))
            proxyList(index,1) = distance;
            proxyList(index,2) = M(bottom,right);
            index = index + 1;
        end
    end
    if yesLeft && yesTop && index <= k
        if ~isnan(M(top,left))
            proxyList(index,1) = distance;
            proxyList(index,2) = M(top,left);
            index = index + 1;
        end
    end
    if yesLeft && yesBottom && index <= k
        if ~isnan(M(bottom,left))
            proxyList(index,1) = distance;
            proxyList(index,2) = M(bottom,left);
            index = index + 1;
        end
    end
    
    distance = distance + 1;
end


end

