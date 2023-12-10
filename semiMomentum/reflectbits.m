% takes an integer s and number of spins N
% returns the integer result t of reflecting the bits of s
function t=reflectbits(s,N)
    tbits=bitget(s,1:N);
    t=bin2dec(num2str(tbits));
end