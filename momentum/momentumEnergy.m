% refactor of kHEnergyWORKS()
% splits some code into individual functions
function energyList=momentumEnergy(N)
    tic
    m=(-N/2 +1):(N/2);
    kValues=(2*pi/N)*m;
    energyList={};
    index=0;
    numOfStates=0;
    for mz=(-N/2):N/2
        energyList(index+1,:)=kMagBlock(N,mz,kValues);
        [~,states]=size(energyList{index+1,2});
        numOfStates = numOfStates + states;
        [index,~]=size(energyList);
    end
    fprintf('Total number of states: %d\n',numOfStates)
    toc
end