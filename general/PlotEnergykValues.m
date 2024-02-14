% plots energy level diagram with different colours
% for different k values
% EnergyLevels is a cell array with mz, energy and k values
function PlotEnergykValues(N)
    EnergyLevels=momentumEnergySpectrum(N);
    figure; hold on;
    for k=0:N-1
        Sz=[];
        Energy=[];
        for i=1:height(EnergyLevels)
            if EnergyLevels{i,3}==k
                Sz=[Sz EnergyLevels{i,1}*ones(1,length(EnergyLevels{i,2}))];
                Energy=[Energy EnergyLevels{i,2}];
            end
        end
        % calculate actual momentum for legend
        kj=k/2;
        plot(Sz,real(Energy),'x','DisplayName',sprintf("k=%0.1f%s",kj,'\pi'));
    end
    hold off; grid on;
    % limits can be changed to improve layout of plot
    %ylim([-2.2 1.2]);
    %xlim([-2.2 2.2]);
    ylabel('Energy/J'); xlabel('Sz');
    title(["Energy Level Diagram",sprintf("N=%d",N)]);
    legend('Location','northeastoutside');
    legend;
end