% takes an integer s and number of spins N
% returns the integer result t of reflecting the bits of s
function t=reflectbits(s,N)
    t=bitget(s,1:N);
end