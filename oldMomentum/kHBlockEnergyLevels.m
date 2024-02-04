function energyList=kHBlockEnergyLevels(N)
    tic
    mzValues=-N/2:N/2;
    energyList={};
    numOfStates=0;
    for i=1:length(mzValues)
        magStates=0;
        H=kHmagBlock(N,mzValues(i));
        e=eig(H);
        if isempty(e)
            continue
        end
        energyList(i,:)={mzValues(i),e.'};
        numOfStates=numOfStates + length(e);
    end
    fprintf('Total number of states: %d\n',numOfStates)
end