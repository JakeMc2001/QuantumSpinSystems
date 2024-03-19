% findLj function for 24-site honeycomb lattice
function [lj,parent]=findLjH24(b,parents,ops)
    bInt=bin2dec(num2str(b));
    if findState(bInt,parents)==-1
        % iterate over all translations of spin sites
        for g=2:12
            bj=applyTranslation(bInt,24,ops(g,:));
            % search for current translation in parent list
            posb=findState(bj,parents);
            if posb~=-1
                % current translation is a parent state
                lj=g-1;
                parent=parents(posb);
                return
            end
        end
        % no translations of b are an active parent
        lj=-1;
        parent=bInt;
    else
        % b is an active parent
        lj=0;
        parent=bInt;
    end
end