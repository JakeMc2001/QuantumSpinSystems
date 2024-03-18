% returns array eValues of number of nonzero H elements ea
% and array B(i) which contains the positions of the non zero elements
% i= 1,...,e1,e1+1,...,e1+e2,etc
function [eValues,B,H]=numberOfHelements(N,mz,k,Hterms)
    [s,R]=findActiveParents(N,mz,k);
    fprintf('findActiveParents:\n')
    toc
    charTable=CharacterTable(N);
    M=length(s);
    eValues=zeros(1,M);
    B=[];
    H=[];
    numberOfTerms=length(Hterms.name);
    for a=1:M
        % array stores H elements
        Ha=zeros(1,M);
        sa=s(a);
        sbits=bitget(sa,N:-1:1);
        for l=1:numberOfTerms
            Hl=Hterms.name(l);
            sites=Hterms.sites(l);
            i=sites{1}(1);
            j=sites{1}(2);
            strength=Hterms.strength(l);
            if Hl=="SzSz"
                if sbits(i)==sbits(j)
                    Ha(a) = Ha(a) + 1/4;
                else
                    Ha(a) = Ha(a) - 1/4;
                end
            elseif Hl=="SpSm"
                if sbits(i)==0 && sbits(j)==1
                    sflipped=flipSpins(sbits,i,j);
                    [Lj,r]=findLj(sflipped,s);
                    b=findState(r,s);
                    if b>0
                        Ha(b) = Ha(b) + strength*(R(a)/R(b))^0.5 *charTable(k+1,Lj+1);
                    end
                end
            elseif Hl=="SmSp"
                if sbits(i)==1 && sbits(j)==0
                    sflipped=flipSpins(sbits,i,j);
                    [Lj,r]=findLj(sflipped,s);
                    b=findState(r,s);
                    if b>0
                        Ha(b) = Ha(b) + strength*(R(a)/R(b))^0.5 *charTable(k+1,Lj+1);
                    end
                end
            end
        end
        nonZeroHa=(abs(Ha)>10e-5);
        eValues(a)=sum(nonZeroHa);
        B = [B find(Ha)];
        H = [H Ha(find(Ha))];
    end
end