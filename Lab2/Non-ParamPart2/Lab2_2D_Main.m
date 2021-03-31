cluster_A_l = al;
cluster_B_l = bl;
cluster_C_l = cl;

cluster_A_t = at;
cluster_B_t = bt;
cluster_C_t = ct;

variance = 400;
m = [variance/2 variance/2];
covaraince = [variance 0; 0 variance];
step  = 0.5;

min_x = floor(min([min(cluster_A_l(:,1)) min(cluster_B_l(:,1)) min(cluster_C_l(:,1))]));
max_x = ceil(max([max(cluster_A_l(:,1)) max(cluster_B_l(:,1)) max(cluster_C_l(:,1))]));
min_y = floor(min([min(cluster_A_l(:,2)) min(cluster_B_l(:,2)) min(cluster_C_l(:,2))]));
max_y = ceil(max([max(cluster_A_l(:,2)) max(cluster_B_l(:,2)) max(cluster_C_l(:,2))]));
x_range = [min_x max_x];
y_range = [min_y max_y];

[X,Y] = meshgrid(x_range, y_range);
[x1,x2] = meshgrid(1:step:variance);


win = reshape(mvnpdf([x1(:) x2(:)], m, covaraince),length(x2),length(x1));
res = [step min_x min_y max_x  max_y];

[pa, x_range, y_range] = parzen(cluster_A_l,res, win);
[pb, x_range, y_range] = parzen(cluster_B_l,res, win);
[pc, x_range, y_range] = parzen(cluster_C_l,res, win);
[pat, x_range, y_range] = parzen(cluster_A_t,res, win);
[pbt, x_range, y_range] = parzen(cluster_B_t,res, win);
[pct, x_range, y_range] = parzen(cluster_C_t,res, win);

[x,y] = meshgrid(x_range, y_range);

ML_l = zeros(size(x));
ML_t = zeros(size(x));
for i = 1:size(x,1)
   for j = 1:size(y,2)
       [a, b] = max([pa(i,j), pb(i,j), pc(i,j)]);
       ML_l(i,j) = b;
       [c, d] = max([pat(i,j), pbt(i,j), pct(i,j)]);
       ML_t(i,j) = d;
   end
end


figure(1);
hold on;
imagesc(x_range,y_range,ML_l);
set(gca,'ydir','normal');
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
colormap(cmap);
contour(x,y,ML_l,'k','DisplayName', 'ML Bdy');
scatter(cluster_A_l(:,1), cluster_A_l(:,2),7,'r','filled', 'DisplayName', 'a(l)')
scatter(cluster_B_l(:,1), cluster_B_l(:,2),7,'g','filled', 'DisplayName', 'b(l)')
scatter(cluster_C_l(:,1), cluster_C_l(:,2),7,'b','filled', 'DisplayName', 'c(l)')
xlabel('x_1');
ylabel('x_2');
title("2-D Parzen Estimation on Training Data");
hold off;

lgd = legend;
lgd.NumColumns = 1;

figure(2);
hold on;
imagesc(x_range,y_range,ML_t);
set(gca,'ydir','normal');
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
colormap(cmap);
contour(x,y,ML_t,'k','DisplayName', 'ML Bdy');
scatter(cluster_A_t(:,1), cluster_A_t(:,2),7,'r','filled', 'DisplayName', 'a(t)')
scatter(cluster_B_t(:,1), cluster_B_t(:,2),7,'g','filled', 'DisplayName', 'b(t)')
scatter(cluster_C_t(:,1), cluster_C_t(:,2),7,'b','filled', 'DisplayName', 'c(t)')
xlabel('x_1');
ylabel('x_2');
title("2-D Parzen Estimation on Testing Data");
hold off;


lgd = legend;
lgd.NumColumns = 1;


