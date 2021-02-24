function [ distance ] = GED2( X, Y, sigma_a, sigma_b, mean_a, mean_b )
 
    distance = zeros(size(X, 1), size(Y, 2));
    get_dist = @(point, sigma, mean) sqrt((point - mean) * inv(sigma) * transpose(point - mean));

    for i=1:size(X, 1)
        for j=1:size(Y, 2)
            v = [X(i, j) Y(i, j)];
            distance(i, j) = get_dist(v, sigma_a, mean_a) - get_dist(v, sigma_b, mean_b);
        end
    end
end