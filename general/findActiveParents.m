% finds the active parent states from the array of
% parent integer states
function [active,periods]=findActiveParents(N,mz,k)
    % get the array of parent states in mz block
    [parents,R]=findParentStatesMag(N,mz);
    % array to store active parents
    active=[];
    % array to store periodicities of active parents
    periods=[];
    % iterate over array of parents
    for i=1:length(parents)
        % obtain the orbit (parent and child states)
        orbit=getOrbit(parents(i),R(i),N);
        [~,orbitSize]=size(orbit);
        % iterate over the states in the orbit to check for
        % states with the given k momentum
        for j=1:orbitSize
            % if the parent has a child state with k value, it is active
            if orbit(2,j)==k
                active=[active parents(i)];
                periods=[periods R(i)];
            end
        end
    end
end