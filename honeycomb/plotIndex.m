function plotIndex()
    % k=0 energy spectrum
    k0run1=readmatrix('eConvergeRun1.txt');
    [~,cols]=size(k0run1);
    k0run1=k0run1(:,cols);

    k0run2=readmatrix('eConvergeRun2.txt');
    [~,cols]=size(k0run2);
    k0run2=k0run2(:,cols);

    k0run3=readmatrix('eConvergeRun3.txt');
    [~,cols]=size(k0run3);
    k0run3=k0run3(:,cols);

    k0run4=readmatrix('eConvergeRun4.txt');
    [~,cols]=size(k0run4);
    k0run4=k0run4(:,cols);

    k0run5=readmatrix('eConvergeRun5.txt');
    [~,cols]=size(k0run5);
    k0run5=k0run5(:,cols);

    k0run6=readmatrix('eConvergeRun6.txt');
    [~,cols]=size(k0run6);
    k0run6=k0run6(:,cols);

    k0run7=readmatrix('eConvergeRun7.txt');
    [~,cols]=size(k0run7);
    k0run7=k0run7(:,cols);

    k0run8=readmatrix('eConvergeRun8.txt');
    [~,cols]=size(k0run8);
    k0run8=k0run8(:,cols);

    k0run9=readmatrix('eConvergeRun9.txt');
    [~,cols]=size(k0run9);
    k0run9=k0run9(:,cols);

    k0run10=readmatrix('eConvergeRun10.txt');
    [~,cols]=size(k0run10);
    k0run10=k0run10(:,cols);

    k0run11=readmatrix('eConvergeRun11.txt');
    [~,cols]=size(k0run11);
    k0run11=k0run11(:,cols);

    k0run12=readmatrix('eConvergeRun12.txt');
    [~,cols]=size(k0run12);
    k0run12=k0run12(:,cols);

    x=ones(100,1);
    k0x=[0*x,0.1*x,0.15*x,0.2*x,0.225*x,0.25*x,0.3*x,0.4*x,0.5*x,0.6*x,0.7*x,x];
    
    %k=2 energies
    k2run1=readmatrix('eConvergek2Run1.txt');
    [~,cols]=size(k2run1);
    k2run1=k2run1(:,cols);
    
    k2run2=readmatrix('eConvergek2Run2.txt');
    [~,cols]=size(k2run2);
    k2run2=k2run2(:,cols);

    k2run3=readmatrix('eConvergek2Run3.txt');
    [~,cols]=size(k2run3);
    k2run3=k2run3(:,cols);

    k2run4=readmatrix('eConvergek2Run4.txt');
    [~,cols]=size(k2run4);
    k2run4=k2run4(:,cols);

    k2run5=readmatrix('eConvergek2Run5.txt');
    [~,cols]=size(k2run5);
    k2run5=k2run5(:,cols);

    k2run6=readmatrix('eConvergek2Run6.txt');
    [~,cols]=size(k2run6);
    k2run6=k2run6(:,cols);

    k2run7=readmatrix('eConvergek2Run7.txt');
    [~,cols]=size(k2run7);
    k2run7=k2run7(:,cols);

    k2run8=readmatrix('eConvergek2Run8.txt');
    [~,cols]=size(k2run8);
    k2run8=k2run8(:,cols);

    k2run9=readmatrix('eConvergek2Run9.txt');
    [~,cols]=size(k2run9);
    k2run9=k2run9(:,cols);

    k2x=[0*x,0.1*x,0.15*x,0.2*x,0.225*x,0.25*x,0.3*x,0.4*x,0.5*x];

    %k=9
    k9run1=readmatrix('eConvergek9Run1.txt');
    [~,cols]=size(k9run1);
    k9run1=k9run1(:,cols);

    k9run2=readmatrix('eConvergek9Run2.txt');
    [~,cols]=size(k9run2);
    k9run2=k9run2(:,cols);

    k9run3=readmatrix('eConvergek9Run3.txt');
    [~,cols]=size(k9run3);
    k9run3=k9run3(:,cols);

    k9run4=readmatrix('eConvergek9Run4.txt');
    [~,cols]=size(k9run4);
    k9run4=k9run4(:,cols);

    k9run5=readmatrix('eConvergek9Run5.txt');
    [~,cols]=size(k9run5);
    k9run5=k9run5(:,cols);

    k9run6=readmatrix('eConvergek9Run6.txt');
    [~,cols]=size(k9run6);
    k9run6=k9run6(:,cols);

    k9run7=readmatrix('eConvergek9Run7.txt');
    [~,cols]=size(k9run7);
    k9run7=k9run7(:,cols);

    k9run8=readmatrix('eConvergek9Run8.txt');
    [~,cols]=size(k9run8);
    k9run8=k9run8(:,cols);

    k9run9=readmatrix('eConvergek9Run9.txt');
    [~,cols]=size(k9run9);
    k9run9=k9run9(:,cols);
    
    k9energies=[k9run1,k9run2,k9run3,k9run4,k9run5,k9run6,k9run7,k9run9,k9run8];
    k0energies=[k0run1,k0run4,k0run6,k0run5,k0run9,k0run8,k0run7,k0run10,k0run3,k0run12,k0run11,k0run2];
    k2energies=[k2run1,k2run2,k2run3,k2run4,k2run5,k2run6,k2run7,k2run9,k2run8];
    %k0x=[0*x,1*x,2*x,3*x,4*x,5*x,6*x,7*x,8*x,9*x,10*x,11*x];
    k0x=(0:11).*x;
    k2x=[0*x,1*x,2*x,3*x,4*x,5*x,6*x,7*x,8*x];

    figure; hold on;
    p1=plot(k0x,k0energies,'^','MarkerEdgeColor',[0.6350 0.0780 0.1840],'MarkerSize',8,'LineWidth',1);
    p2=plot(k2x,k2energies,'diamond','MarkerEdgeColor',[0 0.4470 0.7410],'MarkerSize',8,'LineWidth',1);
    p3=plot(k2x,k9energies,'square','MarkerEdgeColor',[0.4660 0.6740 0.1880],'MarkerSize',8,'LineWidth',1);
    hold off; xlim([-0.5 11.5]);
    xlabel('g - order parameter'); ylabel('Energy / J');
    grid on; %grid minor;
    title('Energy Spectra against g values');
    xticks(0:11);
    xticklabels({0,0.1,0.15,0.2,0.225,0.25,0.3,0.4,0.5,0.6,0.7,1});
    legend([p1(1) p2(1) p3(1)],{'\Gamma(1)','(K/2)(6)','M(3)'},'Location','northeastoutside');
    axes('Position',[.29 .12 .2 .4]);
    imshow('figures/BZDiagram2.png');

end