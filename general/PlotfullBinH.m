% plots the energy level diagram of a system
% with no external magnetic field
function PlotfullBinH(H,SystemDescription)
    EnergyLevels=eig(H);
    %xValues=[0 0.5];
    xValues=0;
    figure; hold on;
    plot(xValues,EnergyLevels(1),'*');
    for i=2:height(EnergyLevels)
        plot(xValues,EnergyLevels(i),'*');
    end
    hold off;
    %ylim([-2.1 1.1]); 
    xlim([-0.1 0.1]); 
    set(gca,'xtick',[]);
    ylabel('Energy/J');
    title(["Energy Level Diagram",SystemDescription]);
end