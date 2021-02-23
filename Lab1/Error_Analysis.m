function Error_Analysis(cluster1, cluster2, cluster3, mean1, mean2, mean3, num_clusters)

    if num_clusters == 2
        size1 = size(cluster1);
        size2 = size(cluster2);
        
        length(cluster1(:,1))
        
        true_class_0 = zeros(size1(1),1)
        true_class_1 = ones(size2(1),1);
        
        combine = [true_class_0 true_class_1];
        true_classes = combine(:);
        
       
    end
    
 

end

