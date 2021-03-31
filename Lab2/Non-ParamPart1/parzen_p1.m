function [parzen] = parzen_p1(x, h, cluster,n)

parzen = zeros(size(x));

for i=1:length(x)
    sum = 0;
    for j=1:length(cluster)
        sum = sum + normpdf(x(i), cluster(j), h);
    end
    parzen(i) = 1/n * sum;
end

end