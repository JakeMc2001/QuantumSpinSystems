% generates a list of states
% and the full Hamiltonian in binary representation
% for a system of N spins
function [states,H]=fullBinaryHamiltonian(N)
    states=0:(2^N -1);
    H=zeros(2^N);
    for a=1:2^N
        abits=bitget(states(a),N:-1:1);
        for i=1:N
            j=findNextSpin(i+1,N);
            if abits(i)==abits(j)
                % spins the same
                H(a,a) = H(a,a) + 1/8;
            else
                % spins different
                H(a,a) = H(a,a) - 1/8;
                % flip spins
                b=flipSpins(abits,i,j);
                H(a,b+1)= 1/2;
            end
        end
    end
end