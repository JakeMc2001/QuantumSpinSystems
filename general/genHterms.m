function Hterms=genHterms(N)
    Hterms = interactions;
    for i=1:N
        if i==N
            j=1;
        else
            j=i+1;
        end
        Hterms=Hterms.addHterm("SzSz",2,[i,j],1);
        Hterms=Hterms.addHterm("SpSm",2,[i,j],0.5);
        Hterms=Hterms.addHterm("SmSp",2,[i,j],0.5);
    end
end