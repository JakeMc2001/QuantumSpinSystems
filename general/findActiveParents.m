% k = 0:(N-1) = placeholder momentum
% actual momentum = k*(pi/2)
function [ActiveParents,RList]=findActiveParents(N,mz,k)
    % list of parent states
    ActiveParents=[];
    % list of periodicities
    RList=[];
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
            % find integer of state produced by translating i g times
            newState=cyclebits(i,g,N);
            if newState < i
                % i cannot be a parent, move to next i
                %Mk=0;
                break
            elseif newState==i
                %Mk=Mk+charTable(k+1,g-1);
                R=g;
                break
            end
        end
        % i must be a parent state
        % check if i is an active parent
        if R>0
            orbit=getOrbit(i,R,N);
            if find(orbit(2,:)==k)
                ActiveParents=[ActiveParents i];
                RList=[RList R];
            end
        end
    end
end