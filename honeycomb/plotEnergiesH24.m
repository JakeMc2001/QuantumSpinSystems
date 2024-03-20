% obtains energy spectra for different parameters and plots them against g
function energyList=plotEnergiesH24(gStart,gIndex,gEnd)
    J=1;
    Kz=-1;
    Gz=1/2;
    energyList=[];
    figure; hold on;
    for g=gStart:gIndex:gEnd
        Kxy=g*Kz;
        Gxy=g*Gz;
        H=lanczosH24(0,50,J,Kz,Kxy,Gz,Gxy);
        energies=eig(H);
        energyList=[energyList energies];
        x=g*ones(1,50);
        plot(x,energies,'*');
    end
    hold off; grid on;
    xlabel('g - order parameter'); ylabel('Energy / J');
    title('Energy Spectra for different g values');
    xlim([gStart-0.2 gEnd+0.2]);
end