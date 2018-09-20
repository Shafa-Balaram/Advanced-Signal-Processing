% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                             1.2 Stochastic Process                      %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;

% Part 1: Ensemble mean and std
M = 100;
N = 100;

process1 = rp1(M,N);
ensemble_mean1 = mean(process1,1);
ensemble_std1 = std(process1,1,1);

process2 = rp2(M,N);
ensemble_mean2 = mean(process2,1);
ensemble_std2 = std(process2,1,1);

process3 = rp3(M,N);
ensemble_mean3 = mean(process3,1);
ensemble_std3 = std(process3,1,1);

clear figure;
figure(1) = figure('Color',[1 1 1]); grid on; hold on; 

subplot(2,1,1); plot(ensemble_mean1,'linewidth',2);
xlabel('bf{Discrete Time}','FontSize',16,'Interpreter','latex'); 
title('\bf{Ensemble mean values of stochastic process 1}','FontSize',18,'Interpreter','latex')

subplot(2,1,2); plot(ensemble_std1,'linewidth',2);
xlabel('\bf{Discrete Time}','FontSize',16,'Interpreter','latex'); 
title('\bf{Ensemble standard deviation values of stochastic process 1}','FontSize',18,'Interpreter','latex')

clear figure;
figure(2) = figure('Color',[1 1 1]); grid on; hold on; 

subplot(2,1,1); plot(ensemble_mean2,'linewidth',2);
xlabel('\bf{Discrete Time}','FontSize',16,'Interpreter','latex');  
title('\bf{Ensemble mean values of stochastic process 2}','FontSize',18,'Interpreter','latex')

subplot(2,1,2); plot(ensemble_std2,'linewidth',2);
xlabel('\bf{Discrete Time}','FontSize',16,'Interpreter','latex'); 
title('\bf{Ensemble standard deviation values of stochastic process 2}','FontSize',18,'Interpreter','latex')

clear figure;
figure(3) = figure('Color',[1 1 1]); grid on; hold on; 

subplot(2,1,1); plot(ensemble_mean3,'linewidth',2);
xlabel('\bf{Discrete Time}','FontSize',16,'Interpreter','latex');  
title('\bf{Ensemble mean values of stochastic process 3}','FontSize',18,'Interpreter','latex')
subplot(2,1,2); plot(ensemble_std3,'linewidth',2);
xlabel('\bf{Discrete Time}','FontSize',16,'Interpreter','latex'); 
title('\bf{Ensemble standard deviation values of stochastic process 3}','FontSize',18,'Interpreter','latex')

%% Part 2: Time average mean and standard deviation
clear all;

M = 4;
N = 1000;

process1 = rp1(M,N);
timeav_mean1 = mean(process1,2);
timeav_std1 = std(process1,1,2);

process2 = rp2(M,N);
timeav_mean2 = mean(process2,2);
timeav_std2 = std(process2,1,2);

process3 = rp3(M,N);
timeav_mean3 = mean(process3,2);
timeav_std3 = std(process3,1,2);

clear figure;
figure(4) = figure('Color',[1 1 1]); grid on; hold on; 
subplot(2,1,1); plot(timeav_mean1,'k*');
xlabel('\bf{Realisation}','FontSize',16,'Interpreter','latex'); 
title('\bf{Time average mean values of stochastic process 1}','FontSize',18,'Interpreter','latex')

subplot(2,1,2); plot(timeav_std1,'k*');
xlabel('\bf{Realisation}','FontSize',16,'Interpreter','latex'); 
title('\bf{Time average standard deviation values of stochastic process 1}','FontSize',18,'Interpreter','latex')


clear figure;
figure(5) = figure('Color',[1 1 1]); grid on; hold on; 
subplot(2,1,1); plot(timeav_mean2,'k*');
xlabel('\bf{Realisation}','FontSize',16,'Interpreter','latex'); 
title('\bf{Ensemble mean values of stochastic process 2}','FontSize',18,'Interpreter','latex')
subplot(2,1,2); plot(timeav_std2,'k*');
xlabel('\bf{Realisation}','FontSize',16,'Interpreter','latex'); 
title('\bf{Time average standard deviation values of stochastic process 2}','FontSize',18,'Interpreter','latex')

clear figure;
figure(6) = figure('Color',[1 1 1]); grid on; hold on; 
subplot(2,1,1); plot(timeav_mean3,'k*');
xlabel('\bf{Realisation}','FontSize',16,'Interpreter','latex'); 
title('\bf{Time average values of stochastic process 3}','FontSize',18,'Interpreter','latex')
subplot(2,1,2); plot(timeav_std3,'k*');
xlabel('\bf{Realisation}','FontSize',16,'Interpreter','latex'); 
title('\bf{Time average standard deviation values of stochastic process 3}','FontSize',18,'Interpreter','latex')

% To check for ergodicity in mean
exp_timeav_mean1 = mean(timeav_mean1);
var_timeav_mean1 = var(timeav_mean1);

exp_timeav_mean2 = mean(timeav_mean2);
var_timeav_mean2 = var(timeav_mean2);

exp_timeav_mean3 = mean(timeav_mean3);
var_timeav_mean3 = var(timeav_mean3);

% To check for ergodicity in std
exp_timeav_std1 = mean(timeav_std1);
var_timeav_std1 = var(timeav_std1);

exp_timeav_std2 = mean(timeav_std2);
var_timeav_std2 = var(timeav_std2);

exp_timeav_std3 = mean(timeav_std3);
var_timeav_std3 = var(timeav_std3);

