function [R,states]=findPeriod(s)
    R=0; %periodicity
    N=length(s);
    states=[bin2dec(num2str(s))]; %state list
    for i=1:N
        t=cyclebits(s,i);
        if t==s
            R=i;
            break
        else
            states=[states, bin2dec(num2str(t))];
        end
    end
end