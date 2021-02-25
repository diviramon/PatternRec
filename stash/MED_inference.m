close all

% CASE 1:

% Class A: 
N_a = 200;
mu_A = [5 10];
sig_A = [8 0; 0 4];

% Class B: 
N_b = 200;
mu_B = [10 15];
sig_B = [8 0; 0 4];

cluster_A = create_cluster(N_a, mu_A, sig_A);
cluster_B = create_cluster(N_b, mu_B, sig_B);
[theta_A, cont_Axes_A] = eigen_info(sig_A);
[theta_B, cont_Axes_B] = eigen_info(sig_B); 


figure
hold on
xlabel('x_1');
ylabel('x_2');

scatter(cluster_A(:,1), cluster_A(:,2))
scatter(cluster_B(:,1), cluster_B(:,2))
plot_ellipse(mu_A(1), mu_A(2), theta_A, cont_Axes_A(2,2), cont_Axes_A(1,1))
plot_ellipse(mu_B(1), mu_B(2), theta_B, cont_Axes_B(2,2), cont_Axes_B(1,1))

hold off

MED_Classifier(cluster_A, cluster_B, 0, mu_A, mu_B, 0, 2);
Error_Analysis(cluster_A, cluster_B, 0, mu_A, mu_B, 0, 2);

% CASE 2:

% Class C: 
N_c = 100;
mu_C = [5 10];
sig_C = [8 4; 4 40];

% Class D: 
N_d = 200;
mu_D = [15 10];
sig_D = [8 0; 0 8];

% Class E:
N_e = 150;
mu_E = [10 5];
sig_E = [10 -5; -5 20];

cluster_C = create_cluster(N_c, mu_C, sig_C);
cluster_D = create_cluster(N_d, mu_D, sig_D);
cluster_E = create_cluster(N_e, mu_E, sig_E);

[theta_C, cont_Axes_C] = eigen_info(sig_C);
[theta_D, cont_Axes_D] = eigen_info(sig_D); 
[theta_E, cont_Axes_E] = eigen_info(sig_E); 

figure
hold on
xlabel('x_1');
ylabel('x_2');

scatter(cluster_C(:,1), cluster_C(:,2))
scatter(cluster_D(:,1), cluster_D(:,2))
scatter(cluster_E(:,1), cluster_E(:,2))
plot_ellipse(mu_C(1), mu_C(2), theta_C, cont_Axes_C(2,2), cont_Axes_C(1,1))
plot_ellipse(mu_D(1), mu_D(2), theta_D, cont_Axes_D(2,2), cont_Axes_D(1,1))
plot_ellipse(mu_E(1), mu_E(2), theta_E, cont_Axes_E(2,2), cont_Axes_E(1,1))

hold off

MED_Classifier(cluster_C, cluster_D, cluster_E, mu_C, mu_D, mu_E, 3);
Error_Analysis(cluster_C, cluster_D, cluster_E, mu_C, mu_D, mu_E, 3);

