function PlotEnergyLevelDiagram(EnergyLevels,SystemDescription)
    xValues=[0 0.5];
    plot(xValues,[EnergyLevels(1),EnergyLevels(1)]); hold on;
    for i=2:length(EnergyLevels)
        plot(xValues,[EnergyLevels(i),EnergyLevels(i)]);
    end
    % y limits can be changed to improve layout of plot
    %ylim([-2 2]);
    xlim([0 0.6]); set(gca,'xtick',[]);
    ylabel('Energy/J');
    title(["Energy Level Diagram",SystemDescription]);
end