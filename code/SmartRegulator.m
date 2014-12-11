% simplified regulator
% available inputs are B, a, e, i, c, d, b, w. These are the weighted links
% matrix B, assets per bank a, interbank borrowing minus lending e,
% interbank lending i, interbank borrowing b, weights w, consumer deposits
% d, net worth per bank c.
function[B,a,e,i,c,d,b,wreal,regulator] = SmartRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,alpha,type,regulator)

[B, e, ireal, i, b, w,wreal,N,gamma,~,~,~] = generate_banks_randomized(N,p,gamma,theta,E,threshold,minrand,maxrand,type,regulator);
%we get as input the randomized e. we want to chec  k if it obeys
ereal = e;
counter = 0;
% 
    while counter < 1000
        if any(i>alpha*ireal) == 0 %terminate once no more adjustments have to be made
            break
        end
        ratioi = i./ireal;
        ratioi(isnan(ratioi))=0; %this is to make sure we don't try to help banks without interbank assets, as 0/0 = nan and nan > real numbers
        ratioe = e./ereal;
        [~,sortedratio1] = sort(ratioi,'descend'); %banks with the most interbank assets compared to what they should have need help first
        [~,sortedratio2] = sort(ratioe,'descend'); %banks with most external assets can miss them the most
        for j = sortedratio1
            condition = 0;
            if i(j) > alpha*ireal(j)
                row = j;                
                for k = 1:N
                    column = sortedratio2(k);
                    if B(row,column) == 0 %can't disapprove of loans that don't exist
                        continue
                    else
                        B(row,column) = 0;
                        e(j) = e(j) + w(j);
                        i(j) = i(j) - w(j);
                        e(column) = e(column) - w(j);
                        b(column) = b(column) - w(j);                     
                        ireal(j) = ireal(j) - wreal;
                        ereal(j) = ereal(j) + wreal;
                        ereal(column) = ereal(column) - wreal;
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