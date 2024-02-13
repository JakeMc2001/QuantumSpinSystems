function energyList=momentumEnergyLevels(N)
    tic
    % array of mz values
    mzValues=-N/2:N/2;
    % preallocate array to store energy values
    %energyList=cell(length(mzValues),3);
    energyList={};
    % array of k values
    m=0:N-1;
    %k=(2/N)*m;
    k=m;
    index=0;
    % define counter for total number of states
    numOfStates=0;
    Hterms=genHterms(N);
    % iterate over mz values
    for i=1:length(mzValues)
        magStates=0;
        for j=1:length(k)
            %H=fixedkHamiltonian(N,mzValues(i),k(j))
            H=generateHamiltonian(N,mzValues(i),k(j),Hterms)
            e=eig(H)
            if isempty(e)
                break
            end
            % append energy to energy list
            %energyList(i+counter-1,:)={mzValues(i),e.',k(j)};
            energyList(index+1,:)={mzValues(i),e.',k(j)};
            [index,~]=size(energyList);
            numOfStates = numOfStates + length(e);
            magStates = magStates + length(e);
        end
        fprintf('\t States for mz=%d : %d\n',mzValues(i),magStates)
    end
    fprintf('Total number of states: %d\n',numOfStates)
    toc
end