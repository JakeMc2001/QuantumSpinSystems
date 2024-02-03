function [repStates,R]=genBasisStates(N,mz,k)
    % find states with given magnetisation
    states=genMagStates(N,mz);
    % list to representatives
    repStates=[];
    % list to store R values
    R=[];
    % loop over all possible states
    for i=1:length(states)
        % s = current state
        s=states(i);
        % check if state is a valid representative
        Ra=checkstate(s,N,k);
        if Ra>=0
            repStates=[repStates s];
            R=[R Ra];
        end
    end
end