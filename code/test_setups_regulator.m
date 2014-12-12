% This script is used to compare the random network to the scale free network in 
% the case of randomized interbank assets, with a smart or dumb regulator. It is based on the
% test setup by the group of the previous year, now applied to a different bank generation
% function with regulators.

% Faults vs regulator random i
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

% Faults vs regulator random i preferential
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

% Faults vs regulator random i random
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

% Faults vs regulator random i preferential
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
