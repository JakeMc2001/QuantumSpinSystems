% finds lj=num of translations of b to reach a parent state
% and the parent state to represent b
function [lj,parent]=findLj(b,parents)
    bInt=bin2dec(num2str(b));
    N=length(b);
    if findState(bInt,parents)==-1
        % b is not a parent state
        % iterate over all ways to cycle bits of b
        for i=1:N
            bj=cyclebits(bInt,i,N);
            % search for current cycle in parent list
            posb=findState(bj,parents);
            if posb~=-1
                % current cycle is a parent state
                lj=i;
                parent=parents(posb);
                return
            end
        end
        % no cycles of b are a parent state
        lj=-1;
        parent=bInt;
    else
        % b is a parent state
        lj=0;
        parent=bInt;
    end
end