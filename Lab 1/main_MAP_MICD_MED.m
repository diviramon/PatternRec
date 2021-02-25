clear
close all

%%%%%%%%%%%%%
% CASE 1:   %
%%%%%%%%%%%%%

% Class A: 
N_a = 200;
mu_A = [5 10]';
sig_A = [8 0; 0 4];

% Class B: 
N_b = 200;
mu_B = [10 15]';
sig_B = [8 0; 0 4];

cluster_A = create_cluster(N_a, mu_A', sig_A);
cluster_B = create_cluster(N_b, mu_B', sig_B);
[theta_A, cont_Axes_A] = eigen_info(sig_A);
[theta_B, cont_Axes_B] = eigen_info(sig_B); 

% clusters range
min_x = floor(min([min(cluster_A(:,1)) min(cluster_B(:,1))]));
max_x = ceil(max([max(cluster_A(:,1)) max(cluster_B(:,1))]));
min_y = floor(min([min(cluster_A(:,2)) min(cluster_B(:,2))]));
max_y = ceil(max([max(cluster_A(:,2)) max(cluster_B(:,2))]));

x_range = [min_x max_x];
y_range = [min_y max_y];
step = 0.05;

% create grid
[x, y] = meshgrid(x_range(1):step:x_range(2), y_range(1):step:y_range(2));

cluster_size = size(x);
xy = [x(:) y(:)];

% classify MAP
dist = MAP(xy',N_a,N_b,mu_A,mu_B,sig_A,sig_B);
labels = dist > 0;
labels2 = dist < 0;
labels = labels - labels2;
decision_map = reshape(labels, cluster_size);

% classify MICD
dist = GED(xy',mu_A,mu_B,sig_A,sig_B);
labels = dist > 0;
labels2 = dist < 0;
labels = labels - labels2;
decision_micd = reshape(labels, cluster_size);

% classify MED
decision_med = MED_Classifier(cluster_A, cluster_B, 0, mu_A, mu_B, 0, 2);
hold on
plot_ellipse(mu_A(1), mu_A(2), theta_A, cont_Axes_A(2,2), cont_Axes_A(1,1))
plot_ellipse(mu_B(1), mu_B(2), theta_B, cont_Axes_B(2,2), cont_Axes_B(1,1))
title('MED Decision Boundary Case 1')

% plot boundaries
figure;
hold on;
set(gca,'ydir','normal');
% colormap for the classes:
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
colormap(cmap);
contour(x,y,decision_map,'k');
contour(x,y,decision_micd,'m');
contour(x,y,decision_med,'y');
scatter(cluster_A(:,1), cluster_A(:,2),7,'r','filled')
scatter(cluster_B(:,1), cluster_B(:,2),7,'b','filled')
plot_ellipse(mu_A(1), mu_A(2), theta_A, cont_Axes_A(2,2), cont_Axes_A(1,1))
plot_ellipse(mu_B(1), mu_B(2), theta_B, cont_Axes_B(2,2), cont_Axes_B(1,1))
xlabel('x_1');
ylabel('x_2');
title("MAP (black) - MICD (magenta) - MED (yellow) Decision Boundaries Case 1");
hold off

%%%%%%%%%%%%%
% CASE 2:   %
%%%%%%%%%%%%%
% Class C: 
N_c = 100;
mu_C = [5 10]';
sig_C = [8 4; 4 40];

% Class D: 
N_d = 200;
mu_D = [15 10]';
sig_D = [8 0; 0 8];

% Class E:
N_e = 150;
mu_E = [10 5]';
sig_E = [10 -5; -5 20];

% create clusters
cluster_C = create_cluster(N_c, mu_C', sig_C);
cluster_D = create_cluster(N_d, mu_D', sig_D);
cluster_E = create_cluster(N_e, mu_E', sig_E);
[theta_C, cont_Axes_C] = eigen_info(sig_C);
[theta_D, cont_Axes_D] = eigen_info(sig_D); 
[theta_E, cont_Axes_E] = eigen_info(sig_E); 

% clusters range
min_x = floor(min([min(cluster_C(:,1)) min(cluster_D(:,1)) min(cluster_E(:,1))]));
max_x = ceil(max([max(cluster_C(:,1)) max(cluster_D(:,1)) max(cluster_E(:,1))]));
min_y = floor(min([min(cluster_C(:,2)) min(cluster_D(:,2)) min(cluster_E(:,2))]));
max_y = ceil(max([max(cluster_C(:,2)) max(cluster_D(:,2)) max(cluster_E(:,2))]));

x_range = [min_x max_x];
y_range = [min_y max_y];
step = 0.05;

% create grid
[x, y] = meshgrid(x_range(1):step:x_range(2), y_range(1):step:y_range(2));

cluster_size = size(x);
xy = [x(:) y(:)];

% classify MAP
distcd = MAP(xy',N_c,N_d,mu_C,mu_D,sig_C,sig_D);
distde = MAP(xy',N_d,N_e,mu_D,mu_E,sig_D,sig_E);
distec = MAP(xy',N_e,N_c,mu_E,mu_C,sig_E,sig_C);
labelsC = (distcd < 0).*(distec > 0);
labelsD = 2*(distde < 0).*(distcd > 0);
labelsE = 3*(distec < 0).*(distde > 0);
labels = labelsC + labelsD + labelsE;
decision_map = reshape(labels, cluster_size);

% classify MICD
distcd = GED(xy',mu_C,mu_D,sig_C,sig_D);
distde = GED(xy',mu_D,mu_E,sig_D,sig_E);
distec = GED(xy',mu_E,mu_C,sig_E,sig_C);
labelsC = (distcd < 0).*(distec > 0);
labelsD = 2*(distde < 0).*(distcd > 0);
labelsE = 3*(distec < 0).*(distde > 0);
labels = labelsC + labelsD + labelsE;
decision_micd = reshape(labels, cluster_size);

% classify MED
decision_med = MED_Classifier(cluster_C, cluster_D, cluster_E, mu_C, mu_D, mu_E, 3);
hold on
plot_ellipse(mu_C(1), mu_C(2), theta_C, cont_Axes_C(2,2), cont_Axes_C(1,1))
plot_ellipse(mu_D(1), mu_D(2), theta_D, cont_Axes_D(2,2), cont_Axes_D(1,1))
plot_ellipse(mu_E(1), mu_E(2), theta_E, cont_Axes_E(2,2), cont_Axes_E(1,1))
title('MED Decision Boundary Case 2')

% plot results
figure
hold on
set(gca,'ydir','normal');
% colormap for the classes:
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
colormap(cmap);
contour(x,y,decision_map,'k');
contour(x,y,decision_micd,'m');
contour(x,y,decision_med,'y');
scatter(cluster_C(:,1), cluster_C(:,2),7,'r','filled')
scatter(cluster_D(:,1), cluster_D(:,2),7,'b','filled')
scatter(cluster_E(:,1), cluster_E(:,2),7,'g','filled')
plot_ellipse(mu_C(1), mu_C(2), theta_C, cont_Axes_C(2,2), cont_Axes_C(1,1))
plot_ellipse(mu_D(1), mu_D(2), theta_D, cont_Axes_D(2,2), cont_Axes_D(1,1))
plot_ellipse(mu_E(1), mu_E(2), theta_E, cont_Axes_E(2,2), cont_Axes_E(1,1))
xlabel('x_1');
ylabel('x_2');
title("MAP (black) - MICD (magenta) - MED (yellow) Decision Boundaries Case 2");
hold off