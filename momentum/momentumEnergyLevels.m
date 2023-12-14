function energyList=momentumEnergyLevels(N)
    % preallocate array to store energy values
    energyList=zeros(1,N^2);
    % array of mz values
    mzValues=-N/2:N/2;
    % array of k values
    m=-N/2+1:N/2;
    k=(2/N)*m;
    % counter to track number of energy levels added to array
    counter=1;
    % iterate over mz values
    for i=1:length(mzValues)
        mzValues(i)
        for j=1:length(k)
            k(j)
            H=fixedkHamiltonian(N,mzValues(i),k(j))
            e=eig(H);
            % append energy to energy list
            energyList(1,counter:(counter+length(e)-1))=e.';
            % update counter
            counter=counter+length(e);
        end
    end
end