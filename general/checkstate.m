% probably equivalent to using the character table
function R=checkstate(s,N,k)
    R=-1;
    % find periodicities
    for i=1:N
        t=cyclebits(s,i,N);
        if t<s
            continue
        elseif t==s
            if mod(k,N/i)~=0
                continue
            else
                R=i;
                break
            end
        end
    end
end