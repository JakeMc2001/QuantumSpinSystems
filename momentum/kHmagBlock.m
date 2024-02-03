% aiming to produce mz block containing all 
% k values for a given mz value
% to fix Hamiltonian issues
function H=kHmagBlock(N,mz)
    % generate list of k values
    m=0:N-1;
    kValues=(2/N)*m;
    % generate list of states with mz
    statesList=genMagStates(N,mz);
    [~,M]=size(statesList);
    % preallocate matrix for Hamiltonian
    H=zeros(M);
    % loop over k values
    for ki=1:length(kValues)
        % current k value
        k=kValues(ki);
        % find active parents
        [activeParents,periods]=findActiveParents(N,mz,k);
        % find states with current k value
        [kStates,R]=findMomentumStates(activeParents,periods,k,N);
        [~,numOfkStates]=size(kStates);
        % re-assign k value for use in calculations
        k=k*pi;
        for a=1:numOfkStates
            % period of current state
            Ra=R(a);
            % s = current state
            s=kStates(a);
            % get bit representation of s
            sbits=bitget(s,N:-1:1);
            % find position of s in full state list
            posa=findState(s,statesList);
            for i=1:N
                j=findNextSpin(i+1,N);
                if sbits(i)==sbits(j)
                    % spins the same
                    H(posa,posa) = H(posa,posa) + 1/4;
                else
                    % spins different
                    H(posa,posa) = H(posa,posa) - 1/4;
                    % flip spins
                    b=flipSpins(sbits,i,j);
                    % find l=num of translations of b to get a parent state
                    % and r = representative of b
                    [l,r]=findLj(b,activeParents);
                    posb=findState(r,statesList);
                    posRb=findState(r,kStates);
                    if posb>0 && posRb>0
                        Rb=R(posRb);
                        H(posa,posb)=H(posa,posb) + 1/2*(Ra/Rb)^(1/2) *exp(-i*k*l*2/N);
                    end
                end
            end
        end
    end
end