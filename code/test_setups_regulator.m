%This script is used to compare the random network to the scale free network in 
%the case of randomized interbank assets, with a smart or dumb regulator. It is based on the
%test setup by the group of the previous year, now applied to a different bank generation
%function with regulators.

% Faults vs regulator random i
clear all;
E=100000;
S=50000;
N=50;
p=0.10;
theta=0.4;
gamma = 0.005;
Alpha = 1:0.025:1.5;
nAlpha = length(Alpha);
threshold = 0.001;
minrand = 0.8;
maxrand = 2;
type = 0;
regulator = 1;
Runs=50;
nFaults=zeros(Runs,nAlpha);
h=waitbar(0,'0%');
for alpha=1:nAlpha
    for r=1:Runs 
        [B,a,e,i,c,d,b,w]=SmartRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,Alpha(alpha),type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate(B,a,e,i,c,d,b,w,S,s);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,alpha)=sum(faults)/N;
        waitbar(((alpha-1)*Runs+r)/nAlpha/Runs,h,sprintf('%g%%',round(((alpha-1)*Runs+r)/nAlpha/Runs*1000)/10));
    end
end
X=[Alpha,fliplr(Alpha)];
Y1=[max(nFaults),fliplr(min(nFaults))];
figure
fill(X,Y1,[0.5 0.5 1]);
hold on;
plot(Alpha,sum(nFaults)/Runs,'LineWidth',2);
set(gca,'FontSize',14);
xlabel('Regulator');
ylabel('Number of defaults');
xlim([min(Alpha) max(Alpha)]);
ylim([0 N]);
hold off;
save('smartregrand.mat','nFaults','Alpha')

% Faults vs regulator random i preferential
clear all;
E=100000;
S=50000;
N=50;
p=0.08;
theta=0.4;
gamma = 0.005;
Alpha = 1:0.025:1.5;
nAlpha = length(Alpha);
threshold = 0.001;
minrand = 0.8;
maxrand = 2;
type = 1;
regulator = 1;
Runs=50;
nFaults=zeros(Runs,nAlpha);
h=waitbar(0,'0%');
for alpha=1:nAlpha
    for r=1:Runs
        
      
        [B,a,e,i,c,d,b,w]=SmartRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,Alpha(alpha),type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate(B,a,e,i,c,d,b,w,S,s);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,alpha)=sum(faults)/N;
        waitbar(((alpha-1)*Runs+r)/nAlpha/Runs,h,sprintf('%g%%',round(((alpha-1)*Runs+r)/nAlpha/Runs*1000)/10));
    end
end
X=[Alpha,fliplr(Alpha)];
Y1=[max(nFaults),fliplr(min(nFaults))];
figure
fill(X,Y1,[0.5 0.5 1]);
hold on;
plot(Alpha,sum(nFaults)/Runs,'LineWidth',2);
set(gca,'FontSize',14);
xlabel('Regulator');
ylabel('Number of defaults');
xlim([min(Alpha) max(Alpha)]);
ylim([0 N]);
hold off;
save('smartregpref.mat','nFaults','Alpha')

% Faults vs regulator random i random
clear all;
E=100000;
S=50000;
N=50;
p=0.10;
theta=0.4;
gamma = 0.005;
Alpha = 1:0.025:1.5;
nAlpha = length(Alpha);
threshold = 0.001;
minrand = 0.8;
maxrand = 2;
type = 0;
regulator = 1;
Runs=50;
nFaults=zeros(Runs,nAlpha);
h=waitbar(0,'0%');
for alpha=1:nAlpha
    for r=1:Runs            
        [B,a,e,i,c,d,b,w]=DumbRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,Alpha(alpha),type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate(B,a,e,i,c,d,b,w,S,s);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,alpha)=sum(faults)/N;
        waitbar(((alpha-1)*Runs+r)/nAlpha/Runs,h,sprintf('%g%%',round(((alpha-1)*Runs+r)/nAlpha/Runs*1000)/10));
    end
end
X=[Alpha,fliplr(Alpha)];
Y1=[max(nFaults),fliplr(min(nFaults))];
figure
fill(X,Y1,[0.5 0.5 1]);
hold on;
plot(Alpha,sum(nFaults)/Runs,'LineWidth',2);
set(gca,'FontSize',14);
xlabel('Regulator');
ylabel('Number of defaults');
xlim([min(Alpha) max(Alpha)]);
ylim([0 N]);
hold off;
save('dumbregrand.mat','nFaults','Alpha')

% Faults vs regulator random i preferential
clear all;
E=100000;
S=50000;
N=50;
p=0.08;
theta=0.4;
gamma = 0.005;
Alpha = 1:0.025:1.5;
nAlpha = length(Alpha);
threshold = 0.001;
minrand = 0.8;
maxrand = 2;
type = 1;
regulator = 1;
Runs=50;
nFaults=zeros(Runs,nAlpha);
h=waitbar(0,'0%');
for alpha=1:nAlpha
    for r=1:Runs             
        [B,a,e,i,c,d,b,w]=DumbRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,Alpha(alpha),type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate(B,a,e,i,c,d,b,w,S,s);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,alpha)=sum(faults)/N;
        waitbar(((alpha-1)*Runs+r)/nAlpha/Runs,h,sprintf('%g%%',round(((alpha-1)*Runs+r)/nAlpha/Runs*1000)/10));
    end
end
X=[Alpha,fliplr(Alpha)];
Y1=[max(nFaults),fliplr(min(nFaults))];
figure
fill(X,Y1,[0.5 0.5 1]);
hold on;
plot(Alpha,sum(nFaults)/Runs,'LineWidth',2);
set(gca,'FontSize',14);
xlabel('Regulator');
ylabel('Number of defaults');
xlim([min(Alpha) max(Alpha)]);
ylim([0 N]);
hold off;
save('dumbregpref.mat','nFaults','Alpha')
