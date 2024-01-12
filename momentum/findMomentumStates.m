% find the states and periodicities from the given parent states which have
% the given k value
function [states,R]=findMomentumStates(parents,periods,k,N)
    n=length(parents);
    states=[];
    R=[];
    for i=1:n
        currentParent=parents(i);
        orbit=getOrbit(currentParent,periods(i),N);
        %orbit=fullOrbit(currentParent,N);
        [~,orbitSize]=size(orbit);
        for j=1:orbitSize
            if orbit(2,j)==k
                states=[states orbit(1,j)];
                R=[R periods(i)];
            end
        end
    end
end