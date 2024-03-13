function CharTable=CharTableHoney24()
    fileID = fopen("honeycomb/gCoeffs.txt");
    gCoeffs = textscan(fileID,'%s %s %s','HeaderLines',1);
    fclose(fileID);
    fileID = fopen("honeycomb/kCoeffs.txt");
    kCoeffs = textscan(fileID,'%s %s %s','HeaderLines',1);
    fclose(fileID);

    gx=double(str2sym(gCoeffs{2}));
    gy=double(str2sym(gCoeffs{3}));
    gCoeffs=[gx gy];
    kx=double(str2sym(kCoeffs{2}));
    ky=double(str2sym(kCoeffs{3}));
    kCoeffs=[kx ky];
    
    dimension=height(kCoeffs);
    CharTable=zeros(dimension);
    for l=1:dimension
        k=kCoeffs(l,:);
        for h=1:dimension
            g=gCoeffs(h,:);
            CharTable(l,h)=exp(1i*dot(k,g));
        end
    end
end