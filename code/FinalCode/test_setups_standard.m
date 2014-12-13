%This script is used to compare the random network to the scale free network in 
%the vanilla model set up by the group of the previous year. Some modifications have
%been made to the existing script from last year, in the form of various 
%parameter changes and small tweaks to the loops that were put in. Moreover, the 
%preferential network has been added, as this is a new addition, and data
%is now saved. The figures are in a different script.

% Faults vs net worth random network
clear all;
E=100000; %External assets
S=100000; %Shock size
N=50; %Number of banks
p=0.10; %Erdos Renyi Probability
theta=0.2; %Percentage of interbank assets in total assets
Gamma=0:0.005:0.1; %Net worth as a percentage of total assets
type = 0; %Use the random network
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for r=1:Runs
        [B,a,e,i,c,d,b,w]=generate_banks(N,p,Gamma(gamma),theta,E,type);
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
save('gammarand.mat','nFaults','Gamma','N','Runs')
close(h);
  
% Faults vs interbank assets random network
clear all;
E=100000;
S=100000;
N=50;
p=0.10;
Theta=0:0.1:0.5;
Gamma=[0.01 0.03 0.05];
type = 0;
nTheta=length(Theta);
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nTheta*nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for theta=1:nTheta
        for r=1:Runs
            [B,a,e,i,c,d,b,w]=generate_banks(N,p,Gamma(gamma),Theta(theta),E,type);
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
save('thetarand.mat','nFaults','Theta','N','Runs','Gamma','nGamma','nTheta')
close(h);

% Faults vs net worth preferential network
clear all;
E=100000;
S=100000;
N=50;
p=0.08; %Preferential attachment parameter
theta=0.2;
Gamma=0:0.005:0.1;
type = 1;
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for r=1:Runs
        [B,a,e,i,c,d,b,w]=generate_banks(N,p,Gamma(gamma),theta,E,type);
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
save('gammapref.mat','nFaults','Gamma','N','Runs')
close(h);

% Faults vs interbank assets preferential network
clear all;
E=100000;
S=100000;
N=50;
p=0.08;
Theta=0:0.025:0.5;
Gamma=[0.01 0.03 0.05];
type = 1;
nTheta=length(Theta);
nGamma=length(Gamma);
Runs=100;
nFaults=zeros(Runs,nTheta*nGamma);
h=waitbar(0,'0%');
for gamma=1:nGamma
    for theta=1:nTheta
        for r=1:Runs
            [B,a,e,i,c,d,b,w]=generate_banks(N,p,Gamma(gamma),Theta(theta),E,type);
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
save('thetapref.mat','nFaults','Theta','N','Runs','Gamma','nGamma','nTheta')
close(h);
