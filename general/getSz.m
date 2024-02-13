% returns the Sz value of state s
function Sz=getSz(N,s)
    % get bit representation of s
    sa=bitget(s,N:-1:1);
    % number of spins up (1 in bit rep)
    nUp=sum(sa);
    % calculate magnetisation value
    Sz= nUp - N/2;
end