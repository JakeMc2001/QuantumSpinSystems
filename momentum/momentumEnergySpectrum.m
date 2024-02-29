function energyList=momentumEnergySpectrum(N)
    tic
    energyList={};
    index=0;
    numOfStates=0;
    Hterms=genHterms(N);
    for mz=(-N/2):N/2
        magStates=0;
        fprintf('  mz = %d\n',mz)
        for k=0:N-1
            fprintf('\t k = %0.1f\n',k)
            %[~,tempEnergy]=kMagHBlock(N,mz,k);
            tempEnergy=generateHamiltonian(N,mz,k,Hterms);
            if isempty(tempEnergy)
                continue
            end
            numOfEnergies=length(tempEnergy{2});
            energyList(index+1,:)=tempEnergy;
            numOfStates = numOfStates + numOfEnergies;
            [index,~]=size(energyList);
            magStates=magStates+numOfEnergies;
        end
        fprintf('%d state/s for mz = %d\n',magStates,mz)
    end
    toc
    fprintf('Total number of states: %d\n',numOfStates)
    memoryUsed=sum([whos().bytes]);
    fprintf('Amount of memory used = %d Bytes\n',memoryUsed)
end