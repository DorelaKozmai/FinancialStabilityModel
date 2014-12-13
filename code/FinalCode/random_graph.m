%This function is created by the previous group, and not adjusted for our
%project, with the exception of comments.

%This function constructs a network of zeroes and ones, where the
%probability of a one being present is given by the input variable p, and
%the dimensions of the square network are given by the input variable n.
function A = random_graph(n, p)
  % generate an n*n random Array with chance p per entry to be 1
  A=(rand(n,n)<p);
  % clear diagonal Elements out of it
  A=A-diag(diag(A)==1);
end