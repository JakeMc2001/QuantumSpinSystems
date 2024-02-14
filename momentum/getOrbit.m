% returns the orbit of a parent state
function orbit=getOrbit(parent,period,N)
    % orbit row 1 = state integers
    % orbit row 2 = k value for the integer
    orbit=zeros(2,period);
    orbit(1,1)=parent;
    % don't need to set k=0 for parent state - already 0
    for m=1:(period-1)
        % apply translation operator
        newState=cyclebits(parent,m,N);
        % assign new state in orbit to the storage matrix
        orbit(1,m+1)=newState;
        % calculate k value of current state (units pi/2)
        if period==N
            k=m;
        else
            k=N/period;
        end
        % assign k value to current state
        orbit(2,m+1)=k;
    end
end