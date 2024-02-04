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
    %blocks={};
    % loop over k values
    for ki=1:length(kValues)
        % current k value
        k=kValues(ki);
        fprintf('m = %d\t k = %0.1f\n',mz,k)
        % find active parents
        [activeParents,periods]=findActiveParents(N,mz,k);
        fprintf('Active Parents: ')
        disp(activeParents)
        fprintf('\n')
        % find states with current k value
        [kStates,R]=findMomentumStates(activeParents,periods,k,N);
        [~,numOfkStates]=size(kStates);
        if numOfkStates==0
            break
        end
        %currentH=zeros(numOfkStates);
        % re-assign k value for use in calculations
        %k=k*pi;
        for a=1:numOfkStates
        %for a=1:length(activeParents)
            % period of current state
            Ra=periods(a);
            % s = current state
            s=kStates(a);
            %s=activeParents(a);
            % get bit representation of s
            sbits=bitget(s,N:-1:1);
            % find position of s in full state list
            %posa=findState(s,statesList);
            %posa=findState(s,kStates);
            posa=a;
            for i=1:N
                j=findNextSpin(i+1,N);
                if sbits(i)==sbits(j)
                    % spins the same
                    H(posa,posa) = H(posa,posa) + 1/4;
                    %currentH(posa,posa) = currentH(posa,posa) + 1/4;
                else
                    % spins different
                    %currentH(posa,posa) = currentH(posa,posa) - 1/4;
                    H(posa,posa) = H(posa,posa) - 1/4;
                    % flip spins - gives bit representation
                    b=flipSpins(sbits,i,j);
                    % find l=num of translations of b to get a parent state
                    % and r = representative of b
                    [l,r]=findLj(b,activeParents);
                    b=bin2dec(num2str(b));
                    posb=findState(b,statesList);
                    posRb=findState(r,activeParents);
                    %if posb>0 && posRb>0
                    if posb>0
                        Rb=periods(posRb);
                        H(posa,posb)=H(posa,posb) + 1/2*(Ra/Rb)^(1/2) *exp(-i*k*l/N);
                        %currentH(posa,posb)=currentH(posa,posb) + 1/2*(Ra/Rb)^(1/2) *exp(-i*k*l/N);
                    end
                end
            end
        end
        %blocks{ki}=currentH;
    end
    %H=blkdiag(blocks{:});
end