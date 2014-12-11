%This function is created entirely by our group.

%This function implements a directed preferential attachment algorithm based on the book Complex Graphs and Networks by
%Fan Chung and Linyuan Lu. The input variable n denotes the number of
%banks, while p1 and p2 are the parameters of the preferential attachment
%model, responsible for the scale free degree distributions in outgoing and
%incoming edges respectively.
function [A] = pref_graph(n,p1,p2) 
 A(1,1) = 1;
 p3 = 1-p1-p2; %probability for connecting two existing banks
 stepweight = [p1,p2,p3];
 
 while size(A,1) < n && size(A,2) < n %Making sure we end up with a square matrix
     %Calculate degree-based weights
     outweight = sum(A,1);
     outweight = outweight/sum(outweight);
     inweight = sum(A,2)';
     inweight = inweight/sum(inweight);
     
     %One out of three scenarios is chosen
     step = randsample(1:3, 1, true, stepweight);
     if step==1 %Outgoing connection from new bank v to existing bank u based on number of incoming edges for u
         A = [A;zeros(1,size(A,2))];
         outcol = randsample(1:size(A,2), 1, true, outweight);
         A(size(A,1),outcol) = 1;
     elseif step==2 %Incoming connection from new bank v to existing bank u based on number of outgoing edges for u
         A = [A,zeros(size(A,1),1)];
         inrow = randsample(1:size(A,1), 1, true, inweight);
         A(inrow,size(A,2)) = 1;
     elseif step==3 %Outgoing connection from existing bank v to existing bank u, based out and in going edges respectively
         rout = randsample(1:size(A,2), 1, true, outweight);
         rin = randsample(1:size(A,1), 1, true, inweight);
         A(rout,rin) = 1;
     end
 end

 %Set size to n by n and take out loops
 if size(A,1) < n
     while size(A,1) < n
         A = [A;zeros(1,size(A,2))];
     end
 elseif size(A,2) < n
     while size(A,2) < n
         A = [A,zeros(size(A,1),1)];
     end
 end
 A=A-diag(diag(A));
end
 
 
 
 
 
 
 
 
 