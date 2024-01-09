function energyList=momentumEnergyLevels(N)
    % array of mz values
    mzValues=0:N/2;
    % preallocate array to store energy values
    energyList=cell(length(mzValues),3);
    % array of k values
    m=-N/2+1:N/2;
    k=(2/N)*m;
    % iterate over mz values
    for i=1:length(mzValues)
        for j=1:length(k)
            H=fixedkHamiltonian(N,mzValues(i),k(j));
            e=eig(H);
            % append energy to energy list
            energyList(i,:)={mzValues(i),e.',k(j)};
        end
    end
end