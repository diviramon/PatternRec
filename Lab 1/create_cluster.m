function cluster = create_cluster(N,mu,sigma)

R = chol(sigma);
cluster = repmat(mu,N,1) + randn(N,2)*R;

end

