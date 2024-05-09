function plotH24Edifference()
    run1energies=readmatrix('eConvergeRun1.txt');
    [~,cols]=size(run1energies);
    run1energies=run1energies(:,cols);
    run1energies=run1energies-run1energies(1);

    run2energies=readmatrix('eConvergeRun2.txt');
    [~,cols]=size(run2energies);
    run2energies=run2energies(:,cols);
    run2energies=run2energies-run2energies(1);

    run3energies=readmatrix('eConvergeRun3.txt');
    [~,cols]=size(run3energies);
    run3energies=run3energies(:,cols);
    run3energies=run3energies-run3energies(1);

    run4energies=readmatrix('eConvergeRun4.txt');
    [~,cols]=size(run4energies);
    run4energies=run4energies(:,cols);
    run4energies=run4energies-run4energies(1);

    run5energies=readmatrix('eConvergeRun5.txt');
    [~,cols]=size(run5energies);
    run5energies=run5energies(:,cols);
    run5energies=run5energies-run5energies(1);

    run6energies=readmatrix('eConvergeRun6.txt');
    [~,cols]=size(run6energies);
    run6energies=run6energies(:,cols);
    run6energies=run6energies-run6energies(1);

    run7energies=readmatrix('eConvergeRun7.txt');
    [~,cols]=size(run7energies);
    run7energies=run7energies(:,cols);
    run7energies=run7energies-run7energies(1);

    run8energies=readmatrix('eConvergeRun8.txt');
    [~,cols]=size(run8energies);
    run8energies=run8energies(:,cols);
    run8energies=run8energies-run8energies(1);

    run9energies=readmatrix('eConvergeRun9.txt');
    [~,cols]=size(run9energies);
    run9energies=run9energies(:,cols);
    run9energies=run9energies-run9energies(1);

    run10energies=readmatrix('eConvergeRun10.txt');
    [~,cols]=size(run10energies);
    run10energies=run10energies(:,cols);
    run10energies=run10energies-run10energies(1);

    run11energies=readmatrix('eConvergeRun11.txt');
    [~,cols]=size(run11energies);
    run11energies=run11energies(:,cols);
    run11energies=run11energies-run11energies(1);

    run12energies=readmatrix('eConvergeRun12.txt');
    [~,cols]=size(run12energies);
    run12energies=run12energies(:,cols);
    run12energies=run12energies-run12energies(1);
    
    %energies=[run1energies,run4energies,run6energies,run5energies,run9energies,run8energies,run7energies,run10energies,run3energies,run12energies,run11energies,run2energies];
    x=ones(100,1);
    %gValues=[0,0.1,0.15,0.2,0.225,0.25,0.3,0.4,0.5,0.6,0.7,1];
    %[rows,~]=size(energies);
    figure; hold on;
    plot(0*x,run1energies,'*');
    plot(1*x,run2energies,'*');
    plot(0.5*x,run3energies,'*');
    plot(0.1*x,run4energies,'*');
    plot(0.2*x,run5energies,'*');
    plot(0.15*x,run6energies,'*');
    plot(0.3*x,run7energies,'*');
    plot(0.25*x,run8energies,'*');
    plot(0.225*x,run9energies,'*');
    plot(0.4*x,run10energies,'*');
    plot(0.7*x,run11energies,'*');
    plot(0.6*x,run12energies,'*'); 
    % for i=1:rows
    %     plot(gValues.*x,energies(i,:),'*-');
    % end
    hold off;
    xlim([-0.05 1.05]);
    xlabel('g - order parameter'); ylabel('E-E_0');
    grid on; grid minor;
    title('Energy Difference for different g values - k=(0,0)');

end