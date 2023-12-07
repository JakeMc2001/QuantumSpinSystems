% k - momentum in units of pi, multiplied by pi later in code
function H=fixedkHamiltonian(N,mz,k)
    % find parent states of mz block
    [parents,R]=findParentStatesMag(N,mz);
    % find child states and k values within mz block
    allStates=findMomentumStates(parents,R,N);
    % find states with the given k value
    kStates=allStates(:,allStates(2,:)==k);
    % preallocate memory for H
    [~,M]=size(kStates);
    H=zeros(M);
    for a=1:M
        Ra=kStates(3,a);
        s=kStates(1,a);
        k=kStates(2,a)*pi;
        abits=bitget(s,N:-1:1);
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
                % find l=num of translations of b to get a parent state
                [l,~]=findLj(b,parents);
                posb=find(kStates(1,:)==bin2dec(num2str(b)));
                if posb
                    Rb=kStates(3,posb);
                    H(a,posb)=H(a,posb)+ 1/2*(Ra/Rb)^(1/2) *exp(-i*k*l);
                end
            end
        end
    end
end