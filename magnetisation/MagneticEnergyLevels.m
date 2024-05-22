% finds the energy eigenvalues for an N-spin Heisenberg ring
% split into the H blocks
function energyList=MagneticEnergyLevels(N)
    tic
    % array of mz values
    %mzValues=-N/2:N/2;
    mzValues=0:N/2;
    % preallocate array to store energy values
    energyList=cell(length(mzValues),2);
    % define counter for total number of states
    numOfStates=0;
    % iterate over mz values
    totalMemory=0;
    for i=1:length(mzValues)
        % obtain the H block for current mz value
        H=fixedMagHamiltonian(N,mzValues(i));
        % get the energy eigenvalues
        e=eig(H);
        % append energy to energy list
        energyList(i,:)={mzValues(i),e.'};
        numOfStates = numOfStates + length(e);
        memoryUsed=sum([whos().bytes]);
        totalMemory=totalMemory+memoryUsed;
    end
    fprintf('Total number of states: %d\n',numOfStates)
    toc
    memoryUsed=sum([whos().bytes]);
    fprintf('Amount of memory used = %d Bytes\n',totalMemory)
end