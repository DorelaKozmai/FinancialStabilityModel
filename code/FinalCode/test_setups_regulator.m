% This script is used to compare the random network to the scale free network in 
% the case of randomized interbank assets, with a smart or dumb regulator. It is based on the
% test setup by the group of the previous year, now applied to a different bank generation
% function with regulators. The figures are in a different script.

% Faults vs regulator random b
clear all;
E=100000;
S=50000;
N=50;
p=0.10;
theta=0.2;
gamma = 0.005;
Alpha = 1:0.05:2;
nAlpha = length(Alpha);
threshold = 0.001;
minrand = 0.8;
maxrand = 2;
type = 0;
regulator = 1;
Runs=100;
nFaults=zeros(Runs,nAlpha);
h=waitbar(0,'0%');
for alpha=1:nAlpha
    for r=1:Runs 
        [B,a,e,i,c,d,b,w,Bweight]=SmartRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,Alpha(alpha),type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate_randomized(B,a,e,i,c,d,b,w,S,s,Bweight);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,alpha)=sum(faults)/N;
        waitbar(((alpha-1)*Runs+r)/nAlpha/Runs,h,sprintf('%g%%',round(((alpha-1)*Runs+r)/nAlpha/Runs*1000)/10));
    end
end
save('smartregrand.mat','nFaults','Alpha','Runs','N')

% Faults vs regulator random b preferential
clear all;
E=100000;
S=50000;
N=50;
p=0.08;
theta=0.2;
gamma = 0.005;
Alpha = 1:0.05:2;
nAlpha = length(Alpha);
threshold = 0.001;
minrand = 0.8;
maxrand = 2;
type = 1;
regulator = 1;
Runs=100;
nFaults=zeros(Runs,nAlpha);
h=waitbar(0,'0%');
for alpha=1:nAlpha
    for r=1:Runs 
        [B,a,e,i,c,d,b,w,Bweight]=SmartRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,Alpha(alpha),type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate_randomized(B,a,e,i,c,d,b,w,S,s,Bweight);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,alpha)=sum(faults)/N;
        waitbar(((alpha-1)*Runs+r)/nAlpha/Runs,h,sprintf('%g%%',round(((alpha-1)*Runs+r)/nAlpha/Runs*1000)/10));
    end
end
save('smartregpref.mat','nFaults','Alpha','Runs','N')

% Faults vs regulator random b random
clear all;
E=100000;
S=50000;
N=50;
p=0.10;
theta=0.2;
gamma = 0.005;
Alpha = 1:0.05:2;
nAlpha = length(Alpha);
threshold = 0.001;
minrand = 0.8;
maxrand = 2;
type = 0;
regulator = 1;
Runs=100;
nFaults=zeros(Runs,nAlpha);
h=waitbar(0,'0%');
for alpha=1:nAlpha
    for r=1:Runs            
        [B,a,e,i,c,d,b,w,Bweight]=RandomRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,Alpha(alpha),type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate_randomized(B,a,e,i,c,d,b,w,S,s,Bweight);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,alpha)=sum(faults)/N;
        waitbar(((alpha-1)*Runs+r)/nAlpha/Runs,h,sprintf('%g%%',round(((alpha-1)*Runs+r)/nAlpha/Runs*1000)/10));
    end
end
save('randregrand.mat','nFaults','Alpha','Runs','N')

% Faults vs regulator random b preferential
clear all;
E=100000;
S=50000;
N=50;
p=0.08;
theta=0.2;
gamma = 0.005;
Alpha = 1:0.05:2;
nAlpha = length(Alpha);
threshold = 0.001;
minrand = 0.8;
maxrand = 2;
type = 1;
regulator = 1;
Runs=100;
nFaults=zeros(Runs,nAlpha);
h=waitbar(0,'0%');
for alpha=1:nAlpha
    for r=1:Runs             
        [B,a,e,i,c,d,b,w,Bweight]=RandomRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,Alpha(alpha),type,regulator);
        faults=zeros(1,N);
        deposit=zeros(1,N);
        for s=1:N
            [faults(s), de]=simulate_randomized(B,a,e,i,c,d,b,w,S,s,Bweight);
            deposit(s)=sum(de)/sum(d);
        end
        nFaults(r,alpha)=sum(faults)/N;
        waitbar(((alpha-1)*Runs+r)/nAlpha/Runs,h,sprintf('%g%%',round(((alpha-1)*Runs+r)/nAlpha/Runs*1000)/10));
    end
end
save('randregpref.mat','nFaults','Alpha','Runs','N')

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
alpha = 1.2;
threshold = 0.001; %maximum (percentual) deviation from total I after randomization
type = 0; %Use the random network
regulator = 1; %Regulator
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for r=1:Runs
        [B,a,e,i,c,d,b,w,Bweight]=SmartRegulator(N,p,Gamma(gamma),theta,E,threshold,minrand,maxrand,alpha,type,regulator);
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
save('smartgammarand.mat','nFaults','Gamma','N','Runs')
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
regulator = 1;
minrand = 0.8; 
maxrand = 2; 
alpha = 1.2;
threshold = 0.001; 
nTheta=length(Theta);
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nTheta*nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for theta=1:nTheta
        for r=1:Runs
            [B,a,e,i,c,d,b,w,Bweight]=SmartRegulator(N,p,Gamma(gamma),Theta(theta),E,threshold,minrand,maxrand,alpha,type,regulator);
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
save('smartthetarand.mat','nFaults','Theta','N','Runs','Gamma','nGamma','nTheta')
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
alpha = 1.2;
threshold = 0.001; 
type = 1;
regulator = 1;
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for r=1:Runs
        [B,a,e,i,c,d,b,w,Bweight]=SmartRegulator(N,p,Gamma(gamma),theta,E,threshold,minrand,maxrand,alpha,type,regulator);
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
save('smartgammapref.mat','nFaults','Gamma','N','Runs')
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
regulator = 1;
alpha = 1.2;
nTheta=length(Theta);
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nTheta*nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for theta=1:nTheta
        for r=1:Runs
            [B,a,e,i,c,d,b,w,Bweight]=SmartRegulator(N,p,Gamma(gamma),Theta(theta),E,threshold,minrand,maxrand,alpha,type,regulator);
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
save('smartthetapref.mat','nFaults','Theta','N','Runs','Gamma','nGamma','nTheta')
close(h);
