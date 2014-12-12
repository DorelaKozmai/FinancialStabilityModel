% %Figure 1
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