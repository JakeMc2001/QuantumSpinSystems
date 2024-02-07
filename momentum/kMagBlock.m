% finds the energy eigenvalues for the given mz
% iterates over the k values from array kValues
function energy=kMagBlock(N,mz,kValues)
    fprintf('mz = %d\n',mz)
    energy={};
    index=0;
    numOfStates=0;
    for ki=1:length(kValues)
        k=kValues(ki);
        fprintf('\t k = %0.1f\n',k)
        [s,R]=findValidParents(N,mz,k);
        M=length(s);
        %fprintf('Num of active parents: %d\n',M)
        numOfStates = numOfStates + M;
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
    fprintf('%d state/s for mz = %d\n',numOfStates,mz)
end