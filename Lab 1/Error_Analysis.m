function Error_Analysis(cluster1, cluster2, cluster3, mean1, mean2, mean3, num_clusters)

    if num_clusters == 2
        size1 = size(cluster1);
        size2 = size(cluster2);
        
        true_class_0 = zeros(size1(1),1);
        true_class_1 = ones(size2(1),1);
        
        combine = [true_class_0 true_class_1];
        true_classes = combine(:);
        
        means = cell(1,2);
        means{1} = mean1;
        means{2} = mean2;
        
        clusters = cell(1,2);
        clusters{1} = cluster1;
        clusters{2} = cluster2;
        
    elseif num_clusters == 3
        
        size1 = size(cluster1);
        size2 = size(cluster2);
        size3 = size(cluster3);
        
        true_class_0 = zeros(size1(1),1);
        true_class_1 = ones(size2(1),1);
        true_class_2 = 2*ones(size3(1),1);
        total_elements = size1(1) + size2(1) + size3(1);

        true_classes = zeros(total_elements, 1);

        % ignore my hideous code I just hardcoded this
        range1 = 1:size1(1);
        range2 = size1(1)+1:size1(1)+size2(1);
        range3 = size1(1)+size2(1)+1:size1(1)+size2(1)+ size3(1);

        true_classes(range1,:) = true_class_0;
        true_classes(range2,:) = true_class_1;
        true_classes(range3,:) = true_class_2;
        
        means = cell(1,3);
        means{1} = mean1;
        means{2} = mean2;
        means{3} = mean3;
        
        clusters = cell(1,3);
        clusters{1} = cluster1;
        clusters{2} = cluster2;
        clusters{3} = cluster3;
         
    end
    
    predicted_classes = zeros(length(clusters)*size1(1),1);
    current_index = 0;
    
    for i=1:length(clusters)
        
        current_cluster = clusters{i};
        cluster_size = size(current_cluster);
        
        for j=1:cluster_size(1)
            
            current_point = current_cluster(j,:);
            temp = zeros(num_clusters,1);
            
            for k=1:length(means)
                current_mean = means{k};
                normalized_value = norm(current_point - current_mean, 'fro');
                temp(k,:) = normalized_value;
            end
%             temp
           current_index = current_index+1;
            [~,argmin] = min(temp);
            predicted_classes(current_index,:) = argmin-1;
        end
    end
    
    sums = zeros(length(true_classes),1);
    
    for i=1:length(true_classes)
        if true_classes(i) == predicted_classes(i)
            sums(i,:) = 1;
        end
    end
    
    total_correct = sum(sums);
    prediction_error = 1 - (total_correct / length(true_classes));
    
    fprintf('Experimental Error Rate: %f percent',prediction_error)

    C = confusionmat(true_classes,predicted_classes);
    
    figure
    confusionchart(C)
    
    
    
 

end

