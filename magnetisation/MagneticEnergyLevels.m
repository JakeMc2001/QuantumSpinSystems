% finds the energy eigenvalues for an N-spin Heisenberg ring
% split into the H blocks
function energyList=MagneticEnergyLevels(N)
    % array of mz values
    mzValues=0:N/2;
    % preallocate array to store energy values
    energyList=cell(length(mzValues),2);
    % iterate over mz values
    for i=1:length(mzValues)
        % obtain the H block for current mz value
        H=fixedMagHamiltonian(N,mzValues(i));
        % get the energy eigenvalues
        e=eig(H);
        % append energy to energy list
        energyList(i,:)={mzValues(i),e.'};
    end
end