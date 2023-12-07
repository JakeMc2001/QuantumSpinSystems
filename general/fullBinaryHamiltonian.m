% generates a list of states
% and the full Hamiltonian in binary representation
% for a system of N spins
% Note - doesn't give the correct Hamiltonian for N=2
% due to adding the diagonal elements twice
function [states,H]=fullBinaryHamiltonian(N)
    tic
    states=0:(2^N -1);
    H=zeros(2^N);
    for a=1:2^N
        abits=bitget(states(a),N:-1:1);
        for i=1:N
            j=findNextSpin(i+1,N);
            if abits(i)==abits(j)
                % spins the same
                H(a,a) = H(a,a) + 1/4;
            else
                % spins different
                H(a,a) = H(a,a) - 1/4;
                % flip spins
                b=flipSpins(abits,i,j);
                b=bin2dec(num2str(b));
                H(a,b+1)= 1/2;
            end
        end
    end
    toc
end