function energyList=momentumEnergyLevels(N)
    % array of mz values
    mzValues=-N/2:N/2;
    % preallocate array to store energy values
    %energyList=cell(length(mzValues),3);
    energyList={};
    % array of k values
    m=0:N-1;
    k=(2/N)*m;
    index=0;
    % iterate over mz values
    for i=1:length(mzValues)
        for j=1:length(k)
            H=fixedkHamiltonian(N,mzValues(i),k(j));
            e=eig(H);
            if isempty(e)
                break
            end
            % append energy to energy list
            %energyList(i+counter-1,:)={mzValues(i),e.',k(j)};
            energyList(index+1,:)={mzValues(i),e.',k(j)};
            [index,~]=size(energyList);
        end
    end
end