% finds the energy eigenvalues for the given mz
% iterates over the k values from array kValues
function energy=kMagEnergy(N,mz,kValues)
    energy={};
    index=0;
    for ki=1:length(kValues)
        k=kValues(ki);
        [s,R]=findValidParents(N,mz,k);
        M=length(s);
        H=zeros(M);
        for a=1:M
            sa=s(a);
            sbits=bitget(sa,N:-1:1);
            for i=1:N
                j=findNextSpin(i+1,N);
                if sbits(i)==sbits(j)
                    H(a,a) = H(a,a) + 1/4;
                else
                    H(a,a) = H(a,a) - 1/4;
                    sflipped=flipSpins(sbits,i,j);
                    [l,r]=findLj(sflipped,s);
                    b=findState(r,s);
                    if b>=0
                        H(a,b) = H(a,b) + 0.5*(R(a)/R(b))^0.5 *exp(i*2*pi*k*l/N);
                    end
                end
            end
        end
        e=eig(H);
        if isempty(e)
            continue
        end
        energy(index+1,:)={mz,e.'};
        [index,~]=size(energy);
    end
end