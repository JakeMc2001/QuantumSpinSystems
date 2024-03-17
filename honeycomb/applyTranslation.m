% translate spins in initial state i to the newPosition in j
function j=applyTranslation(i,N,newPosition)
    % obtain bit representation of initial state i
    i=bitget(i,N:-1:1);
    % allocate new state j
    j=zeros(1,N);
    for m=1:N
        j(newPosition(m)+1)=i(m);
    end
    j=bin2dec(num2str(j));
end