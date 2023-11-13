% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                           Advanced Signal Processing                    %
%               2.5 Real World Signals: ECG from iAmp experiment          %
%                                  March 2018                             %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;

% Heart rate probability density estimate (PDE)
load('rr1.mat'); load('rr2.mat'); load('rr3.mat')
% Heartrate
h = 60./rr1;

% Averaged heartrate
alpha = [1 0.6];
hhat1 = []; hhat2 = [];
for i = 1:10:length(rr1)-10
    hhat1 = [hhat1 sum(alpha(1).*h(i:i+9))/10];
    hhat2 = [hhat2 sum(alpha(2).*h(i:i+9))/10];
end

% Probability density estimates of original heart rate
clear figure;
figure(1) = figure('Color',[1 1 1]);
n_bins = 50;
pde = histogram(h,n_bins,'Normalization','probability');
pde.FaceColor = [0.1 0.1 0.1];
xlabel('\bf{h}','FontSize',16,'Interpreter','latex');
ylabel('\bf{p(h)}','FontSize',16,'Interpreter','latex');
title('\bf{PDE of the original heart rate}','FontSize',18,'Interpreter','latex');

% Probability density estimates of the averaged heart rates
clear figure;
figure(2) = figure('Color',[1 1 1]);
subplot(2,1,1); 
pde1 = histogram(hhat1,n_bins,'Normalization','probability');
pde1.FaceColor = [0.1 0.1 0.1];
xlabel('\bf{h}','FontSize',16,'Interpreter','latex');
ylabel('\bf{p(h)}','FontSize',16,'Interpreter','latex');
title('$$\bf{PDE\ of\ averaged\ heart\ rate\ for\ \alpha=1}$$','FontSize',18,'Interpreter','latex');

subplot(2,1,2);
pde2 = histogram(hhat2,n_bins,'Normalization','probability');
pde2.FaceColor = [0.1 0.1 0.1];
xlabel('\bf{h}','FontSize',18,'Interpreter','latex');
ylabel('\bf{p(h)}','FontSize',18,'Interpreter','latex');
title('$$\bf{PDE\ of\ averaged\ heart\ rate\ for\ \alpha=0.6}$$','FontSize',18,'Interpreter','latex');

%% AR modelling of heart rate

rr1 = detrend(rr1);
[acf_rr1,tau1] = xcorr(rr1,'unbiased');

rr2 = detrend(rr2);
[acf_rr2,tau2] = xcorr(rr2,'unbiased');

rr3 = detrend(rr3);
[acf_rr3,tau3] = xcorr(rr3,'unbiased');
  
clear figure;
figure(1) = figure('Color',[1 1 1]);
subplot(3,1,1); plot(tau1,acf_rr1,'k'); 
title('\bf{ACF of trial 1}','FontSize',18,'Interpreter','latex');

subplot(3,1,2); plot(tau2,acf_rr2,'k');
ylabel('\bf{ACF}','FontSize',20,'Interpreter','latex');
title('\bf{ACF of trial 2}','FontSize',18,'Interpreter','latex');

subplot(3,1,3); plot(tau3,acf_rr3,'k');
xlabel('\bf{Correlation lag}','FontSize',20,'Interpreter','latex');
title('\bf{ACF of trial 3}','FontSize',18,'Interpreter','latex');

%% Modelling the heart rate as an AR process
% Partial ACF 

clear figure;
figure(2) = figure('Color',[1 1 1]);

subplot(1,3,1); grid on; hold on;
[pacf_rr1,lags,bounds] = parcorr(rr1,10);
pacf_rr1 = -pacf_rr1(2:end);
order = 1:10;

stem(pacf_rr1,'k','filled'); hold on;
upperbound(1:11) = bounds(1); lowerbound(1:11) = bounds(2);
plot(0:10,upperbound,'r--','linewidth',1); hold on;
plot(0:10,lowerbound,'r--','linewidth',1);
ylabel('\bf{PACF}','FontSize',20,'Interpreter','latex')
title('\bf{Trial 2}','FontSize',18,'Interpreter','latex')

subplot(1,3,2); grid on; hold on;
[pacf_rr2,lags,bounds] = parcorr(rr2,10);
pacf_rr2 = -pacf_rr2(2:end);
order = 1:10;

stem(pacf_rr2,'k','filled'); hold on;
upperbound(1:11) = bounds(1); lowerbound(1:11) = bounds(2);
plot(0:10,upperbound,'r--','linewidth',1); hold on;
plot(0:10,lowerbound,'r--','linewidth',1);
xlabel('\bf{Correlation lag}','FontSize',20,'Interpreter','latex')
title('\bf{Trial 2}','FontSize',18,'Interpreter','latex')

subplot(1,3,3); grid on; hold on;
[pacf_rr3,lags,bounds] = parcorr(rr3,10);
pacf_rr3 = -pacf_rr3(2:end);
order = 1:10;

stem(pacf_rr3,'k','filled'); hold on;
upperbound(1:11) = bounds(1); lowerbound(1:11) = bounds(2);
plot(0:10,upperbound,'r--','linewidth',1); hold on;
plot(0:10,lowerbound,'r--','linewidth',1);
title('\bf{Trial 3}','FontSize',18,'Interpreter','latex')

%% Trial 1
randn('state',1)
% Normalised rr1
norm_rr1 = (rr1-mean(rr1))/std(rr1);
norm_rr1 = norm_rr1';

% WGN realisation for the predicted AR process
w = randn(length(norm_rr1),1);

for p = 1:10
    [norm_a2,e] = aryule(norm_rr1,p);

    % The predicted AR process
    x = filter(1,-norm_a2(2:end),w);
    
    % squared error between model and actual data
    se = (norm_rr1-x).^2;
    
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_rr1);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
   
clear figure;
figure(3) = figure('Color',[1 1 1]);
subplot(1,3,1); 

order = 1:10;

plot(order,MDL,'-s','linewidth',1.5)
hold on
plot(order,AIC,'k-*','linewidth',1.5)
hold on
plot(order,AICc,'k-o','linewidth',1.5)
hold on
plot(order,log(E),'r-d','linewidth',1.5)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthEast');
set(legend1,'FontSize',12,'Interpreter','latex');

xlabel('\bf{Model order p}','FontSize',16,'Interpreter','latex')
ylabel('\bf{Prediction error}','FontSize',16,'Interpreter','latex')
title('\bf{Trial 1}','FontSize',18,'Interpreter','latex')

% Trial 2

% Normalised rr2
norm_rr2 = (rr2-mean(rr2))./std(rr2);
norm_rr2 = norm_rr2';

% WGN realisation for the predicted AR process
w = randn(length(norm_rr2),1);

for p = 1:10
    [norm_a2,e] = aryule(norm_rr2,p);

    % The predicted AR process
    a1 = -norm_a2(2:end);
    x = filter(1,a1,w);
    
    % squared error between model and actual data
    se = (norm_rr2-x).^2;
    
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_rr2);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
    
subplot(1,3,2); 
plot(order,MDL,'-s','linewidth',1.5)
hold on
plot(order,AIC,'k-*','linewidth',1.5)
hold on
plot(order,AICc,'k-o','linewidth',1.5)
hold on
plot(order,log(E),'r-d','linewidth',1.5)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthEast');
set(legend1,'FontSize',12,'Interpreter','latex');
title('\bf{Trial 2}','FontSize',18,'Interpreter','latex')


% Trial 3
% Normalised rr1
norm_rr3 = (rr3-mean(rr3))./std(rr3);
norm_rr3 = norm_rr3';

% WGN realisation for the predicted AR process
w = randn(length(norm_rr3),1);

for p = 1:10
    [norm_a3,e] = aryule(norm_rr3,p);

    % The predicted AR process
    a1 = -norm_a3(2:end);
    x = filter(1,a1,w);
    
    % squared error between model and actual data
    se = (norm_rr3-x).^2;
    
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_rr3);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
    
order = 1:10;
subplot(1,3,3); 

plot(order,MDL,'-s','linewidth',1.5)
hold on
plot(order,AIC,'k-*','linewidth',1.5)
hold on
plot(order,AICc,'k-o','linewidth',1.5)
hold on
plot(order,log(E),'r-d','linewidth',1.5)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthEast');
set(legend1,'FontSize',12,'Interpreter','latex');
title('\bf{Trial 3}','FontSize',18,'Interpreter','latex')
