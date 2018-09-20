% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                      2.3 Autoregressive Modelling Part 5                %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

clear all; close all; clc;
randn('state',1);

% Reload the sunspot time series data
load('sunspot.dat');

% Standardise the data
ss = sunspot(:,2);
norm_ss=(ss-mean(ss))./std(ss);

% prediction horizons

order = [1 2 10];
m = [1 2 5 10];

clear figure;
figure(1) = figure('Color',[1 1 1]);
time = 1700:1987;   

for i = 1:length(m)
    subplot(2,2,i);
    plot(time,norm_ss,'linewidth',1);
    hold on
    
    for j = 1:length(order)
        [xhat, mse]=arpredict(norm_ss,order(j),m(i));
        MSE(j,i) = mse;
        disp(['MSE of AR(' num2str(order(j)) '): ' num2str(MSE(j,:))]);
        plot(time,xhat,'linewidth',1);
        hold on
    end
    
    legend1 = legend('Original','AR(1)','AR(2)','AR(10)','Location','NorthEastOutside');
    set(legend1,'FontSize',14,'Interpreter','latex');
    title(['\bf{m=' num2str(m(i)) '}'],'FontSize',20,'Interpreter','latex');
    
end

xlabel('\bf{Time [years]}','FontSize',20,'Interpreter','latex'); 
ylabel('\bf{Magnitude}','FontSize',20,'Interpreter','latex');

%% Zoomed in plots

clear figure;
figure(2) = figure('Color',[1 1 1]);
for i = 1:length(m)
    subplot(2,2,i);
    plot(time,norm_ss,'linewidth',1.5);
    hold on
    
    for j = 1:length(order)
        [xhat, mse]=arpredict(norm_ss,order(j),m(i));
        MSE(j,i) = mse;
        disp(['MSE of AR(' num2str(order(j)) '): ' num2str(MSE(j,:))]);
        plot(time,xhat,'linewidth',1.5);
        hold on
    end
    xlim([1750 1770])
    legend1 = legend('Original','AR(1)','AR(2)','AR(10)','Location','NorthEastOutside');
    set(legend1,'FontSize',14,'Interpreter','latex');
    title(['\bf{m=' num2str(m(i)) '}'],'FontSize',20,'Interpreter','latex');
    
end

xlabel('\bf{Time [years]}','FontSize',20,'Interpreter','latex'); 
ylabel('\bf{Magnitude}','FontSize',20,'Interpreter','latex');
