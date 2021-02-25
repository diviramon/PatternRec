function [res] = nn(x, y, varargin)
    min_class = -1;
    min_dist = -1;
    mat = [x,y];

    for i = 1:length(varargin)
        for j = 1:size(varargin{i},1)
            dist = norm(mat - varargin{i}(j,:));
            if dist < min_dist || min_dist == -1
                min_dist = dist;
                min_class = i;
            end
        end
    end
    
    res = min_class;
end