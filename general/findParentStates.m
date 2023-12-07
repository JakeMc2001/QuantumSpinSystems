% returns list of parent states
function [parents,periods]=findParentStates(N)
    states=0:(2^N -1);
    parents=[];
    periods=[];
    % iterate over all possible states
    for i=1:length(states)
        % a - current state integer
        a=states(i);
        % check that current state is != NaN
        if ~isnan(a)
            % abits - bit representation of current state int
            abits=bitget(a,N:-1:1);
            % call findPeriod() to obtain the set of parent and child
            % state ints
            [R,set]=findPeriod(abits);
            % eliminate set states from total state list
            for n=1:R
                states(states==set(n))=NaN;
            end
            % append the smallest state int to be to the parent array
            parents=[parents, min(set)];
            periods=[periods, R];
        end
    end

end