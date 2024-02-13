% k - momentum in units of pi, multiplied by pi later in code
function H=fixedkHamiltonian(N,mz,k)
    fprintf('m = %d\t k = %0.1f\n',mz,k)
    % find active parent states for mz block
    %[activeParents,periods]=findActiveParents(N,mz,k);
    [activeParents,periods]=findActiveStates(N,mz,k);
    fprintf('Num of active parents: %d\n',length(activeParents))
    % find the list of states in k block
    %[kStates,R]=findMomentumStates(activeParents,periods,k,N);
    %fprintf('Num of states : %d\n',length(kStates))
    % kStates=[];
    % R=[];
    % for i=1:length(activeParents)
    %     orbit=getOrbit(activeParents(i),periods(i),N);
    %     kStates=[kStates orbit(1,:)];
    %     R=[R orbit(2,:)];
    % end
    %[~,M]=size(kStates);
    [~,M]=size(activeParents);
    H=zeros(M);
    %k=k*pi;
    k=(pi/2)*k;
    for a=1:M
        %Ra=R(a);
        Ra=periods(a);
        %s=kStates(a);
        s=activeParents(a);
        sbits=bitget(s,N:-1:1);
        for i=1:N
            j=findNextSpin(i+1,N);
            if sbits(i)==sbits(j)
                % spins the same
                H(a,a) = H(a,a) + 1/4;
            else
                % spins different
                H(a,a) = H(a,a) - 1/4;
                % flip spins
                b=flipSpins(sbits,i,j);
                % find l=num of translations of b to get a parent state
                [l,r]=findLj(b,activeParents);
                %posb=find(kStates==bin2dec(num2str(b)));
                b=bin2dec(num2str(b));
                %posb=findState(r,kStates);
                posb=findState(r,activeParents);
                if posb>0
                    Rb=periods(posb);
                    H(a,posb)=H(a,posb)+ 1/2*(Ra/Rb)^(1/2) *exp(-i*k*l/N);
                    %H(a,posb)=H(a,posb)+ 1/2;%*(Ra/Rb)^(1/2);
                end
            end
        end
    end
end