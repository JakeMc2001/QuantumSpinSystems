% plot the convergence of the ground state energy
% energyList = array of ground state energy at each iteration
% steps = number of lanczos steps achieved before convergence
function plotGSEnergy(energyList,steps,N)
    figure; hold on;
    stepsList=1:steps;
    plot(stepsList,energyList);
    hold off; grid on;
    xlabel('Lanczos iterations');
    ylabel('Ground State Energy / J');
    title(["Convergence of Ground State Energy",sprintf("N=%d",N)]);
end