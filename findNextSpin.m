% finds the next spin, taking into account
% the periodic boundary conditions
function x=findNextSpin(x,N)
    if x>N
        x=x-N;
    end
end