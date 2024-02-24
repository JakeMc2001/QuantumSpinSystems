% Hl = interactions of the Hamiltonian - object/class
function energy=generateHamiltonian(N,mz,k,Hterms)
    energy={};
    [ActiveParents,MkList]=findActiveParents(N,mz,k);
    D=length(ActiveParents);
    fprintf('Num of active parents: %d\n',D)
    H=zeros(D);
    numberOfTerms=length(Hterms.name);
    for c=1:D
        % c = index of parent state
        % s = current parent
        s=ActiveParents(c);
        % sbits = bit rep of current parent
        sbits=bitget(s,N:-1:1);
        for l=1:numberOfTerms
            % apply each term of H to state c
            % apply Hl on c -> get gc on Pc
            % H(Pc,l) = H(Pc,l) + ....
            Hl=Hterms.name(l);
            sites=Hterms.sites(l);
            i=sites{1}(1);
            j=sites{1}(2);
            strength=Hterms.strength(l);
            if Hl=="SzSz"
                if sbits(i)==sbits(j)
                    H(c,c) = H(c,c) + 1/4;
                else
                    H(c,c) = H(c,c) - 1/4;
                end
            elseif Hl=="SpSm"
                if sbits(i)==0 && sbits(j)==1
                %if sbits(i)~=sbits(j)
                    %flip spins i & j and find H element
                    sflipped=flipSpins(sbits,i,j);
                    [Lj,r]=findLj(sflipped,ActiveParents);
                    b=findState(r,ActiveParents);
                    if b>0
                        H(c,b) = H(c,b) + strength*(MkList(c)/MkList(b))^0.5 *exp(sqrt(-1)*2*pi*k*Lj/N);
                    end
                end
            elseif Hl=="SmSp"
                if sbits(i)==1 && sbits(j)==0
                %if sbits(i)~=sbits(j)
                    % flip spins
                    sflipped=flipSpins(sbits,i,j);
                    [Lj,r]=findLj(sflipped,ActiveParents);
                    b=findState(r,ActiveParents);
                    if b>0
                        H(c,b) = H(c,b) + strength*(MkList(c)/MkList(b))^0.5 *exp(sqrt(-1)*2*pi*k*Lj/N);
                    end
                end
            end
        end
    end
    % calculate energy eigenvalues
    e=eig(H);
    if isempty(e)
        return
    end
    energy={mz,real(e.'),k};
end