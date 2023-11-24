% this function generates a block Hamiltonian
% for a fixed magnetisation value mz
function [states,H]=fixedMagHamiltonian(N,mz)
    states=genMagStates(N,mz);
    M=length(states);
    H=zeros(M);
    for a=1:M
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
                % find the position of the flipped state
                b=findState(b,states);
                H(a,b)= 1/2;
            end
        end
    end
end