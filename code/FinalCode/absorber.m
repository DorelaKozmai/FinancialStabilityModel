%This function is created by the previous group, and not adjusted for our
%project.
function [capital1,rest] = absorber(capital0,loss)
    capital1=max(0,capital0-loss); %capital after absorbing the shock
    rest=-min(0,capital0-loss); %remaining loss, not absorbed by x
end 
