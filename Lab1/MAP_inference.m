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

% classify
dist = MAP(xy',N_a,N_b,mu_A,mu_B,sig_A,sig_B);
labels = dist > 0;
labels2 = dist < 0;
labels = labels - labels2;
decision_map = reshape(labels, cluster_size);

% plot results
figure;
hold on;
imagesc(x_range,y_range,decision_map);
set(gca,'ydir','normal');
% colormap for the classes:
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
colormap(cmap);
contour(x,y,decision_map,'k');
scatter(cluster_A(:,1), cluster_A(:,2),7,'r','filled')
scatter(cluster_B(:,1), cluster_B(:,2),7,'b','filled')
plot_ellipse(mu_A(1), mu_A(2), theta_A, cont_Axes_A(2,2), cont_Axes_A(1,1))
plot_ellipse(mu_B(1), mu_B(2), theta_B, cont_Axes_B(2,2), cont_Axes_B(1,1))
xlabel('x_1');
ylabel('x_2');
title("MAP Decision Boundary Case 1");
hold off

% error analysis
distA = MAP(cluster_A',N_a,N_b,mu_A,mu_B,sig_A,sig_B);
distB = MAP(cluster_B',N_a,N_b,mu_A,mu_B,sig_A,sig_B);
trueA = ones(N_a,1);
predA = 1*(distA < 0); % multiply by one to make it a double 

trueB = zeros(N_b,1);
predB = distB > 0; % used to count the number of correct predictions
predB2 = 1*(distB <= 0); % used for confusion matrix since actual label is zero

total_correct = sum(predA) + sum(predB);
prediction_error = 1 - (total_correct / (N_a + N_b));
fprintf('MAP Case 2 Experimental Error Rate: %f percent\n',prediction_error)

% confusion matrix
C = confusionmat([trueA ;trueB],[predA ;predB2],"Order",[1,0]);
figure
confusionchart(C,["A","B"])
title("Confusion Matrix MAP - Case 1")

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

% classify
distcd = MAP(xy',N_c,N_d,mu_C,mu_D,sig_C,sig_D);
distde = MAP(xy',N_d,N_e,mu_D,mu_E,sig_D,sig_E);
distec = MAP(xy',N_e,N_c,mu_E,mu_C,sig_E,sig_C);
labelsC = (distcd < 0).*(distec > 0);
labelsD = 2*(distde < 0).*(distcd > 0);
labelsE = 3*(distec < 0).*(distde > 0);
labels = labelsC + labelsD + labelsE;
decision_map = reshape(labels, cluster_size);

% plot results
figure
hold on
imagesc(x_range,y_range,decision_map);
set(gca,'ydir','normal');
% colormap for the classes:
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
colormap(cmap);
contour(x,y,decision_map,'k');
scatter(cluster_C(:,1), cluster_C(:,2),7,'r','filled')
scatter(cluster_D(:,1), cluster_D(:,2),7,'b','filled')
scatter(cluster_E(:,1), cluster_E(:,2),7,'g','filled')
plot_ellipse(mu_C(1), mu_C(2), theta_C, cont_Axes_C(2,2), cont_Axes_C(1,1))
plot_ellipse(mu_D(1), mu_D(2), theta_D, cont_Axes_D(2,2), cont_Axes_D(1,1))
plot_ellipse(mu_E(1), mu_E(2), theta_E, cont_Axes_E(2,2), cont_Axes_E(1,1))
xlabel('x_1');
ylabel('x_2');
title("MAP Decision Boundary Case 2");
hold off

% error analysis
% Cluster C is class ONE
distcd = MAP(cluster_C',N_c,N_d,mu_C,mu_D,sig_C,sig_D);
distde = MAP(cluster_C',N_d,N_e,mu_D,mu_E,sig_D,sig_E);
distec = MAP(cluster_C',N_e,N_c,mu_E,mu_C,sig_E,sig_C);
trueC = ones(N_c,1);
predC = 1*(distcd <= 0).*(distec >= 0);
predC_as_D =  1*(distde < 0).*(distcd > 0);
predC_as_E = 1*(distec < 0).*(distde > 0);
predC2 = predC  + 2*predC_as_D + 3*predC_as_E;

% Cluster D is class TWO
distcd = MAP(cluster_D',N_c,N_d,mu_C,mu_D,sig_C,sig_D);
distde = MAP(cluster_D',N_d,N_e,mu_D,mu_E,sig_D,sig_E);
distec = MAP(cluster_D',N_e,N_c,mu_E,mu_C,sig_E,sig_C);
trueD = 2*ones(N_d,1);
predD = 1*(distcd >= 0).*(distde <= 0);
predD_as_C = 1*(distcd < 0).*(distec > 0);
predD_as_E = 1*(distec < 0).*(distde > 0);
predD2 = 2*predD + predD_as_C + 3*predD_as_E;

% Cluster E is class THREE
distcd = MAP(cluster_E',N_c,N_d,mu_C,mu_D,sig_C,sig_D);
distde = MAP(cluster_E',N_d,N_e,mu_D,mu_E,sig_D,sig_E);
distec = MAP(cluster_E',N_e,N_c,mu_E,mu_C,sig_E,sig_C);
trueE = 3*ones(N_e,1);
predE = 1*(distec <= 0).*(distde >= 0);
predE_as_C = 1*(distcd < 0).*(distec > 0);
predE_as_D = 1*(distde < 0).*(distcd > 0);
predE2 = 3*predE + predE_as_C + 2*predE_as_D;

total_correct = sum(predC) + sum(predD) + sum(predE);
prediction_error = 1 - (total_correct / (N_c + N_d + N_e));
fprintf('MAP Case 2 Experimental Error Rate: %f percent\n',prediction_error)

% confusion matrix
C = confusionmat([trueC ;trueD ; trueE],[predC2 ; predD2; predE2],'Order',[1,2,3]);
figure
confusionchart(C,["C","D","E"])
title("Confusion Matrix MAP - Case 2")