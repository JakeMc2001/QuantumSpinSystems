% generate fixed magnetisation blocks
function states=genMagStates(N,mz)
    nUp=mz +N/2;
    M=factorial(N)/(factorial(nUp)*factorial(N-nUp));
    states=zeros(1,M);
    a=0;
    for s=0:(2^N -1)
        sa=bitget(s,N:-1:1);
        if sum(sa)==nUp
            a=a+1;
            states(1,a)=s;
        end
    end
end