% returns the energy spectrum for the Hamiltonian with given parameters
function energyList=energyH24(k,g,Lambda)
    % define Hamiltonian parameters
    J=1;
    Kz=-1;
    Gz=1/2;
    Kxy=g*Kz;
    Gxy=g*Gz;
    H=lanczosH24(k,Lambda,J,Kz,Kxy,Gz,Gxy);
    energyList=eig(H);
end