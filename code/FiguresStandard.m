%Figure 1
load('gammarand.mat')
meanfaults = mean(nFaults);
sdfaults = std(nFaults);
X=[Gamma,fliplr(Gamma)];
Y1=[meanfaults+sdfaults/2,fliplr(meanfaults-sdfaults/2)];

figure
set(gca, 'FontSize', 16);
h1 = fill(X,Y1,[0.5 0.5 1]);
hold on;
pl1 = plot(Gamma,meanfaults,'LineWidth',2);
set(gca,'FontSize',14);
set(h1,'facealpha',.5)
set(h1,'edgealpha',.5)

load('gammapref.mat')
meanfaults = mean(nFaults);
sdfaults = std(nFaults);
X=[Gamma,fliplr(Gamma)];
Y1=[meanfaults+sdfaults/2,fliplr(meanfaults-sdfaults/2)];
h2 = fill(X,Y1,[1 0.5 0.5]);
set(h2,'facealpha',.5)
set(h2,'edgealpha',.5)
pl2 = plot(Gamma,meanfaults,'r-','LineWidth',2);

xlabel('Percentage net worth');
ylabel('Number of defaults');
xlim([0 0.1]);
ylim([0 N]);
title('Standard bank generation')
legend([pl1 pl2],{'Random','Preferential'},'Location','NorthEast'); 
legend('boxoff')
box on
grid on
hold off



%Figure 2
load('thetarand.mat')
meanfaults = mean(nFaults);
sdfaults = std(nFaults);
X=[Theta,fliplr(Theta)];
Y1=[meanfaults(1:nTheta)+sdfaults(1:nTheta)/2,fliplr(meanfaults(1:nTheta)-sdfaults(1:nTheta)/2)];
Y2=[meanfaults(nTheta+(1:nTheta))+sdfaults(nTheta+(1:nTheta))/2,fliplr(meanfaults(nTheta+(1:nTheta))-sdfaults(nTheta+(1:nTheta))/2)];
Y3=[meanfaults(2*nTheta+(1:nTheta))+sdfaults(2*nTheta+(1:nTheta))/2,fliplr(meanfaults(2*nTheta+(1:nTheta))-sdfaults(2*nTheta+(1:nTheta))/2)];

figure
set(gca, 'FontSize', 16);
h1 = fill(X,Y1,[0.5 0.5 1]);
set(h1,'facealpha',.5)
set(h1,'edgealpha',.5)
hold on;
h2 = fill(X,Y2,[0.5 1 0.5]);
set(h2,'facealpha',.5)
set(h2,'edgealpha',.5)
h3 = fill(X,Y3,[1 0.5 0.5]);
set(h3,'facealpha',.5)
set(h3,'edgealpha',.5)
pl=plot(Theta,meanfaults(1:nTheta),Theta,meanfaults(nTheta+(1:nTheta)),Theta,meanfaults(2*nTheta+(1:nTheta)),'LineWidth',2);

xlabel('Percentage interbank assets');
ylabel('Number of defaults');
legend(pl,'Net Worth 1%','Net Worth 3%','Net Worth 5%','Location','northwest');
xlim([0 0.5]);
ylim([0 N]);
title('Standard bank generation, random network')
legend('boxoff')
box on
grid on
hold off

%Figure 3
load('thetapref.mat')
meanfaults = mean(nFaults);
sdfaults = std(nFaults);
X=[Theta,fliplr(Theta)];
Y1=[meanfaults(1:nTheta)+sdfaults(1:nTheta)/2,fliplr(meanfaults(1:nTheta)-sdfaults(1:nTheta)/2)];
Y2=[meanfaults(nTheta+(1:nTheta))+sdfaults(nTheta+(1:nTheta))/2,fliplr(meanfaults(nTheta+(1:nTheta))-sdfaults(nTheta+(1:nTheta))/2)];
Y3=[meanfaults(2*nTheta+(1:nTheta))+sdfaults(2*nTheta+(1:nTheta))/2,fliplr(meanfaults(2*nTheta+(1:nTheta))-sdfaults(2*nTheta+(1:nTheta))/2)];

figure
set(gca, 'FontSize', 16);
h1 = fill(X,Y1,[0.5 0.5 1]);
set(h1,'facealpha',.5)
set(h1,'edgealpha',.5)
hold on;
h2 = fill(X,Y2,[0.5 1 0.5]);
set(h2,'facealpha',.5)
set(h2,'edgealpha',.5)
h3 = fill(X,Y3,[1 0.5 0.5]);
set(h3,'facealpha',.5)
set(h3,'edgealpha',.5)
pl=plot(Theta,meanfaults(1:nTheta),Theta,meanfaults(nTheta+(1:nTheta)),Theta,meanfaults(2*nTheta+(1:nTheta)),'LineWidth',2);

xlabel('Percentage interbank assets');
ylabel('Number of defaults');
legend(pl,'Net Worth 1%','Net Worth 3%','Net Worth 5%','Location','NorthWest');
xlim([0 0.5]);
ylim([0 N]);
title('Standard bank generation, preferential network')
legend('boxoff')
box on
grid on
hold off




