function distances = MAP(xy,n1,n2,mu1,mu2,sig1,sig2)
% using equation 36 with terms 37 - 41
Q0 = inv(sig1) - inv(sig2);
Q1 = 2*(mu2'/sig2 - mu1'/sig1);
Q2 = mu1'/sig1*mu1 - mu2'/sig2*mu2;
Q3 = log((n2/n1));
Q4 = log(det(sig1)/det(sig2));

sz = size(xy);
distances = zeros(sz(2),1);
for i = 1 : sz(2)
    x = xy(:,i);
    distances(i) = x'*Q0*x + Q1*x + Q2 + 2*Q3 + Q4;
end