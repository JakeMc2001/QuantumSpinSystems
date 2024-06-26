% cycles bits of integer i to the left by n permutations
% i - bit representation of integer i
function j=cyclebits(i,n,N)
    i=bitget(i,N:-1:1);
    j=i; % new state after permutation
    if n~=0
        for m=1:n
            % move all bits one to the left
            tmp=j(1);
            j(1:N-1)=j(2:N);
            j(N)=tmp;
        end
    end
    j=bin2dec(num2str(j));
end