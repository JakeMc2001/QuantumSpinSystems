function plotGivenEnergiesH24(varargin)
    figure; hold on;
    for i=1:nargin
        allEnergies=varargin{i};
        [rows, cols]=size(allEnergies);
        finalEnergies=allEnergies(:,cols);
        x=i*ones(rows,1);
        plot(x,finalEnergies,'*');
    end
    hold off; grid on;
    xlabel('g - order parameter'); ylabel('Energy / J');
    title('Energy Spectra for different g values');
end