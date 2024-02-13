% Hl = interactions of the Hamiltonian - object/class
function H=generateHamiltonian(N,mz,k,Hterms)
    [ActiveParents,MkList]=findActiveStates(N,mz,k);
    D=length(ActiveParents);
    H=zeros(D);
    % number
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
                %if sbits(i)==0 && sbits(j)==1
                if sbits(i)~=sbits(j)
                    H(c,c) = H(c,c) - 1/4;
                    %flip spins i & j and find H element
                    sflipped=flipSpins(sbits,i,j);
                    [l,r]=findLj(sflipped,ActiveParents);
                    b=findState(r,ActiveParents);
                    if b>0
                        H(c,b) = H(c,b) + 0.5*(MkList(c)/MkList(b))^0.5;
                    end
                end
            elseif Hl=="SmSp"
                %if sbits(i)==1 && sbits(j)==0
                if sbits(i)~=sbits(j)
                    H(c,c) = H(c,c) - 1/4;
                    % flip spins
                    sflipped=flipSpins(sbits,i,j);
                    [l,r]=findLj(sflipped,ActiveParents);
                    b=findState(r,ActiveParents);
                    if b>0
                        H(c,b) = H(c,b) + 0.5*(MkList(c)/MkList(b))^0.5;
                    end
                end
            end
        end
    end

end