% k = 0:(N-1) = placeholder momentum
% actual momentum = k*(pi/2)
function [ActiveParents,RList]=findActiveParents(N,mz,k)
    tic
    % list of active parent states
    ActiveParents=[];
    % list of periodicities of active parents
    RList=[];
    % iterate over all possible states
    for i=0:(2^N -1)
        % check magnetisation of i
        if getSz(N,i)~=mz
            % Sz doesn't equal mz
            % move onto next i
            continue
        end
        % i has magnetisation mz
        % initialise periodicity R=-1 == not a parent state
        R=-1;
        for g=1:N
            % find integer of state after translating state i g times
            newState=cyclebits(i,g,N);
            if newState < i
                % i cannot be a parent, move to next i
                break
            elseif newState==i
                % arrived back at the initial state i
                % break out of for loop over g
                R=g;
                break
            end
        end
        % i must be a parent state
        % check if i is an active parent
        if R>0
            % get the orbit of the parent state
            orbit=getOrbit(i,R,N);
            % check if there is momentum k in the orbit
            if find(orbit(2,:)==k)
                ActiveParents=[ActiveParents i];
                RList=[RList R];
            end
        end
    end
    toc
end