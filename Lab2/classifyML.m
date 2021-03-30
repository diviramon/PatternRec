function [res] = classifyML(x,y,varargin)
    % ML just a special case of MAP with uniform priors
    % Therefore, highest p(CASE|(x,y)) will be closest class
    num_class = length(varargin);
    min_class = -1;
    min_p = -1;
    
    for i = 1:num_class
        mat = [x,y]';
        mu = mean(varargin{i})';
        sig = cov(varargin{i});
        p = (1/sqrt(det(sig)))*exp(-0.5 * ((mat-mu)' * inv(sig) * (mat-mu)));
        if p > min_p || min_p == -1
            min_p = p;
            min_class = i;
        end
    end
    if min_class ~= -1
        res = min_class;
    end
end
    