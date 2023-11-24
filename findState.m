function b=findState(target,states)
    M=length(states);
    bmin=1;
    bmax=M;
    counter=0;
    while counter<M
        counter=counter+1;
        % set value of b as the middle position
        if mod(bmax-bmin,2)==0
            b=bmin+(bmax-bmin)/2;
        else
            b=bmin+(bmax-bmin-1)/2;
        end
        if target<states(b)
            bmax=b-1;
            if bmax<=0
                bmax=1;
            end
        elseif target>states(b)
            bmin=b+1;
            if bmin>length(states)
                bmin=length(states);
            end
        else
            return
        end
    end
    if counter==M
        b=NaN;
    end
end