function MED_Classifier(cluster1,cluster2,cluster3,mean1,mean2,mean3,num_clusters)

    class_means = zeros(num_clusters, 2);
    
    if num_clusters == 2
        class_means(1,:) = mean1;
        class_means(2,:) = mean2;
        
        min_x = floor(min([min(cluster1(:,1)) min(cluster2(:,1))]));
        max_x = ceil(max([max(cluster1(:,1)) max(cluster2(:,1))]));

        min_y = floor(min([min(cluster1(:,2)) min(cluster2(:,2))]));
        max_y = ceil(max([max(cluster1(:,2)) max(cluster2(:,2))]));
        
    elseif num_clusters == 3
        class_means(1,:) = mean1;
        class_means(2,:) = mean2;
        class_means(3,:) = mean3;
        
        min_x = floor(min([min(cluster1(:,1)) min(cluster2(:,1)) min(cluster3(:,1))]));
        max_x = ceil(max([max(cluster1(:,1)) max(cluster2(:,1)) max(cluster3(:,1))]));

        min_y = floor(min([min(cluster1(:,2)) min(cluster2(:,2)) min(cluster3(:,2))]));
        max_y = ceil(max([max(cluster1(:,2)) max(cluster2(:,2)) max(cluster3(:,2))]));
    end
    
    x_range = [min_x max_x];
    y_range = [min_y max_y];
    step = 0.05;
    
    [x, y] = meshgrid(x_range(1):step:x_range(2), y_range(1):step:y_range(2));
    
    cluster_size = size(x);
    xy = [x(:) y(:)];
    
    xy
    
    dist_mat = pdist2(xy, class_means);
    [~, pred_label] = min(dist_mat, [], 2);
    
    decision_map = reshape(pred_label, cluster_size);
    
    figure;

    imagesc(x_range,y_range,decision_map);
    hold on;
    set(gca,'ydir','normal');

    % colormap for the classes:
    cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
    colormap(cmap);
    plot(cluster1(:,1), cluster1(:,2),'rx')
    plot(cluster2(:,1), cluster2(:,2),'go')
    
    if num_clusters == 3
        plot(cluster3(:,1), cluster3(:,2),'b*')
    end
    
    hold off
         

end

