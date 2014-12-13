%This script is used to compare the random network to the scale free network in 
%the case of randomized interbank assets, without a regulator. It is based on the
%test setup by the group of the previous year, now applied to a different bank generation
%function and having the plots in a different figure.

% Faults vs net worth random network, randomized b
clear all;
E=100000; %External assets
S=50000; %Shock size
N=50; %Number of banks
p=0.10; %Erdos Renyi Probability
theta=0.2; %Percentage of interbank assets in total assets
Gamma=0:0.005:0.1; %Net worth as a percentage of total assets
minrand = 0.8; %minimum random number to multiply i with
maxrand = 2; %maximum random number to multiply i with
threshold = 0.001; %maximum (percentual) deviation from total I after randomization
type = 0; %Use the random network
regulator = 0; %No regulator
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for r=1:Runs            
        [B, e, ~, i, b, w,~,~,~,a,c,d,Bweight]=generate_banks_randomized(N,p,Gamma(gamma),theta,E,threshold,minrand,maxrand,type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate_randomized(B,a,e,i,c,d,b,w,S,s,Bweight);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,gamma)=sum(faults)/N;
        waitbar(((gamma-1)*Runs+r)/nGamma/Runs,h,sprintf('%g%%',round(((gamma-1)*Runs+r)/nGamma/Runs*1000)/10));
    end
end
save('randomizedgammarand.mat','nFaults','Gamma','N','Runs')
close(h);

% Faults vs interbank assets random network, randomized b
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
Runs=100;
nFaults=zeros(Runs,nTheta*nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for theta=1:nTheta
        for r=1:Runs
            [B, e, ~, i, b, w,~,~,~,a,c,d,Bweight]=generate_banks_randomized(N,p,Gamma(gamma),Theta(theta),E,threshold,minrand,maxrand,type,regulator);
            faults=zeros(1,N);
            deposit=zeros(1,N);
            for s=1:N
                [faults(s), de]=simulate_randomized(B,a,e,i,c,d,b,w,S,s,Bweight);
                deposit(s)=1-sum(de)/sum(d);
            end
            nFaults(r,(gamma-1)*nTheta+theta)=sum(faults)/N;
            waitbar(((gamma-1)*nTheta*Runs+(theta-1)*Runs+r)/nGamma/nTheta/Runs,h,sprintf('%g%%',round(((gamma-1)*nTheta*Runs+(theta-1)*Runs+r)/nGamma/nTheta/Runs*1000)/10));
        end
    end
end
save('randomizedthetarand.mat','nFaults','Theta','N','Runs','Gamma','nGamma','nTheta')
close(h);

% Faults vs net worth preferential network, randomized b
clear all;
E=100000;
S=50000;
N=50;
p=0.08; %Preferential attachment parameter
theta=0.2;
Gamma=0:0.005:0.1;
minrand = 0.8; 
maxrand = 2; 
threshold = 0.001; 
type = 1;
regulator = 0;
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for r=1:Runs
        [B, e, ~, i, b, w,~,~,~,a,c,d,Bweight]=generate_banks_randomized(N,p,Gamma(gamma),theta,E,threshold,minrand,maxrand,type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate_randomized(B,a,e,i,c,d,b,w,S,s,Bweight);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,gamma)=sum(faults)/N;
        waitbar(((gamma-1)*Runs+r)/nGamma/Runs,h,sprintf('%g%%',round(((gamma-1)*Runs+r)/nGamma/Runs*1000)/10));
    end
end
save('randomizedgammapref.mat','nFaults','Gamma','N','Runs')
close(h);

% Faults vs interbank assets preferential network, randomized b
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
Runs=100;
nFaults=zeros(Runs,nTheta*nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for theta=1:nTheta
        for r=1:Runs
            [B, e, ~, i, b, w,~,~,~,a,c,d,Bweight]=generate_banks_randomized(N,p,Gamma(gamma),Theta(theta),E,threshold,minrand,maxrand,type,regulator);
            faults=zeros(1,N);
            deposit=zeros(1,N);
            for s=1:N
                [faults(s), de]=simulate_randomized(B,a,e,i,c,d,b,w,S,s,Bweight);
                deposit(s)=1-sum(de)/sum(d);
            end
            nFaults(r,(gamma-1)*nTheta+theta)=sum(faults)/N;
            waitbar(((gamma-1)*nTheta*Runs+(theta-1)*Runs+r)/nGamma/nTheta/Runs,h,sprintf('%g%%',round(((gamma-1)*nTheta*Runs+(theta-1)*Runs+r)/nGamma/nTheta/Runs*1000)/10));
        end
    end
end
save('randomizedthetapref.mat','nFaults','Theta','N','Runs','Gamma','nGamma','nTheta')
close(h);
