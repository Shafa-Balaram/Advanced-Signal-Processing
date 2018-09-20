% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                               4.3 Gear Shifting                         %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

%% Method 1: Exponential Gear-Shifted LMS
close all; clear all; clc;

randn('state',3);
x = randn(1000,1);
a = [1];
b = [1, 2, 3, 2, 1];
y = filter(b,a,x);

% Additive noise
eta = 0.1.*randn(1000,1);
z = y+eta;

% Order of the filter
order = length(b); Nw = order-1;

mu_max = 0.105;
time = 1:1000;

% GSLMS algorithm
[ yhat,gs_err, gs_w, gs_mu ] = gslms( x, z, mu_max, order);

clear figure;
figure(1) = figure('Color',[1 1 1]);

subplot(1,3,1); grid on; hold on;
for j = 1:5
    plot(time,gs_w(j,1:end), 'Linewidth', 1);
    
    % Finding overshoot for each coefficient
    gs_ov(j) = abs( (b(j)-max(gs_w(j,:)))*100/b(j)) ;
    
    for n = 1:length(gs_w(j,:))
        if gs_w(j,n)>0.85*b(j) && gs_w(j,n)<0.95*b(j)
            gs_rt(j) = n;
            break;
            
        end
    end
    
end

ylabel('\bf{Adaptive weights}','FontSize',20,'Interpreter','latex')
title('\bf{Exponential GSLMS}','FontSize',20,'Interpreter','latex')
legend1 = legend('$$w_1$$','$$w_2$$','$$w_3$$','$$w_4$$','$$w_5$$','Location','SouthEast');
set(legend1,'FontSize',14,'Interpreter','latex');


% Method 2: Linear Gear-Shifted LMS

% GSLMS algorithm
[ yhat,lings_err, lings_w, lings_mu ] = gslms2( x, z, mu_max, order);


subplot(1,3,2); grid on; hold on;

for j = 1:5
    plot(time,lings_w(j,1:end), 'Linewidth', 1);
    
    % Finding overshoot for each coefficient
    lings_ov(j) = abs( (b(j)-max(lings_w(j,:)))*100/b(j)) ;
    
    for n = 1:length(gs_w(j,:))
        if lings_w(j,n)>0.85*b(j) && lings_w(j,n)<b(j)
            lings_rt(j) = n;
            break;
            
        end
    end
    
end


xlabel('\bf{Iteration number}','FontSize',20,'Interpreter','latex')
title('\bf{Linear GSLMS}','FontSize',20,'Interpreter','latex')
legend1 = legend('$$w_1$$','$$w_2$$','$$w_3$$','$$w_4$$','$$w_5$$','Location','SouthEast');
set(legend1,'FontSize',14,'Interpreter','latex');



subplot(1,3,3); grid on; hold on;
% Method 3: LMS algorithm
[ lms_yhat, lms_error, lms_w ] = lms( x, z, mu_max, order );

for j = 1:5
    plot(time,lms_w(j,1:end-1), 'Linewidth', 1);
    
    % Finding overshoot for each coefficient
    lms_ov(j) = abs( (b(j)-max(lms_w(j,1:end-1)))*100/b(j)) ;
    lms_rt(j) = max(risetime(lms_w(j,1:end-1)));
    
end

for j = 1:5
    for n = 1:length(lms_w(j,:))
        if lms_w(j,n)>0.85*b(j) && lms_w(j,n)<b(j)
            rt(j) = n;
            break;
            
        end
    end
end


title('\bf{LMS}','FontSize',20,'Interpreter','latex')
legend1 = legend('$$w_1$$','$$w_2$$','$$w_3$$','$$w_4$$','$$w_5$$','Location','SouthEast');
set(legend1,'FontSize',14,'Interpreter','latex');

clear figure;
figure(2) = figure('Color',[1 1 1]);
subplot(1,3,1); grid on; hold on;

plot(gs_w(1,:),gs_w(2,:))
ylim([0 2.5])
title('\bf{Exponential GSLMS}','FontSize',20,'Interpreter','latex')

subplot(1,3,2); grid on; hold on;
plot(lings_w(1,:),lings_w(2,:))
ylim([0 2.5])
title('\bf{Linear GSLMS}','FontSize',20,'Interpreter','latex')

subplot(1,3,3); grid on; hold on;
plot(lms_w(1,:),lms_w(2,:))
title('\bf{LMS}','FontSize',20,'Interpreter','latex')

xlabel('\bf{w1}','FontSize',20,'Interpreter','latex')
ylabel('\bf{w2}','FontSize',20,'Interpreter','latex')

clear figure;
figure(3) = figure('Color',[1 1 1]);
plot(10*log10(lms_error.^2));
hold on
plot(10*log10(gs_err.^2));
hold on
plot(10*log10(lings_err.^2));

title('\bf{Learning curves for the different LMS algorithm}','FontSize',20,'Interpreter','latex')
legend1 = legend('LMS','Exp GSLMS','Lin GSLMS','Location','SouthEast');
set(legend1,'FontSize',14,'Interpreter','latex');
xlabel('\bf{Iteration number}','FontSize',20,'Interpreter','latex')
ylabel('\bf{MSE [dB]}','FontSize',20,'Interpreter','latex')