%Smart regulator, made by our group
function[B,a,e,i,c,d,b,w,Bweight] = SmartRegulator(N,p,gamma,theta,E,threshold,minrand,maxrand,alpha,type,regulator)

[B, e, breal, i, b, w,wreal,N,gamma,~,~,~,Bweight] = generate_banks_randomized(N,p,gamma,theta,E,threshold,minrand,maxrand,type,regulator);
%we get as input the randomized e. we want to chec  k if it obeys
ereal = e;
counter = 0;
% Fixed number of iterations
    while counter < 1000
        if any(b>alpha*breal) == 0 %terminate once no more adjustments have to be made
            break
        end
        ratiob = b./breal;
        ratiob(isnan(ratiob))=0; %this is to make sure we don't try to help banks without borrowings, as 0/0 = nan and nan > real numbers
        ratioe = e./ereal;
        [~,sortedratio1] = sort(ratiob,'descend'); %banks with the most borrowings compared to what they should have need help first
        [~,sortedratio2] = sort(ratioe,'ascend'); %banks with the least external assets can use them the most
        for j = sortedratio1
            condition = 0;
            if b(j) > alpha*breal(j)
                column = j;                
                for k = 1:N
                    row = sortedratio2(k);
                    if Bweight(row,column) == 0 %can't disapprove of loans that don't exist
                        continue
                    else
                        Bweight(row,column) = 0;
                        %update all relevant quantities
                        b(j) = b(j) - w(j);
                        e(j) = e(j) - w(j);
                        e(k) = e(k) + w(j);
                        i(k) = i(k) - w(j);
                        %update relevant quantities for regulator
                        breal(j) = breal(j) - wreal;
                        ereal(j) = ereal(j) - wreal;
                        ereal(k) = ereal(k) + wreal;
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