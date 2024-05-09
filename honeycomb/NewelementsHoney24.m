function [eValues,B,H]=NewelementsHoney24(Hterms,k)
    N=24;
    fileID = fopen("honeycomb/operations.txt");
    opsData = textscan(fileID,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','HeaderLines',1);
    fclose(fileID);
    ops=zeros(12,24);
    % format operations into a matrix
    for m=1:24
        ops(:,m)=double(str2sym(opsData{m+1}));
    end
    charTable=CharTableHoney24();
    %fileID = fopen("honeycomb/H24ActiveParentsk0.txt");
    filename="H24ActiveParentsk"+k+".txt";
    fileID = fopen(filename);
    sizeA=[2 Inf];
    parentsData = fscanf(fileID,'%i %i',sizeA);
    fclose(fileID);
    s=parentsData(1,:);
    %R=parentsData(2,:);
    M=length(s);
    %fileID = fopen("honeycomb/H24LookUpk0.txt");
    filename="H24LookUpk"+k+".txt";
    fileID = fopen(filename);
    sizeA=[4 Inf];
    lookUpTable = fscanf(fileID,'%i %i %i %i',sizeA);
    fclose(fileID);
    eValues=zeros(1,M);
    numberOfTerms=length(Hterms.name);
    B=zeros(1,M*20);
    H=zeros(1,M*20);
    count=1;
    % loop over parent states
    tic
    for a=1:M
    %for a=102050:102055
        %tic
        %a
        completion=(a/M)*100;
        fprintf('Completion %0.5f%%\n',completion)
        Ha=zeros(1,M);
        sa=s(a);
        %[Lja,~,~]=newfindLjH24(sa,lookUpTable);
        sbits=bitget(sa,N:-1:1);
        for l=1:numberOfTerms
            strength=Hterms.strength(l);
            if strength==0
                continue
            end
            Hl=Hterms.name(l);
            sites=Hterms.sites(l);
            i=sites{1}(1)+1;
            j=sites{1}(2)+1;
            if Hl=="SzSz"
                if sbits(i)==sbits(j)
                    Ha(a) = Ha(a) + (1/4)*strength;
                else
                    Ha(a) = Ha(a) - (1/4)*strength;
                end
            elseif Hl=="SpSm" || Hl=="SmSp"
                if sbits(i)~=sbits(j)
                    sflipped=flipSpins(sbits,i,j);
                    sflipped=bin2dec(num2str(sflipped));
                    [Lj,~,b]=newfindLjH24(sflipped,lookUpTable);
                    if b>0
                        %Ha(b) = Ha(b) + strength*(Lja/Lj)^0.5 *charTable(k+1,Lj+1);
                        Ha(b) = Ha(b) + strength*charTable(k+1,Lj+1);
                    end
                end
            elseif Hl=="SmSm" && sbits(i)==1 && sbits(j)==1
                sflipped=sbits;
                sflipped(i)=0;
                sflipped(j)=0;
                sflipped=bin2dec(num2str(sflipped));
                [Lj,~,b]=newfindLjH24(sflipped,lookUpTable);
                if b>0
                    %Ha(b) = Ha(b) + strength*(Lja/Lj)^0.5 *charTable(k+1,Lj+1);
                    Ha(b) = Ha(b) + strength*charTable(k+1,Lj+1);
                end
            elseif Hl=="SpSz" && sbits(i)==0
                sflipped=sbits;
                sflipped(i)=1;
                sflipped=bin2dec(num2str(sflipped));
                [Lj,~,b]=newfindLjH24(sflipped,lookUpTable);
                if b>0
                    %Ha(b) = Ha(b) - 0.5*strength*(Lja/Lj)^0.5 *charTable(k+1,Lj+1);
                    Ha(b) = Ha(b) - 0.5*strength*charTable(k+1,Lj+1);
                end
            elseif Hl=="SmSz" && sbits(i)==1
                sflipped=sbits;
                sflipped(i)=0;
                sflipped=bin2dec(num2str(sflipped));
                [Lj,~,b]=newfindLjH24(sflipped,lookUpTable);
                if b>0
                    %Ha(b) = Ha(b) + 0.5*strength*(Lja/Lj)^0.5 *charTable(k+1,Lj+1);
                    Ha(b) = Ha(b) + 0.5*strength*charTable(k+1,Lj+1);
                end
            elseif Hl=="SzSp" && sbits(j)==0
                sflipped=sbits;
                sflipped(j)=1;
                sflipped=bin2dec(num2str(sflipped));
                [Lj,~,b]=newfindLjH24(sflipped,lookUpTable);
                if b>0
                    %Ha(b) = Ha(b) - 0.5*strength*(Lja/Lj)^0.5 *charTable(k+1,Lj+1);
                    Ha(b) = Ha(b) - 0.5*strength*charTable(k+1,Lj+1);
                end
            elseif Hl=="SzSm" && sbits(j)==1
                sflipped=sbits;
                sflipped(j)=0;
                sflipped=bin2dec(num2str(sflipped));
                [Lj,~,b]=newfindLjH24(sflipped,lookUpTable);
                if b>0
                    %Ha(b) = Ha(b) + 0.5*strength*(Lja/Lj)^0.5 *charTable(k+1,Lj+1);
                    Ha(b) = Ha(b) + 0.5*strength*charTable(k+1,Lj+1);
                end
            elseif Hl=="SpSp" && sbits(i)==0 && sbits(j)==0
                sflipped=sbits;
                sflipped(i)=1;
                sflipped(j)=1;
                sflipped=bin2dec(num2str(sflipped));
                [Lj,~,b]=newfindLjH24(sflipped,lookUpTable);
                if b>0
                    %Ha(b) = Ha(b) + strength*(Lja/Lj)^0.5 *charTable(k+1,Lj+1);
                    Ha(b) = Ha(b) + strength*charTable(k+1,Lj+1);
                end
            end
        end
        nonZeroHa=(abs(Ha)>10e-5);
        ea=sum(nonZeroHa);
        eValues(a)=ea;
        indices=find(abs(Ha)>10e-5);
        %B = [B indices];
        %H = [H Ha(indices)];
        B(count:(count+ea-1))=indices;
        H(count:(count+ea-1))=Ha(indices);
        count=count+ea;
        %toc
    end
    B=B(1:count-1);
    H=H(1:count-1);
    toc
end