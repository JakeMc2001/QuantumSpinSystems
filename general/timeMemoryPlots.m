function timeMemoryPlots()
    % Product-Sz basis
    prodN=[4,6,8,10,12,14];
    % time and memory data with clearing
    prodTime=[0.0679, 0.072431, 0.139862, 0.758736, 7.674739, 410.035481];
    prodMemory=[6400, 41616, 563344, 8560784, 134971536, 2150760592];
    % fullBinaryHamiltonian
    fullN=[4,6,8,10,12,14,16];
    fullN2=[4,6,8,10,12,14];
    fullTime=[0.001271,0.005385,0.025894,0.0751,0.264292,1.195705];
    fullMemory=[2248,33368,526440,8396920,134250632,2147614872,3.2e+10];
    % MagneticEnergyLevels
    magN=[4,6,8,10,12,14,16];
    magTime=[0.009043,0.021941,0.057276,0.103153,0.671606,6.201737,110.27079];
    magMemory=[4864,17000,126544,1551928,21918160,322142440,4813924208];
    % momentumEnergyLevels
    %momentumN=[4,6,8,10,12,14,16,18];
    %momentumTime=[0.020863,0.063964,0.193081,0.856205,4.061848,21.903168,133.521934,1335.055139];
    %momentumMemory=[7128,14544,25736,44160,83640,199472,612840,2208480];
    % kMagHBlock
    kMagN=[4,6,8,10,12,14,16,18,20];
    kMagTime=[0.004947,0.009429,0.025916,0.03829,0.102438,0.302055,1.421823,6.102377,43.636135];
    kMagMemory=[576,768,1664,6816,55008,492640,5281872,58580160,685092832];
    % lanczosConverge
    lanczosN=[12,14,16,18,20,22,24];
    lanczosTime=[0.173315,0.372668,1.223175,5.379136,31.017401,256.08741,2808.556323];
    lanczosMemory=[14464,74080,154256,891592,2030160,11967568,28326448];
    
    figure; plot(prodN,prodMemory,'DisplayName','Product-Sz basis','LineWidth',1); hold on;
    plot(fullN,fullMemory,'DisplayName','Binary representation','LineWidth',1);
    plot(magN,magMemory,'DisplayName','Sz Symmetry','LineWidth',1);
    %plot(momentumN,momentumMemory,'DisplayName','Sz and k Symmetry');
    plot(kMagN,kMagMemory,'DisplayName','Sz=0 and k=0 Symmetry','LineWidth',1);
    plot(lanczosN,lanczosMemory,'DisplayName','Lanczos','LineWidth',1); hold off;
    %grid on; 
    yscale log;
    legend('Location','northwest');
    ylabel('RAM / Bytes'); xlabel('N');
    title('RAM usage of different versions of code, by N');

    figure; plot(prodN,prodTime,'DisplayName','Product-Sz basis','LineWidth',1); hold on;
    plot(fullN2,fullTime,'DisplayName','Binary representation','LineWidth',1);
    plot(magN,magTime,'DisplayName','Sz Symmetry','LineWidth',1);
    %plot(momentumN,momentumTime,'DisplayName','Sz and k Symmetry');
    plot(kMagN,kMagTime,'DisplayName','Sz=0 and k=0 Symmetry','LineWidth',1);
    plot(lanczosN,lanczosTime,'DisplayName','Lanczos','LineWidth',1); hold off;
    %grid on; 
    yscale log;
    legend('Location','northwest');
    ylabel('Time / s'); xlabel('N');
    title('Run time of different versions of code, by N');
end