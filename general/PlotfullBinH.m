% plots the energy level diagram of a system
% with no external magnetic field
function PlotfullBinH(H,SystemDescription)
    EnergyLevels=eig(H);
    xValues=[0 0.5];
    plot(xValues,[EnergyLevels(1),EnergyLevels(1)]); hold on;
    for i=2:height(EnergyLevels)
        plot(xValues,[EnergyLevels(i),EnergyLevels(i)]);
    end
    ylim([-7 4]); 
    xlim([0 0.5]); 
    set(gca,'xtick',[]);
    ylabel('Energy/J');
    title(["Energy Level Diagram",SystemDescription]);
end