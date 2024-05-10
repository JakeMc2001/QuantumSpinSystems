function insetBZdiagram()
    figure; hold on;
    plot([0,0,0],[-4,-2,2],'o','MarkerFaceColor','k','MarkerEdgeColor','k');
    plot(0,0,'^','MarkerFaceColor',[0.6350 0.0780 0.1840],'MarkerEdgeColor',[0.6350 0.0780 0.1840],'MarkerSize',12);
    plot(2,1,'diamond','MarkerFaceColor',[0 0.4470 0.7410],'MarkerEdgeColor',[0 0.4470 0.7410],'MarkerSize',12);
    plot(4,0,'square','MarkerEdgeColor',[0.4660 0.6740 0.1880],'MarkerFaceColor',[0.4660 0.6740 0.1880],'MarkerSize',12);
    plot(0,4,'v','MarkerEdgeColor',[0.4940 0.1840 0.5560],'MarkerFaceColor',[0.4940 0.1840 0.5560],'MarkerSize',12);
    plot([-2,-2,-2,-2],[-3,-1,1,3],'o','MarkerFaceColor','k','MarkerEdgeColor','k');
    plot([-4,-4,-4],[-2,0,2],'o','MarkerFaceColor','k','MarkerEdgeColor','k');
    plot([2,2,2],[-3,-1,3],'o','MarkerFaceColor','k','MarkerEdgeColor','k');
    plot([4,4],[-2,2],'o','MarkerFaceColor','k','MarkerEdgeColor','k');
    plot([-4,0],[2,4],'k-');
    plot([0,4],[4,2],'k-');
    plot([4,4],[2,-2],'k-');
    plot([4,0],[-2,-4],'k-');
    plot([0,-4],[-4,-2],'k-');
    plot([-4,-4],[-2,2],'k-');
    xlim([-6.5 6.5]);
    ylim([-4.5 4.5]);
    text(0.1,0.3,'\Gamma(1)','FontSize',18);
    text(2,1.4,'(K/2)(6)','FontSize',18);
    text(4.1,0.3,'M(3)','FontSize',18);
    text(0.2,4.1,'K(2)','FontSize',18);
end