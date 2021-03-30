% Armaan Ladak
% SYDE 572 - Lab 2
%----------------------
% 1-D Case - Parametric
%----------------------

%% Setup
clc;
close all;
clear;

% Load data into workspace 
addpath('data');
load('lab2_1.mat')
x = linspace(0,10,1000);

% A Properties
N_A = length(a);
A_px = normpdf(x,5,1);

% B Properties
N_B = length(b);
B_px = exppdf(x,1);

%% Gaussian

% A Estimate
mu_A_est_G = (1/N_A)*sum(a);
sig_A_est_G = (1/N_A)*sum((a-mu_A_est_G).^2);
A_px_est_G = normpdf(x,mu_A_est_G,sig_A_est_G);
figure(1);
hold on
plot(x,A_px_est_G);
plot(x,A_px);
title('Parametric Gaussian Estimate of A');
xlabel('x');
ylabel('p(x)');
legend({'$\hat{p}(x)$','$p(x)$'},'interpreter','latex')
hold off

% B Estimate
mu_B_est_G = (1/N_B)*sum(b);
sig_B_est_G = (1/N_B)*sum((a-mu_B_est_G).^2);
B_px_est_G = normpdf(x,mu_B_est_G,sig_B_est_G);
figure(2);
hold on
plot(x,B_px_est_G);
plot(x,B_px);
title('Parametric Gaussian Estimate of B');
xlabel('x');
ylabel('p(x)');
legend({'$\hat{p}(x)$','$p(x)$'},'interpreter','latex');
hold off

%% Exponential

% A Estimate
mu_A_est_E = (1/N_A)*sum(a);
A_px_est_E = exppdf(x,mu_A_est_E);
figure(3);
hold on
plot(x,A_px_est_E);
plot(x,A_px);
title('Parametric Exponential Estimate of A');
xlabel('x');
ylabel('p(x)');
legend({'$\hat{p}(x)$','$p(x)$'},'interpreter','latex');
hold off

% B Estimate
mu_B_est_E = (1/N_B)*sum(b);
B_px_est_E = exppdf(x,mu_B_est_E);
figure(4);
hold on
plot(x,B_px_est_E);
plot(x,B_px);
title('Parametric Exponential Estimate of B');
xlabel('x');
ylabel('p(x)');
legend({'$\hat{p}(x)$','$p(x)$'},'interpreter','latex');
hold off

%% Uniform

% A Estimate
a_A_est_U = min(a);
b_A_est_U = max(b);
A_px_est_U = unifpdf(x,a_A_est_U,b_A_est_U);
figure(5);
hold on
plot(x,A_px_est_U);
plot(x,A_px);
title('Parametric Uniform Estimate of A');
xlabel('x');
ylabel('p(x)');
legend({'$\hat{p}(x)$','$p(x)$'},'interpreter','latex');
hold off

% B Estimate
a_B_est_U = min(b);
b_B_est_U = max(b);
B_px_est_U = unifpdf(x,a_B_est_U,b_B_est_U);
figure(6);
hold on
plot(x,B_px_est_U);
plot(x,B_px);
title('Parametric Uniform Estimate of B');
xlabel('x');
ylabel('p(x)');
legend({'$\hat{p}(x)$','$p(x)$'},'interpreter','latex');
hold off