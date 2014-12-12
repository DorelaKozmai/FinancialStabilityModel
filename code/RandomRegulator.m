% simplified regulator
% available inputs are B, a, e, i, c, d, b, w. These are the weighted links
% matrix B, assets per bank a, interbank borrowing minus lending e,
% interbank lending i, interbank borrowing b, weights w, consumer deposits
% d, net worth per bank c.
function[B,a,e,i,c,d,b,w,Bweight] = RandomRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,alpha,type,regulator)

[B, e, breal, i, b, w,wreal,N,gamma,~,~,~,Bweight] = generate_banks_randomized(N,p,gamma,theta,E,threshold,minrand,maxrand,type,regulator);
counter = 0;
%
while counter < 1000
    if any(b>alpha*breal) == 0 %terminate once no more adjustments have to be made
        break
    end
    randombanks1 = randperm(N);
    randombanks2 = randperm(N);
    for j = randombanks1
        condition = 0;
        if b(j) > alpha*breal(j)
            column = j;
            for k = randombanks2
                row = k;
                if B(row,column) == 0 %can't disapprove of loans that don't exist
                    continue
                else
                    Bweight(row,column) = 0;
                    b(j) = b(j) - w(j);
                    e(j) = e(j) - w(j);
                    e(k) = e(k) + w(j);
                    i(k) = i(k) - w(j);
                    %update relevant quantities for regulator
                    breal(j) = breal(j) - wreal;
                    condition = 1;
                    break
                end
            end
        else
            continue
        end
        if condition == 1
            break
        end
    end
    counter = counter+1;
end


a = e + i;     % = Total assets per bank
c = gamma * a; % = Net worth per bank
d = a - c - b; % = consumer deposits per Bank
end