% generate the momentum hamiltonian for magnetisation mz
% ordered by k=0,pi/2,pi,3pi/2
function H=momentumHamiltonian(N,mz)
    % find parent states of mz block
    [parents,R]=findParentStatesMag(N,mz);
    % find child states and k values within mz block
    allStates=findMomentumStates(parents,R,N);
    [~,I]=sort(allStates(2,:));
    kStates=allStates(:,I);
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
                Rb=kStates(3,posb);
                H(a,posb)=H(a,posb)+ 1/2*(Ra/Rb)^(1/2) *exp(-i*k*l);
            end
        end
    end
end