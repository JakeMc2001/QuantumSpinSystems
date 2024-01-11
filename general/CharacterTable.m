function charTable=CharacterTable(N)
    charTable=zeros(N);
    m=0:N-1;
    k=(2*pi*m)/N;
    t=0:(N-1);
    for n=1:N
        charTable(n,:)=exp(1i*k*t(n));
    end
end