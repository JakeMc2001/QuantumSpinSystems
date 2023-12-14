% finds the energy eigenvalues for an N-spin Heisenberg ring
% split into the H blocks
function energyList=MagneticEnergyLevels(N)
    % preallocate array to store energy values
    energyList=zeros(1,N^2);
    % array of mz values
    mzValues=-N/2:N/2;
    % counter to track number of energy levels added to array
    counter=1;
    % iterate over mz values
    for i=1:length(mzValues)
        % obtain the H block for current mz value
        H=fixedMagHamiltonian(N,mzValues(i));
        % get the energy eigenvalues
        e=eig(H);
        % append energy to energy list
        energyList(1,counter:(counter+length(e)-1))=e.';
        % update counter
        counter=counter+length(e);
    end
end