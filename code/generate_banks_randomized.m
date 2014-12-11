function [B, e, ireal, i, b, w,wreal,N,gamma,a,c,d] = generate_banks_randomized(N, p,gamma, theta, E,threshold,minrand,maxrand,type,regulator)
%Function to generate values of the banking system. This is an adjustment to the vanilla bank 
%generation function written by the group in the previous year, as we now randomize i. 
if type == 0
B = random_graph(N,p); % Random Graph
elseif type == 1
B = pref_graph(N,p,p);    % Scale free Graph
end

beta = 1-theta; % = percentage of external assets in total assets
A = E / beta;   % = total Assets
I = theta * A;  % = aggregate size of interbank exposures

Z = sum(sum(B));% = number of links
w = I / Z;      % = weight of any link, to define the interbank assets of a bank
if Z==0
    w=0;        % Set w and therefor also b and i to 0 if there is no link
end
i = sum(B,2)'* w; % = interbank assets per bank as number of outgoing links times the weight
b = sum(B,1) * w; % = interbank borrowing per bank as number of incoming links times the weight

% % Calculating the external assets per bank according to the old rule
e = (b - i);             
e = e + (E - sum(e))/N; 
a = e + i;     % = Total assets per bank

%Randomize the interbank assets per bank
randfac = (maxrand-minrand).*rand(1,N) + minrand; %Draw random numbers
AminE = sum(a) - sum(e); %We want to keep the total assets in the system fixed
ireal = i; %remember the real i for the regulator
i = randfac.*i; %randomize i

while sum(i) < (1-threshold)*AminE || sum(i) > (1+threshold)*AminE %if the sum of i, I = A - E is not in the desired range, make sure it gets there
    if sum(i) > (1+threshold)*AminE %If I is too large, redraw r > 1 randomly
        for j = 1:N
            if randfac(j) > 1
                i(j) = i(j)/randfac(j);
                randfac(j) = (maxrand-minrand).*rand(1,1) + minrand;
                i(j) = randfac(j)*i(j);
            end
            if sum(i) > (1-threshold)*AminE && sum(i) < (1+threshold)*AminE %stop if condition is met
                break
            end
        end
    elseif sum(i) < (1-threshold)*AminE %If I is too small, redraw r < 1 randomly
        for j = 1:N
            if randfac(j) < 1
                i(j) = i(j)/randfac(j);
                randfac(j) = (maxrand-minrand).*rand(1,1) + minrand;
                i(j) = randfac(j)*i(j);
            end
            if sum(i) > (1-threshold)*AminE && sum(i) < (1+threshold)*AminE %stop if condition is met
                break
            end
        end
    end
end

wreal = w; %remember real value of w for regulator
w = i./sum(B,2)'; %compute effective w for each bank

if regulator == 0
a = e + i;     % = total assets per bank
c = gamma * a; % = net worth per bank
d = a - c - b; % = consumer deposits per Bank
elseif regulator == 1
a = [];
c = [];
d = [];
end

end