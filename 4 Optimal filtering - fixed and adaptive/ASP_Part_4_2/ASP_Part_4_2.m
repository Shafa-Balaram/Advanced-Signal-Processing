% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                   4.2 The least mean square (LMS) algorithm             %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;
randn('state',1);
x = randn(1000,1);
a = [1];
b = [1 2 3 2 1];
y = filter(b,a,x);
norm_y = (y);

% Additive noise
eta = 0.1.*randn(1000,1);
z = norm_y+eta;

% Time evolution of the weights
time = 1:1000;

% Adaptation gain
mu = 0.15;

% Order of the filter
Nw = 4;
order = Nw+1;

% LMS algorithm
[yhat, e, w ] = lms( x, z, mu, order );

clear figure;
figure(1) = figure('Color',[1 1 1]);
subplot(2,1,1);

plot(time,w(1,1:end-1),'linewidth',1);
hold on
plot(time,w(2,1:end-1),'linewidth',1);
hold on
plot(time,w(3,1:end-1),'linewidth',1);
hold on
plot(time,w(4,1:end-1),'linewidth',1);
hold on
plot(time,w(5,1:end-1),'linewidth',1);

xlabel('\bf{Iteration number}','FontSize',16,'Interpreter','latex')
ylabel('\bf{w$$_{opt}$$}','FontSize',17,'Interpreter','latex')
title('\bf{Evolution of adaptive weights with $$\mu=0.15$$}','FontSize',18,'Interpreter','latex')
legend1 = legend('$$w_0$$','$$w_1$$','$$w_2$$','$$w_3$$','$$w_4$$','Location','SouthEast');
set(legend1,'FontSize',14,'Interpreter','latex');

subplot(2,1,2);
sqerror = e.^2;
plot(time,10*log(sqerror),'linewidth',1);
xlabel('\bf{Iteration number}','FontSize',16,'Interpreter','latex')
ylabel('\bf{Squared error [dB]}','FontSize',16,'Interpreter','latex')
title('\bf{Learning curve for LMS algorithm with $$\mu=0.15$$}','FontSize',18,'Interpreter','latex')

%% Adaptive gain, mu = 0.002

close all; clear all; clc;
randn('state',1);

x = randn(1000,1);
a = [1];
b = [1 2 3 2 1];
y = filter(b,a,x);
norm_y = (y);

% Additive noise
eta = 0.1.*randn(1000,1);
z = norm_y+eta;

% Adaptation gain
mu = [0.002 0.01 0.35];

% Order of the filter
Nw = 4;
order = Nw+1;

clear figure;
figure(1) = figure('Color',[1 1 1]);

for i = 1:length(mu)
% LMS algorithm
[yhat, e, w ] = lms( x, z, mu(i), order );

subplot(2,3,i); grid on; hold on;
% Time evolution of the weights
time = 1:1000;
plot(time,w(1,1:end-1),'linewidth',1);
hold on
plot(time,w(2,1:end-1),'linewidth',1);
hold on
plot(time,w(3,1:end-1),'linewidth',1);
hold on
plot(time,w(4,1:end-1),'linewidth',1);
hold on
plot(time,w(5,1:end-1),'linewidth',1);

ylabel('\bf{Adaptive weights}','FontSize',20,'Interpreter','latex')
title(['\bf{$$\mu=' num2str(mu(i)) '$$}'],'FontSize',20,'Interpreter','latex')
legend1 = legend('$$w_0$$','$$w_1$$','$$w_2$$','$$w_3$$','$$w_4$$','Location','SouthEast');
set(legend1,'FontSize',12,'Interpreter','latex');

subplot(2,3,i+3); grid on; hold on;
sqerror = e.^2;
plot(time,10*log(sqerror),'linewidth',1);

ylabel('\bf{Squared error [dB]}','FontSize',20,'Interpreter','latex')

end

xlabel('\bf{Iteration number}','FontSize',20,'Interpreter','latex')


