function [R,m]=checkstate(s,N)
    R=0;
    % find periodicities
    for i=1:N
        t=cyclebits(s,i,N);
        if t==s
            R=i;
            break
        end
    end
    m=-1;
    t=reflectbits(s,N);
    for i=0:(R-1)
        % find m value
        if t==s
            m=i;
            break
        end
        t=cyclebits(t,1,N);
        bitget(t,N:-1:1);
    end
end