% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                         Advanced Signal Processing                      %
%    4.6 Dealing with sign computational complexity: Sign Algorithms      %
%                                  March 2018                             %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%%  Adaptive LMS ALgorithm
close all; clear all; clc;
load('sound_a.mat');
x = sound_a;

order = 4;

mu = 0.05;

time = 1:1000;

clear figure;
figure(1) = figure('Color',[1 1 1]);

% Adaptive LMS algorithm 
[xhat, e, lmsw ] = ar_lms( x, mu, order);
subplot(2,4,1); grid on; hold on;
title('\bf{LMS}','FontSize',20,'Interpreter','latex');

for i = 1:order-1
    plot(time, lmsw(i,1:end-1), 'linewidth',1);
    hold on;
end


% Signed-error LMS algorithm 
[xhat, e, sigw ] = sign_lms( x, mu, order);
subplot(2,4,2); grid on; hold on;
title('\bf{ Sign LMS}','FontSize',20,'Interpreter','latex');
for i = 1:order-1
    plot(time, sigw(i,1:end-1), 'linewidth',1);
    hold on;
end

% Signed-regressor LMS algorithm 
[xhat, e, srw ] = signreg_lms( x, mu, order);
subplot(2,4,3); grid on; hold on;
title('\bf{Signed-regressor LMS}','FontSize',20,'Interpreter','latex');
for i = 1:order-1
    plot(time, srw(i,1:end-1), 'linewidth',1);
    hold on;
end

% Sign-sign LMS algorithm 
[xhat, e, ssw ] = signsign_lms( x, mu, order);

subplot(2,4,4); grid on; hold on;
title('\bf{Sign-sign LMS}','FontSize',20,'Interpreter','latex');

for i = 1:order-1
    plot(time, ssw(i,1:end-1), 'linewidth',1);
    hold on;
end

xlabel('\bf{Iteration number}','FontSize',20,'Interpreter','latex');
ylabel('\bf{Adaptive weights at $$\mu=0.05$$}','FontSize',20,'Interpreter','latex');

subplot(2,4,5); grid on; hold on;
plot(lmsw(1,:),lmsw(2,:))
title('\bf{LMS}','FontSize',20,'Interpreter','latex')

subplot(2,4,6); grid on; hold on;
plot(sigw(1,:),sigw(2,:))
title('\bf{Sign LMS}','FontSize',20,'Interpreter','latex')

subplot(2,4,7); grid on; hold on;
plot(srw(1,:),srw(2,:))
title('\bf{Signed-regressor LMS}','FontSize',20,'Interpreter','latex')

subplot(2,4,8); grid on; hold on;
plot(ssw(1,:),ssw(2,:))
title('\bf{Sign-sign LMS}','FontSize',20,'Interpreter','latex')


xlabel('\bf{w1}','FontSize',20,'Interpreter','latex')
ylabel('\bf{w2}','FontSize',20,'Interpreter','latex')
