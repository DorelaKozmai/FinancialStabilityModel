%This script is used to compare the random network to the scale free network in 
%the case of randomized interbank assets, without a regulator. It is based on the
%test setup by the group of the previous year, now applied to a different bank generation
%function.

% Faults vs net worth random network, randomized i
clear all;
E=100000; %External assets
S=50000; %Shock size
N=50; %Number of banks
p=0.10; %Erdos Renyi Probability
theta=0.4; %Percentage of interbank assets in total assets
Gamma=0:0.005:0.1; %Net worth as a percentage of total assets
minrand = 0.8; %minimum random number to multiply i with
maxrand = 2; %maximum random number to multiply i with
threshold = 0.001; %maximum (percentual) deviation from total I after randomization
type = 0; %Use the random network
regulator = 0; %No regulator
nGamma=length(Gamma);
Runs=50;
nFaults=zeros(Runs,nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for r=1:Runs            
        [B, e, ~, i, b, ~,w,~,~,a,c,d]=generate_banks_randomized(N,p,Gamma(gamma),theta,E,threshold,minrand,maxrand,type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate(B,a,e,i,c,d,b,w,S,s);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,gamma)=sum(faults)/N;
        waitbar(((gamma-1)*Runs+r)/nGamma/Runs,h,sprintf('%g%%',round(((gamma-1)*Runs+r)/nGamma/Runs*1000)/10));
    end
end
X=[Gamma,fliplr(Gamma)];
Y1=[max(nFaults),fliplr(min(nFaults))];

figure
fill(X,Y1,[0.5 0.5 1]);
hold on;
plot(Gamma,sum(nFaults)/Runs,'LineWidth',2);
set(gca,'FontSize',14);
xlabel('Percentage net worth');
ylabel('Number of defaults');
xlim([0 0.1]);
ylim([0 N]);
title('Random Network')
hold off;
save('randomizedgammarand.mat','nFaults','Gamma')
close(h);

% Faults vs interbank assets random network, randomized i
clear all;
E=100000;
S=50000;
N=50;
p=0.10;
Theta=0:0.1:0.5;
Gamma=[0.01 0.03 0.05];
type = 0;
regulator = 0;
minrand = 0.8; 
maxrand = 2; 
threshold = 0.001; 
nTheta=length(Theta);
nGamma=length(Gamma);
Runs=50;
nFaults=zeros(Runs,nTheta*nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for theta=1:nTheta
        for r=1:Runs
            [B, e, ~, i, b, ~,w,~,~,a,c,d]=generate_banks_randomized(N,p,Gamma(gamma),Theta(theta),E,threshold,minrand,maxrand,type,regulator);
            faults=zeros(1,N);
            deposit=zeros(1,N);
            for s=1:N
                [faults(s), de]=simulate(B,a,e,i,c,d,b,w,S,s);
                deposit(s)=1-sum(de)/sum(d);
            end
            nFaults(r,(gamma-1)*nTheta+theta)=sum(faults)/N;
            waitbar(((gamma-1)*nTheta*Runs+(theta-1)*Runs+r)/nGamma/nTheta/Runs,h,sprintf('%g%%',round(((gamma-1)*nTheta*Runs+(theta-1)*Runs+r)/nGamma/nTheta/Runs*1000)/10));
        end
    end
end
X=[Theta,fliplr(Theta)];
Y1=[max(nFaults(:,1:nTheta)),fliplr(min(nFaults(:,1:nTheta)))];
Y2=[max(nFaults(:,nTheta+(1:nTheta))),fliplr(min(nFaults(:,nTheta+(1:nTheta))))];
Y3=[max(nFaults(:,2*nTheta+(1:nTheta))),fliplr(min(nFaults(:,2*nTheta+(1:nTheta))))];
figure
fill(X,Y1,[0.5 0.5 1]);
hold on;
fill(X,Y2,[0.5 1 0.5]);
fill(X,Y3,[1 0.5 0.5]);
pl=plot(Theta,sum(nFaults(:,1:nTheta))/Runs,Theta,sum(nFaults(:,nTheta+(1:nTheta)))/Runs,Theta,sum(nFaults(:,2*nTheta+(1:nTheta)))/Runs,'LineWidth',2);
set(gca,'FontSize',14);
xlabel('Percentage interbank assets');
ylabel('Number of defaults');
legend(pl,'Net Worth 1%','Net Worth 3%','Net Worth 5%','Location','NorthWest');
xlim([0 0.5]);
ylim([0 N]);
title('Random Network')
hold off;
save('randomizedthetarand.mat','nFaults','Theta')
close(h);

% Faults vs net worth preferential network, randomized i
clear all;
E=100000;
S=50000;
N=50;
p=0.08; %Preferential attachment parameter
theta=0.4;
Gamma=0:0.005:0.1;
minrand = 0.8; 
maxrand = 2; 
threshold = 0.001; 
type = 1;
regulator = 0;
nGamma=length(Gamma);
Runs=50;
nFaults=zeros(Runs,nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for r=1:Runs
        [B, e, ~, i, b, ~,w,~,~,a,c,d]=generate_banks_randomized(N,p,Gamma(gamma),theta,E,threshold,minrand,maxrand,type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate(B,a,e,i,c,d,b,w,S,s);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,gamma)=sum(faults)/N;
        waitbar(((gamma-1)*Runs+r)/nGamma/Runs,h,sprintf('%g%%',round(((gamma-1)*Runs+r)/nGamma/Runs*1000)/10));
    end
end
X=[Gamma,fliplr(Gamma)];
Y1=[max(nFaults),fliplr(min(nFaults))];
figure
fill(X,Y1,[0.5 0.5 1]);
hold on;
plot(Gamma,sum(nFaults)/Runs,'LineWidth',2);
set(gca,'FontSize',14);
xlabel('Percentage net worth');
ylabel('Number of defaults');
xlim([0 0.1]);
ylim([0 N]);
title('Scale Free Network')
hold off;
save('randomizedgammapref.mat','nFaults','Gamma')
close(h);

% Faults vs interbank assets preferential network, randomized i
clear all;
E=100000;
S=50000;
N=50;
p=0.08;
Theta=0:0.025:0.5;
Gamma=[0.01 0.03 0.05];
minrand = 0.8; 
maxrand = 2; 
threshold = 0.001; 
type = 1;
regulator = 0;
nTheta=length(Theta);
nGamma=length(Gamma);
Runs=50;
nFaults=zeros(Runs,nTheta*nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for theta=1:nTheta
        for r=1:Runs
            [B, e, ~, i, b, ~,w,~,~,a,c,d]=generate_banks_randomized(N,p,Gamma(gamma),Theta(theta),E,threshold,minrand,maxrand,type,regulator);
            faults=zeros(1,N);
            deposit=zeros(1,N);
            for s=1:N
                [faults(s), de]=simulate(B,a,e,i,c,d,b,w,S,s);
                deposit(s)=1-sum(de)/sum(d);
            end
            nFaults(r,(gamma-1)*nTheta+theta)=sum(faults)/N;
            waitbar(((gamma-1)*nTheta*Runs+(theta-1)*Runs+r)/nGamma/nTheta/Runs,h,sprintf('%g%%',round(((gamma-1)*nTheta*Runs+(theta-1)*Runs+r)/nGamma/nTheta/Runs*1000)/10));
        end
    end
end
X=[Theta,fliplr(Theta)];
Y1=[max(nFaults(:,1:nTheta)),fliplr(min(nFaults(:,1:nTheta)))];
Y2=[max(nFaults(:,nTheta+(1:nTheta))),fliplr(min(nFaults(:,nTheta+(1:nTheta))))];
Y3=[max(nFaults(:,2*nTheta+(1:nTheta))),fliplr(min(nFaults(:,2*nTheta+(1:nTheta))))];
figure
fill(X,Y1,[0.5 0.5 1]);
hold on;
fill(X,Y2,[0.5 1 0.5]);
fill(X,Y3,[1 0.5 0.5]);
pl=plot(Theta,sum(nFaults(:,1:nTheta))/Runs,Theta,sum(nFaults(:,nTheta+(1:nTheta)))/Runs,Theta,sum(nFaults(:,2*nTheta+(1:nTheta)))/Runs,'LineWidth',2);
set(gca,'FontSize',14);
xlabel('Percentage interbank assets');
ylabel('Number of defaults');
legend(pl,'Net Worth 1%','Net Worth 3%','Net Worth 5%','Location','NorthWest');
xlim([0 0.5]);
ylim([0 N]);
title('Scale Free Network')
hold off;
save('randomizedthetapref.mat','nFaults','Theta')
close(h);
