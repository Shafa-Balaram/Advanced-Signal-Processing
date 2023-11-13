% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%                          4.4  Adaptive LMS ALgorithm                    %
%                                  March 2018                             %                      
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

clear all; clc; close all;

% AR(2) process
randn('state',1)
a = [1 0.9 0.2];
x = filter(1, a, randn(10000,1));

% Adaptive LMS algorithm 
order = length(a);

mu = [0.01 0.03 0.05 0.06];
time = 1:10000;

a1(1:10000) = -0.2; a2(1:10000) = -0.9;

clear figure;
figure(1) = figure('Color',[1 1 1]);
    
for i = 1:4
    
    subplot(2,2,i); grid on; hold on;
    [ xhat, e, w ] = adapt_lms( x, mu(i));
    plot(time,w(1,:),'linewidth',1);
    hold on
    plot(time,w(2,:),'linewidth',1);
    hold on
    plot(time,a1,'k--','linewidth',1)
    hold on
    plot(time,a2,'k--','linewidth',1)
    
    xlabel('n','FontSize',16,'Interpreter','latex')
    ylabel('Weights','FontSize',18,'Interpreter','latex')
    title(['\bf{$$\mu$$ = ' num2str(mu(i)) '}'],'FontSize',18,'Interpreter','latex')
    legend1 = legend('$$a_1$$','$$a_2$$','Location','South');
    set(legend1,'FontSize',14,'Interpreter','latex');
    
end
