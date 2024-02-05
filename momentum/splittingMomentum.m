% refactor of kHEnergyWORKS()
% splits some code into individual functions
function energyList=splittingMomentum(N)
    tic
    m=(-N/2 +1):(N/2);
    kValues=(2*pi/N)*m;
    energyList={};
    index=0;
    for mz=(-N/2):N/2
        energyList(index+1,:)=kMagEnergy(N,mz,kValues);
        [index,~]=size(energyList);
    end
    toc
end