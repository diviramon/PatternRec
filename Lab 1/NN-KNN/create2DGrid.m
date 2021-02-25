function [x,y,grid] = create2DGrid(step,varargin)

    numberClasses = length(varargin);
    min_x = zeros(numberClasses);
    max_x = zeros(numberClasses);
    min_y = zeros(numberClasses);
    max_y = zeros(numberClasses);
    
    for i = 1:numberClasses
        x = varargin{i}(:,1);
        y = varargin{i}(:,2);
        min_x(i) = min(x);
        min_y(i) = min(y);
        max_x(i) = max(x);
        max_y(i) = max(y);
    end
    
    x = min(min_x)-1:step:max(max_x)+1;
    y = min(min_y)-1:step:max(max_y)+1;
    grid = zeros(length(y), length(x));   
end
