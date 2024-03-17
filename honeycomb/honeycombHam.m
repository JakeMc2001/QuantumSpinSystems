% generates the Hamiltonian interactions object
% for 24 spins on a honeycomb lattice
% Gz and Gxy are the gamma terms
% sites for x, y and z bonds are stored in files
function Hterms=honeycombHam(J,Kz,Kxy,Gz,Gxy)
    Hterms = interactions;
    % load bond site data from files
    sizeA=[2 Inf];
    fileID=fopen("honeycomb/xBonds.txt");
    xBonds=fscanf(fileID,'%i %i',sizeA);
    fclose(fileID);
    fileID=fopen("honeycomb/yBonds.txt");
    yBonds=fscanf(fileID,'%i %i',sizeA);
    fclose(fileID);
    fileID=fopen("honeycomb/zBonds.txt");
    zBonds=fscanf(fileID,'%i %i',sizeA);
    fclose(fileID);
    for i=1:length(xBonds)
        bond=xBonds(:,i);
        Hterms=Hterms.addHterm("SzSz",2,bond,J);
        Hterms=Hterms.addHterm("SpSm",2,bond,(J+Kxy)/2);
        Hterms=Hterms.addHterm("SmSp",2,bond,(J+Kxy)/2);
        Hterms=Hterms.addHterm("SpSz",2,bond,Gxy/(2*sqrt(-1)));
        Hterms=Hterms.addHterm("SmSz",2,bond,-Gxy/(2*sqrt(-1)));
        Hterms=Hterms.addHterm("SzSp",2,bond,Gxy/(2*sqrt(-1)));
        Hterms=Hterms.addHterm("SzSm",2,bond,-Gxy/(2*sqrt(-1)));
    end
    for i=1:length(yBonds)
        bond=yBonds(:,i);
        Hterms=Hterms.addHterm("SzSz",2,bond,J);
        Hterms=Hterms.addHterm("SpSm",2,bond,(J+Kxy)/2);
        Hterms=Hterms.addHterm("SmSp",2,bond,(J+Kxy)/2);
        Hterms=Hterms.addHterm("SpSz",2,bond,Gxy/2);
        Hterms=Hterms.addHterm("SmSz",2,bond,Gxy/2);
        Hterms=Hterms.addHterm("SzSp",2,bond,Gxy/2);
        Hterms=Hterms.addHterm("SzSm",2,bond,Gxy/2);
    end
    for i=1:length(zBonds)
        bond=zBonds(:,i);
        Hterms=Hterms.addHterm("SzSz",2,bond,J*Kz);
        Hterms=Hterms.addHterm("SpSp",2,bond,Gz/(2*sqrt(-1)));
        Hterms=Hterms.addHterm("SmSm",2,bond,-Gz/(2*sqrt(-1)));
    end
end