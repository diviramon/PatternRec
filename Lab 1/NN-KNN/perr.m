function [err] = perr(true_classes,predicted_classes)
    sums = zeros(length(true_classes),1);
    
    for i=1:length(true_classes)
        if true_classes(i) == predicted_classes(i)
            sums(i,:) = 1;
        end
    end
    
    total_correct = sum(sums);
    err = 1 - (total_correct / length(true_classes));
end