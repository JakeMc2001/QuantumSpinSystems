% function created by following book as closely as possible
% works, don't touch it!!!!!!!!!!!!!
% just copy to mess around with it!!!!!!!
function energyList=kHEnergyWORKS(N)
    tic
    m=(-N/2 +1):(N/2);
    kValues=(2*pi/N)*m;
    energyList={};
    index=0;
    for mz=(-N/2):N/2
        for ki=1:length(kValues)
            k=kValues(ki);
            a=0;
            s=[];
            R=[];
            magStates=genMagStates(N,mz);
            for stateIndex=1:length(magStates)
                sa=magStates(stateIndex);
                Ra=checkstate(sa,N,k);
                if Ra>=0
                    a=a+1;
                    s(a)=sa;
                    R(a)=Ra;
                end
            end
            M=a;
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
            energyList(index+1,:)={mz,e.'};
            [index,~]=size(energyList);
        end
    end
    toc
end