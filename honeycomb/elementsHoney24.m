function [eValues,B,H]=elementsHoney24(Hterms,k)
    N=24;
    fileID = fopen("honeycomb/operations.txt");
    opsData = textscan(fileID,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','HeaderLines',1);
    fclose(fileID);
    ops = [];
    % format operations into a matrix
    for m=1:24
        ops = [ops double(str2sym(opsData{m+1}))];
    end
    charTable=CharTableHoney24();
    [s,R]=activeParentsHoney24(k);
    M=length(s);
    eValues=zeros(1,M);
    numberOfTerms=length(Hterms.name);
    B=[];
    H=[];
    % loop over parent states
    for a=1:M
        a
        Ha=zeros(1,M);
        sa=s(a);
        sbits=bitget(sa,N:-1:1);
        for l=1:numberOfTerms
            Hl=Hterms.name(l);
            sites=Hterms.sites(l);
            i=sites{1}(1)+1;
            j=sites{1}(2)+1;
            strength=Hterms.strength(l);
            if Hl=="SzSz"
                if sbits(i)==sbits(j)
                    Ha(a) = Ha(a) + 1/4;
                else
                    Ha(a) = Ha(a) - 1/4;
                end
            elseif Hl=="SpSm" || Hl=="SmSp"
                if sbits(i)~=sbits(j)
                    sflipped=flipSpins(sbits,i,j);
                    [Lj,r]=findLjH24(sflipped,s,ops);
                    b=findState(r,s);
                    if b>0
                        Ha(b) = Ha(b) + strength*(R(a)/R(b))^0.5 *charTable(k+1,Lj+1);
                    end
                end
            elseif Hl=="SpSp" && sbits(i)==0 && sbits(j)==0
                sflipped=sbits;
                sflipped(i)=1;
                sflipped(j)=1;
                [Lj,r]=findLjH24(sflipped,s,ops);
                b=findState(r,s);
                if b>0
                    Ha(b) = Ha(b) + strength*(R(a)/R(b))^0.5 *charTable(k+1,Lj+1);
                end
            elseif Hl=="SmSm" && sbits(i)==1 && sbits(j)==1
                sflipped=sbits;
                sflipped(i)=0;
                sflipped(j)=0;
                [Lj,r]=findLjH24(sflipped,s,ops);
                b=findState(r,s);
                if b>0
                    Ha(b) = Ha(b) + strength*(R(a)/R(b))^0.5 *charTable(k+1,Lj+1);
                end
            elseif Hl=="SpSz" && sbits(i)==0
                sflipped=sbits;
                sflipped(i)=1;
                [Lj,r]=findLjH24(sflipped,s,ops);
                b=findState(r,s);
                if b>0
                    Ha(b) = Ha(b) - 0.5*strength*(R(a)/R(b))^0.5 *charTable(k+1,Lj+1);
                end
            elseif Hl=="SmSz" && sbits(i)==1
                sflipped=sbits;
                sflipped(i)=0;
                [Lj,r]=findLjH24(sflipped,s,ops);
                b=findState(r,s);
                if b>0
                    Ha(b) = Ha(b) + 0.5*strength*(R(a)/R(b))^0.5 *charTable(k+1,Lj+1);
                end
            elseif Hl=="SzSp" && sbits(j)==0
                sflipped=sbits;
                sflipped(j)=1;
                [Lj,r]=findLjH24(sflipped,s,ops);
                b=findState(r,s);
                if b>0
                    Ha(b) = Ha(b) - 0.5*strength*(R(a)/R(b))^0.5 *charTable(k+1,Lj+1);
                end
            elseif Hl=="SzSm" && sbits(j)==1
                sflipped=sbits;
                sflipped(j)=0;
                [Lj,r]=findLjH24(sflipped,s,ops);
                b=findState(r,s);
                if b>0
                    Ha(b) = Ha(b) + 0.5*strength*(R(a)/R(b))^0.5 *charTable(k+1,Lj+1);
                end
            end
        end
        nonZeroHa=(abs(Ha)>10e-5);
        eValues(a)=sum(nonZeroHa);
        B = [B find(Ha)];
        H = [H Ha(find(Ha))];
    end
end