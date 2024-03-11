% plots the lowest 5 energy eigenvalues from lanczosConMulti()
function plotlowestEnergies(energyList,steps,N)
    figure; hold on;
    stepsList=1:steps;
    for i=1:height(energyList)
        plot(stepsList,energyList(i,:));
    end
    hold off; grid on;
    xlabel('Lanczos iterations');
    ylabel('Energy / J');
    title(["Convergence of 5 lowest Energies",sprintf("N=%d",N)]);
end