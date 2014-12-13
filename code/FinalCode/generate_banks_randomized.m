function [B, e, breal, i, b, w,wreal,N,gamma,a,c,d,Bweight] = generate_banks_randomized(N, p,gamma, theta, E,threshold,minrand,maxrand,type,regulator)
%Function to generate values of the banking system. This is an adjustment to the vanilla bank 
%generation function written by the group in the previous year, as we now
%randomize b while keeping sum(b) = B fixed.
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

%randomize b while keeping B fixed
b = sum(B,1) * w; 
randfac = (maxrand-minrand).*rand(1,N) + minrand; 
Btotal = sum(b); 
breal = b; 
b = randfac.*b; 

while sum(b) < (1-threshold)*Btotal || sum(b) > (1+threshold)*Btotal %if the sum of b = B is not in the desired range, make sure it gets there
    if sum(b) > (1+threshold)*Btotal %If B is too large, redraw r > 1 randomly
        for j = 1:N
            if randfac(j) > 1
                b(j) = b(j)/randfac(j);
                randfac(j) = (maxrand-minrand).*rand(1,1) + minrand;
                b(j) = randfac(j)*b(j);
            end
            if sum(b) > (1-threshold)*Btotal && sum(b) < (1+threshold)*Btotal %stop if condition is met
                break
            end
        end
    elseif sum(b) < (1-threshold)*Btotal %If B is too small, redraw r < 1 randomly
        for j = 1:N
            if randfac(j) < 1
                b(j) = b(j)/randfac(j);
                randfac(j) = (maxrand-minrand).*rand(1,1) + minrand;
                b(j) = randfac(j)*b(j);
            end
            if sum(b) > (1-threshold)*Btotal && sum(b) < (1+threshold)*Btotal %stop if condition is met
                break
            end
        end
    end
end

%Giving each bank a characteristic w
wreal = w; %remember real value of w for regulator
w = b./sum(B,1); %compute effective w for each bank
w(isnan(w)) = 0;
for j = 1:N
    Bweight(:,j) = w(j)*B(:,j);
end

% Calculating relevant quantities per bank
i = sum(Bweight,2)';
e = (b - i);             
e = e + (E - sum(e))/N; 

if regulator == 0 
a = e + i;     % = total assets per bank
c = gamma * a; % = net worth per bank
d = a - c - b; % = consumer deposits per Bank
elseif regulator == 1 %if the regulator is used, the above is calculated in there
a = [];
c = [];
d = [];
end
end