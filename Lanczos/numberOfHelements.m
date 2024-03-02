% returns array eValues of number of nonzero H elements ea
% and array B(i) which contains the positions of the non zero elements
% i= 1,...,e1,e1+1,...,e1+e2,etc
function [eValues,B,H]=numberOfHelements(N,mz,k)
    [s,R]=findActiveParents(N,mz,k);
    M=length(s);
    eValues=zeros(1,M);
    B=[];
    H=[];
    for a=1:M
        % array stores H elements
        Ha=zeros(1,M);
        sa=s(a);
        sbits=bitget(sa,N:-1:1);
        for i=1:N
            j=findNextSpin(i+1,N);
            if sbits(i)==sbits(j)
                Ha(a) = Ha(a) + 1/4;
            else
                Ha(a) = Ha(a) - 1/4;
                sflipped=flipSpins(sbits,i,j);
                [l,r]=findLj(sflipped,s);
                b=findState(r,s);
                if b>=0
                    Ha(b) = Ha(b) + 0.5*(R(a)/R(b))^0.5 *exp(sqrt(-1)*2*pi*k*l/N);
                end
            end
        end
        % create logical vector for Ha elements to be above a threshold
        % to identify which elements are nonzero
        % use sum to add up all nonzero elements = ea
        nonZeroHa=(abs(Ha)>10e-5);
        eValues(a)=sum(nonZeroHa);
        B = [B find(Ha)];
        H = [H Ha(find(Ha))];
    end
end