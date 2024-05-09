function PlotEnergyLevelDiagram(EnergyLevels,SystemDescription)
    % EnergyLevels must be given as a cell array
    figure;
    plot(EnergyLevels{1,1}*ones(1,length(EnergyLevels{1,2})),EnergyLevels{1,2},'*'); hold on;
    for i=2:height(EnergyLevels)
        plot(EnergyLevels{i,1}*ones(1,length(EnergyLevels{i,2})),EnergyLevels{i,2},'*');
    end
    hold off;
    % y limits can be changed to improve layout of plot
    %ylim([-8 4.2]);
    %xlim([-8.2 8.2]);
    ylabel('Energy/J'); xlabel('Sz');
    title(["Energy Level Diagram",SystemDescription]);
end