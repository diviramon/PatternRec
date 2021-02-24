
clear;
close all;
rng(4);

% Creates the samples for each class
n_a = 200; 
mu_a = [5, 10];
sigma_a = [8, 0; 0, 4];
n_b = 200; 
mu_b = [10, 15];
sigma_b = [8, 0; 0, 4];
[theta_A, cont_Axes_A] = eigen_info(sigma_a);
[theta_B, cont_Axes_B] = eigen_info(sigma_b); 
n_c = 100; 
mu_c = [5, 10];
sigma_c = [8, 4; 4, 40];
n_d = 200; 
mu_d = [15, 10];
sigma_d = [8, 0; 0, 8];
n_e = 150; 
mu_e = [10, 5];
sigma_e = [10, -5; -5, 20];

[theta_C, cont_Axes_C] = eigen_info(sigma_c);
[theta_D, cont_Axes_D] = eigen_info(sigma_d); 
[theta_E, cont_Axes_E] = eigen_info(sigma_e); 

%Creating Clusters
Cluster_A = create_cluster(n_a, mu_a, sigma_a);
Cluster_B = create_cluster(n_b, mu_b, sigma_b);
Cluster_C = create_cluster(n_c, mu_c, sigma_c);
Cluster_D = create_cluster(n_d, mu_d, sigma_d);
Cluster_E = create_cluster(n_e, mu_e, sigma_e);

% Computing the classifiers
step = 0.05; 
%Class 1 - computing the classifiers
min_x = floor(min([min(Cluster_A(:,1)) min(Cluster_B(:,1))]));
max_x = ceil(max([max(Cluster_A(:,1)) max(Cluster_B(:,1))]));
min_y = floor(min([min(Cluster_A(:,2)) min(Cluster_B(:,2))]));
max_y = ceil(max([max(Cluster_A(:,2)) max(Cluster_B(:,2))]));
x_range = [min_x max_x];
y_range = [min_y max_y];
[X1, Y1] = meshgrid(x_range(1):step:x_range(2), y_range(1):step:y_range(2));
GED1 = GED(X1,Y1, sigma_a, sigma_b, mu_a, mu_b);

%Class 2 - computing the classifiers
min_x = floor(min([min(Cluster_C(:,1)) min(Cluster_D(:,1)) min(Cluster_E(:,1))]));
max_x = ceil(max([max(Cluster_C(:,1)) max(Cluster_D(:,1)) max(Cluster_E(:,1))]));
min_y = floor(min([min(Cluster_C(:,2)) min(Cluster_D(:,2)) min(Cluster_E(:,2))]));
max_y = ceil(max([max(Cluster_C(:,2)) max(Cluster_D(:,2)) max(Cluster_E(:,2))]));
x_range = [min_x max_x];
y_range = [min_y max_y];
[X2, Y2] = meshgrid(x_range(1):step:x_range(2), y_range(1):step:y_range(2));
GED_cd = GED(X2, Y2, sigma_c, sigma_d, mu_c, mu_d);
GED_ec = GED(X2, Y2, sigma_e, sigma_c, mu_e, mu_c);
GED_de = GED(X2, Y2, sigma_d, sigma_e, mu_d, mu_e);


GED2 = zeros(size(X2, 1), size(Y2, 2));
%Returns where the point belongs to
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        label = 0;
        if GED_cd(i, j) >= 0 && GED_de(i, j) <= 0
            label = 2;
        elseif GED_ec(i, j) >= 0 && GED_cd(i, j) <= 0
            label = 1;
        elseif GED_de(i, j) >= 0 && GED_ec(i, j) <= 0
            label = 3;
        end
        GED2(i, j) = label;
    end
end


LINE_WIDTH = 1;

% Class 1 Plot
figure(1);
hold on;
map = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
colormap(map);
contour(X1,Y1,GED1, [0, 0], 'Color', 'magenta', 'LineWidth', LINE_WIDTH);
Cluster_A_scatter = scatter(Cluster_A(:, 1), Cluster_A(:, 2), 'ro');
Cluster_B_scatter = scatter(Cluster_B(:, 1), Cluster_B(:, 2), 'b.');
plot_ellipse(mu_a(1),mu_a(2),theta_A, cont_Axes_A(2,2), cont_Axes_A(1,1), 'r');
plot_ellipse(mu_b(1),mu_b(2),theta_B, cont_Axes_B(2,2), cont_Axes_B(1,1), 'b');
plot(mu_a(1), mu_a(2), 'go');
plot(mu_b(1), mu_b(2), 'g.');
hold off;
title('GED decision boundary for case 1');
legend([Cluster_A_scatter, Cluster_B_scatter], {'Class A', 'Class B'}, 'Location', 'southeast');

% Class 2 Plot
figure(2);
hold on;
contour(X2, Y2, GED2, 'Color', 'magenta');
class_c = scatter(Cluster_C(:, 1), Cluster_C(:, 2), 'ro');
class_d = scatter(Cluster_D(:, 1), Cluster_D(:, 2), 'b.');
class_e = scatter(Cluster_E(:, 1), Cluster_E(:, 2), 'k*');
plot_ellipse(mu_c(1),mu_c(2), theta_C, cont_Axes_C(2,2), cont_Axes_C(1,1), 'r');
plot_ellipse(mu_d(1),mu_d(2), theta_D, cont_Axes_D(2,2), cont_Axes_D(1,1), 'b');
plot_ellipse(mu_e(1),mu_e(2), theta_E, cont_Axes_E(2,2), cont_Axes_E(1,1), 'k');
plot(mu_c(1), mu_c(2), 'go');
plot(mu_d(1), mu_d(2), 'g.');
plot(mu_e(1), mu_e(2), 'g*');
title('GED decision boundary for case 2');
legend([class_c,class_d,class_e], {'Class C', 'Class D', 'Class E'}, 'Location', 'southeast');
hold off;

