%Plot the regulated figures. Quite some changes made from plot set ups of
%the previous group.

%Figure 1
load('smartregrand.mat')
meanfaults = mean(nFaults);
sdfaults = std(nFaults);
X=[Alpha,fliplr(Alpha)];
Y1 = [meanfaults+sdfaults/2,fliplr(meanfaults-sdfaults/2)];

figure
set(gca, 'FontSize', 16);
h1 = fill(X,Y1,[0.5 0.5 1]);
set(h1,'facealpha',.5)
set(h1,'edgealpha',.5)
hold on;
pl1 = plot(Alpha,meanfaults,'LineWidth',2);

load('randregrand.mat')
meanfaults = mean(nFaults);
sdfaults = std(nFaults);
X=[Alpha,fliplr(Alpha)];
Y1 = [meanfaults+sdfaults/2,fliplr(meanfaults-sdfaults/2)];
h2 = fill(X,Y1,[1 0.5 0.5]);
set(h2,'facealpha',.5)
set(h2,'edgealpha',.5)
pl2 = plot(Alpha,meanfaults,'r-','LineWidth',2);


xlabel('Regulator Ratio');
ylabel('Number of defaults');
title('Random versus smart regulator random network')
xlim([min(Alpha) max(Alpha)]);
ylim([0 N]);
legend([pl1 pl2],{'Smart','Random'},'Location','NorthEast'); 
legend('boxoff')
box on
grid on
hold off

%Figure 2
load('smartregpref.mat')
meanfaults = mean(nFaults);
sdfaults = std(nFaults);
X=[Alpha,fliplr(Alpha)];
Y1 = [meanfaults+sdfaults/2,fliplr(meanfaults-sdfaults/2)];

figure
set(gca, 'FontSize', 16);
h1 = fill(X,Y1,[0.5 0.5 1]);
set(h1,'facealpha',.5)
set(h1,'edgealpha',.5)
hold on;
pl1 = plot(Alpha,meanfaults,'LineWidth',2);

load('randregpref.mat')
meanfaults = mean(nFaults);
sdfaults = std(nFaults);
X=[Alpha,fliplr(Alpha)];
Y1 = [meanfaults+sdfaults/2,fliplr(meanfaults-sdfaults/2)];
h2 = fill(X,Y1,[1 0.5 0.5]);
set(h2,'facealpha',.5)
set(h2,'edgealpha',.5)
pl2 = plot(Alpha,meanfaults,'r-','LineWidth',2);

xlabel('Regulator Ratio');
ylabel('Number of defaults');
title('Random versus smart regulator preferential network')
xlim([min(Alpha) max(Alpha)]);
ylim([0 N]);
legend([pl1 pl2],{'Smart','Random'},'Location','NorthEast'); 
legend('boxoff')
box on
grid on
hold off

%Figure 3
load('smartgammarand.mat')
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

load('smartgammapref.mat')
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
title('Smart regulator')
legend([pl1 pl2],{'Random','Preferential'},'Location','NorthEast'); 
legend('boxoff')
box on
grid on
hold off

%Figure 4
load('smartthetarand.mat')
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
title('Smart regulator, random network')
legend('boxoff')
box on
grid on
hold off

%Figure 5
load('smartthetapref.mat')
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
title('Smart regulator, preferential network')
legend('boxoff')
box on
grid on
hold off





