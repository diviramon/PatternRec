size1 = [100 2];
size2 = [200 2];
size3 = [150 2];;

true_class_0 = zeros(size1(1),1);
true_class_1 = ones(size2(1),1);
true_class_2 = 2*ones(size3(1),1);

total_elements = size1(1) + size2(1) + size3(1);

true_classes = zeros(total_elements, 1);

range1 = 1:size1(1);
range2 = size1(1)+1:size1(1)+size2(1);
range3 = size1(1)+size2(1)+1:size1(1)+size2(1)+ size3(1);

true_classes(range1,:) = true_class_0;
true_classes(range2,:) = true_class_1;
true_classes(range3,:) = true_class_2;

true_classes;
        