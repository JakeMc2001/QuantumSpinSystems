function [H,energies]=groundStateSim(Kz,Gz)
    [Six,Siy,Siz]=hilbertSpace(1/2);
    [S1x,S1y,S1z] = combine2Spins(Six,Siy,Siz,1,1/2);
    [S2x,S2y,S2z] = combine2Spins(Six,Siy,Siz,2,1/2);
    H=Kz*S1z*S2z + Gz*S1x*S2y + Gz*S1y*S2x;
    
    energies=eig(H);

    xValues=0;
    figure; hold on;
    plot(xValues,energies(1),'*','MarkerSize',15);
    for i=2:height(energies)
        plot(xValues,energies(i),'*','MarkerSize',15);
    end
    text(0.015,0,'(1)','FontSize',20);
    text(0.015,-0.5,'(1)','FontSize',20);
    text(0.015,0.25,'(2)','FontSize',20);
    hold off;
    ylim([-0.6 0.35]);
    xlim([-0.1 0.1]); 
    set(gca,'xtick',[]);
    ylabel('Energy/J');
    SystemDescription="Kz="+Kz+", Gz="+Gz;
    title(["Dimerized System:",SystemDescription]);
end