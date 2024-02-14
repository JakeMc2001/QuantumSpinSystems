function energy=kMagHBlock(N,mz,k)
    energy={};
    index=0;
    numOfStates=0;
    [s,R]=findActiveParents(N,mz,k);
    M=length(s);
    fprintf('Num of active parents: %d\n',M)
    numOfStates = numOfStates + M;
    H=zeros(M);
    for a=1:M
        sa=s(a);
        sbits=bitget(sa,N:-1:1);
        for i=1:N
            j=findNextSpin(i+1,N);
            if sbits(i)==sbits(j)
                H(a,a)=H(a,a) + 1/4;
            else
                H(a,a) = H(a,a) - 1/4;
                sflipped = flipSpins(sbits,i,j);
                [l,r]=findLj(sflipped,s);
                b=findState(r,s);
                if b>=0
                    H(a,b) = H(a,b) + 0.5*(R(a)/R(b))^0.5 *exp(sqrt(-1)*2*pi*k*l/N);
                end
            end
        end
    end
    e=eig(H);
    if isempty(e)
        return
    end
    energy={mz,e.',k};
end
