% Armaan Ladak
% SYDE 572 - Lab 2
%----------------------
% 2-D Case - Parametric
%----------------------

%% Setup
clc;
close all;
clear;
STEP = 1;
LINE_WT = 2;

% Load data into workspace 
addpath('data');
load('lab2_2.mat')

%% Parametric
[x,y,ML_bdy] = create2DGrid(STEP,al,bl,cl);
x_range = [min(x) max(x)];
y_range = [min(y) max(y)];

% Training ML Classifier on al,bl,cl
for i = 1:size(x,2)
    for j = 1:size(y,2)
        ML_bdy(j,i) = classifyML(x(i),y(j),al,bl,cl);
    end
end

% Plotting Classifier Bdy against al,bl,cl
figure(1)
hold on
imagesc(x_range,y_range,ML_bdy);
set(gca,'ydir','normal');
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
colormap(cmap);
contour(x,y,ML_bdy,LINE_WT,'k')
plot(al(:,1), al(:,2), 'r.');
plot(bl(:,1), bl(:,2), 'b.');
plot(cl(:,1), cl(:,2), 'g.');
title('Parametric Estimation: ML Classifier on Trained Data');
xlabel('x_1');
ylabel('x_2');
legend('ML Bdy','A(L)','B(L)','C(L)');
hold off

% Plotting Classifier Bdy against at,bt,ct
% figure(2)
% hold on
% imagesc(x_range,y_range,ML_bdy);
% set(gca,'ydir','normal');
% cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1;];
% colormap(cmap);
% contour(x,y,ML_bdy,LINE_WT,'k')
% plot(at(:,1), at(:,2), 'r.');
% plot(bt(:,1), bt(:,2), 'b.');
% plot(ct(:,1), ct(:,2), 'g.');
% title('Parametric Estimation: ML Classifier on Untrained Data');
% xlabel('x_1');
% ylabel('x_2');
% legend('ML Bdy','A(T)','B(T)','C(T)');
% hold off