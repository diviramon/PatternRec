function [res] = knn(x,y,varargin)
    mat = [x,y];
    dist = cell(1,length(varargin));
    avg = zeros(1,length(varargin));
    
    for i = 1:length(varargin)
        dist{i} = zeros(1,size(varargin{i},1));
        for j = 1:size(varargin{i},1)
            dist{i}(1,j) = norm(mat - varargin{i}(j,:));
        end
        dist{i} = sort(dist{i});
        avg(i) = sum(dist{i}(1:5)/5);
    end
    
    [~,res] = min(avg);
end