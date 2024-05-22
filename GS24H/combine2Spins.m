function [Sx,Sy,Sz]=combine2Spins(Sx,Sy,Sz,index,spin)
    size=2*spin +1;
    identity=eye(size);
    switch index
        case 1
            Sx=kron(Sx,identity);
            Sy=kron(Sy,identity);
            Sz=kron(Sz,identity);
        case 2
            Sx=kron(identity,Sx);
            Sy=kron(identity,Sy);
            Sz=kron(identity,Sz);
    end
end