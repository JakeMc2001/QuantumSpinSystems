function orbit=getOrbit(parent,period)
    % orbit row 1 = state integers
    % orbit row 2 = k value for the integer
    orbit=zeros(2,period);
    orbit(1,1)=bin2dec(num2str(parent));
    % don't need to set k=0 for parent state - already 0
    for m=1:(period-1)
        % apply translation operator
        newState=cyclebits(parent,m);
        % assign new state in orbit to the storage matrix
        orbit(1,m+1)=bin2dec(num2str(newState));
        % calculate k value of current state (units pi)
        k=(2*m)/period;
        % assign k value to current state
        orbit(2,m+1)=k;
    end
end