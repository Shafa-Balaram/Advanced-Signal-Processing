% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%                          1.1 Statistical Estimation                     %
%                                 March 2018                              %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;

% Generate x  with sample length 1000 from a uniform distribution
x = rand(1000,1);
clear figure;
figure(1) = figure('Color',[1 1 1]);
plot(x);
xlabel('\bf{n}','FontSize',16,'Interpreter','latex')
ylabel('\bf{x[n]}','FontSize',16,'Interpreter','latex')
title('\bf{A 1000-sample vector x generated from a uniform random distribution}','FontSize',18,'Interpreter','latex')

% Part1: Sample mean 
sample_mean = mean(x);
% The theoretical mean
a = 0; b = 1;
theoretical_mean = (a+b)/2;

% Part 2: Sample standard deviation 
sample_std = std(x);
% The theoretical 
theoretical_std = sqrt((b-a)^2/12);

% Part 3: Bias of the estimators
% initialise the two estimators
m_estimator = [];
std_estimator = [];

% Compute the sample mean and std for 10 realisations
for i = 1:10
    x = rand(1000,1);
    m_estimator = [m_estimator ; mean(x)];
    std_estimator = [std_estimator ; std(x)];
end

% Plot the sample and theoretical means
clear figure;
figure(1) = figure('Color',[1 1 1]);
plot(m_estimator,'*')
hold on
actual_mean(1:10) = theoretical_mean;
plot(actual_mean,'linewidth',1.5);

legend1 = legend('theoretical mean','sample mean','Location','NorthWest');
set(legend1,'FontSize',14,'Interpreter','latex');

xlabel('\bf{realisation}','FontSize',16,'Interpreter','latex')
ylabel('\bf{sample mean value}','FontSize',16,'Interpreter','latex')
title('\bf{Variation of 10 sample means about the theoretical mean}','FontSize',18,'Interpreter','latex')

% Plot the sample and theoretical stds
clear figure;
figure(3) = figure('Color',[1 1 1]);

plot(std_estimator,'*')
hold on
actual_std(1:10) = theoretical_std;
plot(actual_std,'linewidth',1.5)

legend1 = legend('theoretical std','sample std','Location','NorthWest');
set(legend1,'FontSize',14,'Interpreter','latex');

xlabel('\bf{realisation}','FontSize',16,'Interpreter','latex')
ylabel('\bf{sample std value}','FontSize',16,'Interpreter','latex')
title('\bf{Variation of 10 sample stds about the theoretical std}','FontSize',18,'Interpreter','latex')

% Bias in the estimates
mean_bias = theoretical_mean - m_estimator;
std_bias = theoretical_std - std_estimator;

% Expected value and variability of the bias
exp_mean_bias = mean(mean_bias);
exp_std_bias = mean(std_bias);
var_mean_bias = var(mean_bias);
var_std_bias = var(std_bias);

%% Part 4: Estimating the pdf of x

% 1. Different sample lengths
N = [100 1000 10000];
n_bins = 20;
clear figure;
figure(4) = figure('Color',[1 1 1]);

for i = 1:length(N)
    subplot(3,1,i)
    x = rand(N(i),1);
    
    % The estimated pdf of X
    histogram(x,n_bins,'Normalization','probability')
    xlabel('\bf{x}','FontSize',16,'Interpreter','latex')
    ylabel('\bf{p(x)}','FontSize',16,'Interpreter','latex')
    title(['\bf{' num2str(N(i)) ' generated samples}'],'FontSize',18,'Interpreter','latex')
    hold on
    
    % The theoretical pdf
    X = 0:0.01:1;
    thpdf = ones(length(X));
    plot(X,thpdf,'r','linewidth',1.5)
    ylim([0 1.2])
    
    legend1 = legend('estimated','theoretical','Location','NorthEast');
    set(legend1,'FontSize',14,'Interpreter','latex');
end

% 2. Different number of histogram bins
N = 10000;
nbins = [1 20 50];
clear figure;
figure(5) = figure('Color',[1 1 1]);

for j = 1:length(nbins)
    subplot(3,1,j)
    x = rand(N,1);
    
    % The estimated pdf of X
    histogram(x,nbins(j),'Normalization','probability')
    xlabel('\bf{x}','FontSize',16,'Interpreter','latex')
    ylabel('\bf{p(x)}','FontSize',16,'Interpreter','latex')
    title([ '\bf{nbins = ' num2str(nbins(j)) '}'],'FontSize',18,'Interpreter','latex')
    hold on
    
    % The theoretical pdf 
    X = 0:0.01:1;
    thpdf = ones(length(X));
    plot(X,thpdf,'r','linewidth',1.5)
    ylim([0 1.2])
    legend1 = legend('estimated','theoretical','Location','NorthEast');
    set(legend1,'FontSize',14,'Interpreter','latex');
        
end

%% 1.5 Statistical Estimation - Gaussian Distribution
close all; clear all;

% Generate x  with sample length 1000 from a uniform distribution
x = randn(1000,1);
figure(6);
plot(x);
xlabel('n')
ylabel('x[n]')
title('A 1000-sample vector x generated from a zero mean, unit std Gaussian distribution')

% Theoretical pdf of X
X = min(x):0.01:max(x);
theoretical_pdf = normpdf(X,0,1);
figure(7)
plot(X,theoretical_pdf,'linewidth',1.5)
xlabel('\bf{X}','FontSize',16,'Interpreter','latex')
ylabel('\bf{p(X)}','FontSize',16,'Interpreter','latex')
title('\bf{Theoretical pdf of X}','FontSize',18,'Interpreter','latex')

% Part 1: Sample mean
sample_mean = mean(x);
theoretical_mean = 0;

% Part 2: The standard deviation 
sample_std = std(x);
theoretical_std = 1;

% Part 3: Bias of the estimators
% initialise a vector for the two estimators
m_estimator = [];
std_estimator = [];

% Compute the sample mean and std for 10 realisations
for i = 1:10
    x = randn(1000,1);
    m_estimator = [m_estimator ; mean(x)];
    std_estimator = [std_estimator ; std(x)];
end

% Plot the sample and theoretical means
figure(8)
plot(m_estimator,'*')
hold on
actual_mean(1:10) = theoretical_mean;
plot(actual_mean,'linewidth',1.5)
legend('sample mean','theoretical mean')
xlabel('realisation')
ylabel('mean value')
title('Variation of 10 sample means about the theoretical mean')

% Plot the sample and theoretical stds
figure(9)
plot(std_estimator,'*')
hold on
actual_std(1:10) = theoretical_std;
plot(actual_std,'linewidth',1.5)
legend('sample std','theoretical std')
xlabel('realisation')
ylabel('std value')
title('Variation of 10 sample stds about the theoretical std')

% Bias in the estimates
mean_bias = theoretical_mean - m_estimator;
std_bias = theoretical_std - std_estimator;

% Expected value and variability of the bias
exp_mean_bias = mean(mean_bias);
exp_std_bias = mean(std_bias);
var_mean_bias = var(mean_bias);
var_std_bias = var(std_bias);

% 1. Different sample lengths
N = [100 1000 10000];
n_bins = 20;
figure(10)

for i = 1:length(N)
    subplot(3,1,i)
    x = randn(N(i),1);
    
    % The estimated pdf of X
    histogram(x,n_bins,'Normalization','probability')
    xlabel('\bf{x}','FontSize',16,'Interpreter','latex')
    ylabel('\bf{p(x)}','FontSize',16,'Interpreter','latex')
    title([ '\bf{' num2str(N(i)) ' generated samples}'],'FontSize',18,'Interpreter','latex')
    hold on
    
    % The theoretical pdf
    plot(X,theoretical_pdf,'r','linewidth',1.5)
    legend1 = legend('estimated','theoretical','Location','NorthEast');
    set(legend1,'FontSize',14,'Interpreter','latex');
        
end

% 2. Different number of histogram bins
N = 10000;
nbins = [1 20 50];
figure(11)

for j = 1:length(nbins)
    subplot(3,1,j)
    x = randn(N,1);
    
    % The estimated pdf of X
    histogram(x,nbins(j),'Normalization','probability')
    xlabel('\bf{x}','FontSize',16,'Interpreter','latex')
    ylabel('\bf{p(x)}','FontSize',16,'Interpreter','latex')
    title([ '\bf{nbins = ' num2str(nbins(j)) '}'],'FontSize',18,'Interpreter','latex')
    hold on
    
    % The theoretical pdf 
    plot(X,theoretical_pdf,'r','linewidth',1.5)
    legend1 = legend('estimated','theoretical','Location','NorthEast');
    set(legend1,'FontSize',14,'Interpreter','latex');
end

