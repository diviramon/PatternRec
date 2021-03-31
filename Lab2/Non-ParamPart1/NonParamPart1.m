cluster_A = a;
cluster_B = b;

mu = 5;
sd = 1;
lambda = 1;

L_a = length(cluster_A);
L_b = length(cluster_B);

x_a_min = floor(min(min(cluster_A(1,:))));
x_a_max = ceil(max(max(cluster_A(1,:))));
x_b_min = floor(min(min(cluster_B(1,:))));
x_b_max = ceil(max(max(cluster_B(1,:))));

x_a_range = [x_a_min x_a_max];
x_b_range = [x_b_min  x_b_max];

step = 0.01;
[xa] = (x_a_range(1):step:x_a_range(2));
[xb] = (x_b_range(1):step:x_b_range(2));


normal_pdf = normpdf(xa,mu,sd);
exponetial_pdf = exppdf(xb, 1/lambda); 

parzen_a1 = parzen_p1(xa,0.1,cluster_A,L_a);
parzen_a2 = parzen_p1(xa,0.4,cluster_A,L_a);

parzen_b1 = parzen_p1(xb,0.1,cluster_B,L_b);
parzen_b2 = parzen_p1(xb,0.4,cluster_B,L_b);


figure(1); %0.1 STD FOR CASE A
hold on;
scatter(cluster_A ,zeros(size(cluster_A)),'DisplayName','Data');
plot(xa,normal_pdf,'DisplayName','True p(x)');
plot(xa,parzen_a1,'DisplayName','Parzen Method with SD = 0.1');
plot(xa,parzen_a2,'DisplayName','Parzen Method with SD = 0.4');
xlabel('x');
ylabel('p(x)');
title("Non-Parametirc Parzen Dataset A");
hold off;

lgd = legend;
lgd.NumColumns = 1;

figure(2); 
hold on;
scatter(cluster_B ,zeros(size(cluster_B)),'DisplayName','Data');
plot(xb,exponetial_pdf,'DisplayName','True p(x)');
plot(xb,parzen_b1,'DisplayName','Parzen Method with SD = 0.1');
plot(xb,parzen_b2,'DisplayName','Parzen Method with SD = 0.4');
xlabel('x');
ylabel('p(x)');
title("Non-Parametirc Parzen Dataset B");
hold off;

lgd = legend;
lgd.NumColumns = 1;


