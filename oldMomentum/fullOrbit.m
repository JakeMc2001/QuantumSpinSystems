function orbit=fullOrbit(parent,N)
    orbit=zeros(2,N);
    orbit(1,1)=parent;
    % don't need to set k=0 for parent state - already 0
    for m=1:(N-1)
        % apply translation operator
        newState=cyclebits(parent,m,N);
        % assign new state in orbit to the storage matrix
        orbit(1,m+1)=newState;
        % calculate k value of current state (units pi)
        k=(2*m)/N;
        % if k>1
        %     k=k-2;
        % end
        % assign k value to current state
        orbit(2,m+1)=k;
    end
end