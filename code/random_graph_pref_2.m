% %starting distribution
% n = 50;
% p = 0.1;
%   % generate an n*n random Array with chance p per entry to be 1
%   A=(rand(n,n)<p);
%   % clear diagonal Elements out of it
%   A=A-diag(diag(A));
  
 %directed preferential attachment based on Complex Graphs and Networks by Fan Chung and Linyuan Lu
 n = 50;
 A(1,1) = 1;
 p1 = 0.1; %probability for adding a new bank connected to an old one
 p2 = 0.1; %probability for adding a new bank connected 'from' an old bank
 p3 = 1-p1-p2; %probability for connecting two existing banks
 stepweight = [p1,p2,p3];
 
 while size(A,1) < n && size(A,2) < n
     %calculate weights
     outweight = sum(A,1);
     outweight = outweight/sum(outweight);
     inweight = sum(A,2)';
     inweight = inweight/sum(inweight);
     %decide 1 out of 3 scenarios
     step = randsample(1:3, 1, true, stepweight);
     if step==1 %new outgoing
         A = [A;zeros(1,size(A,2))];
         outcol = randsample(1:size(A,2), 1, true, outweight);
         A(size(A,1),outcol) = 1;
     elseif step==2 %new incoming
         A = [A,zeros(size(A,1),1)];
         inrow = randsample(1:size(A,1), 1, true, inweight);
         A(inrow,size(A,2)) = 1;
     elseif step==3 %random link
         rout = randsample(1:size(A,2), 1, true, outweight);
         rin = randsample(1:size(A,1), 1, true, inweight);
         A(rout,rin) = 1;
     end
 end

 %set size to n by n and take out loops
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

  %finding out if it is actually scale free
nin = sum(A,1)'; %number of in
a = unique(nin);
out1 = [a,histc(nin(:),a)];
out1(:,2) = out1(:,2)/sum(out1(:,2));
figure
loglog(out1(:,1),out1(:,2),'bo')
ylabel('Fraction of nodes')
xlabel('In Degree')
 
nout = sum(A,2); %number of out
a = unique(nout);
out2 = [a,histc(nout(:),a)];
out2(:,2) = out2(:,2)/sum(out2(:,2));
figure
loglog(out2(:,1),out2(:,2),'ro')
ylabel('Fraction of nodes')
xlabel('Out Degree')
 


 
 
 
 
 
 
 
 
 
 
 