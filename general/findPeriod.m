function [R,states]=findPeriod(s)
    R=0; %periodicity
    N=length(s);
    sInt=bin2dec(num2str(s));
    states=sInt; %state list
    for i=1:N
        t=cyclebits(s,i,N);
        if t==sInt
            R=i;
            break
        else
            states=[states, t];
        end
    end
end