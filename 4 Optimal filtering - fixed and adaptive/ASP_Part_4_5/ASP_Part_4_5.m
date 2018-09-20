% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                             4.5 Speech Recognition                      %
%                         Original version - March 2018                   %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%%              LMS ALgorithm applied to voice recordings                %%
close all; clear all; close all;

load('sound_a.mat');
load('sound_e.mat');
load('sound_s.mat');
load('sound_t.mat');
load('sound_x.mat');

% Preliminary test for optimal model order using PACF
clear figure;
figure(1) = figure('Color',[1 1 1]);
subplot(5,1,1); parcorr(sound_a); 
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of a}','FontSize',12,'Interpreter','latex');

subplot(5,1,2); parcorr(sound_e); 
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of e}','FontSize',12,'Interpreter','latex');

subplot(5,1,3); parcorr(sound_s); 
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of s}','FontSize',12,'Interpreter','latex');

subplot(5,1,4); parcorr(sound_t); 
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of t}','FontSize',12,'Interpreter','latex');

subplot(5,1,5); parcorr(sound_x); 
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of x}','FontSize',12,'Interpreter','latex');

%%   Using the different criteria to predict the optimal model orders    %%
norm_a=(sound_a-mean(sound_a))./std(sound_a);

% Using the same WGN for every simulation 
randn('state',2);

% WGN realisation for the predicted AR process
w = randn(length(norm_a)+19,1);
w = [norm_a(1); w];


for p = 1:10
    [weight_a,e] = aryule(norm_a,p);
    
    % The predicted AR process
    armodel = filter(1,weight_a,w); 
    armodel = armodel(21:end);
    armodel = (armodel-mean(armodel))./std(armodel);
    AR(p,:) = armodel;
    
    % The unbiased ACF estimate for each model order
    acf_norm = xcorr(armodel,'unbiased');
    
    % squared error between model and actual data
    se = (norm_a-armodel).^2;
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_a);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
    
clear figure;
figure(1) = figure('Color',[1 1 1]);
subplot(2,3,1); 
order = 1:10;
plot(order,MDL,'-s','linewidth',1)
hold on
plot(order,AIC,'k-*','linewidth',1)
hold on
plot(order,AICc,'k-o','linewidth',1)
hold on
plot(order,log(E),'r-d','linewidth',1)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthWest');
set(legend1,'FontSize',11,'Interpreter','latex');
xlabel('Model order','FontSize',12,'Interpreter','latex')
ylabel('Prediction error','FontSize',12,'Interpreter','latex')
title('\textbf{Optimal model order for a}','FontSize',12,'Interpreter','latex')

%% Letter 'e'
norm_e=(sound_e-mean(sound_e))./std(sound_e);

% Using the same WGN for every simulation 
randn('state',3);
% state 4 for min 2 and state 3 for min 8

% WGN realisation for the predicted AR process
w = randn(length(norm_e)+19,1);
w = [norm_e(1); w];


for p = 1:10
    [weight_e,e] = aryule(norm_e,p);
    
    % The predicted AR process
    emodel = filter(1,weight_e,w); 
    emodel = emodel(21:end);
    emodel = (emodel-mean(emodel))./std(emodel);
    AR(p,:) = emodel;
    
    % The unbiased ACF estimate for each model order
    acf_norm = xcorr(emodel,'unbiased');
    
    % squared error between model and actual data
    se = (norm_e-emodel).^2;
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_e);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
    
subplot(2,3,2); 

order = 1:10;
plot(order,MDL,'-s','linewidth',1)
hold on
plot(order,AIC,'k-*','linewidth',1)
hold on
plot(order,AICc,'k-o','linewidth',1)
hold on
plot(order,log(E),'r-d','linewidth',1)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthWest');
set(legend1,'FontSize',11,'Interpreter','latex');
xlabel('Model order','FontSize',12,'Interpreter','latex')
ylabel('Prediction error','FontSize',12,'Interpreter','latex')
title('\textbf{Optimal model order for e}','FontSize',12,'Interpreter','latex')

%% Letter 's'
norm_s=(sound_s-mean(sound_s))./std(sound_s);

% Using the same WGN for every simulation 
randn('state',3);
% state 1 for min 2 and state 2 for min 1

% WGN realisation for the predicted AR process
w = randn(length(norm_s)+19,1);
w = [norm_s(1); w];


for p = 1:10
    [weight_s,e] = aryule(norm_s,p);
    
    % The predicted AR process
    smodel = filter(1,weight_s,w); 
    smodel = smodel(21:end);
    smodel = (smodel-mean(smodel))./std(smodel);
    AR(p,:) = smodel;
    
    % The unbiased ACF estimate for each model order
    acf_norm = xcorr(smodel,'unbiased');
    
    % squared error between model and actual data
    se = (norm_s-smodel).^2;
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_s);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
    
%subplot(2,3,3); 

order = 1:10;
plot(order,MDL,'-s','linewidth',1)
hold on
plot(order,AIC,'k-*','linewidth',1)
hold on
plot(order,AICc,'k-o','linewidth',1)
hold on
plot(order,log(E),'r-d','linewidth',1)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthWest');
set(legend1,'FontSize',11,'Interpreter','latex');
xlabel('Model order','FontSize',12,'Interpreter','latex')
ylabel('Prediction error','FontSize',12,'Interpreter','latex')
title('\textbf{Optimal model order for s}','FontSize',12,'Interpreter','latex')

%% Letter 't'
norm_t=(sound_t-mean(sound_t))./std(sound_t);

% Using the same WGN for every simulation 
randn('state',3);
% state 3 for min 2 

% WGN realisation for the predicted AR process
w = randn(length(norm_t)+19,1);
w = [norm_t(1); w];


for p = 1:10
    [weight_t,e] = aryule(norm_t,p);
    
    % The predicted AR process
    tmodel = filter(1,weight_t,w); 
    tmodel = tmodel(21:end);
    tmodel = (tmodel-mean(tmodel))./std(tmodel);
    AR(p,:) = tmodel;
    
    % The unbiased ACF estimate for each model order
    acf_norm = xcorr(tmodel,'unbiased');
    
    % squared error between model and actual data
    se = (norm_t-tmodel).^2;
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_t);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
    
subplot(2,3,4); 

order = 1:10;
plot(order,MDL,'-s','linewidth',1)
hold on
plot(order,AIC,'k-*','linewidth',1)
hold on
plot(order,AICc,'k-o','linewidth',1)
hold on
plot(order,log(E),'r-d','linewidth',1)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthWest');
set(legend1,'FontSize',11,'Interpreter','latex');
xlabel('Model order','FontSize',12,'Interpreter','latex')
ylabel('Prediction error','FontSize',12,'Interpreter','latex')
title('\textbf{Optimal model order for t}','FontSize',12,'Interpreter','latex')

%% Letter 'x'
norm_x=(sound_x-mean(sound_x))./std(sound_x);

% Using the same WGN for every simulation 
randn('state',2);
% state 2 for min 2

% WGN realisation for the predicted AR process
w = randn(length(norm_x)+19,1);
w = [norm_x(1); w];


for p = 1:10
    [weight_x,e] = aryule(norm_x,p);
    
    % The predicted AR process
    xmodel = filter(1,weight_x,w); 
    xmodel = xmodel(21:end);
    xmodel = (xmodel-mean(xmodel))./std(xmodel);
    AR(p,:) = xmodel;
    
    % The unbiased ACF estimate for each model order
    acf_norm = xcorr(xmodel,'unbiased');
    
    % squared error between model and actual data
    se = (norm_x-xmodel).^2;
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_x);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
    
subplot(2,3,5); 

order = 1:10;
plot(order,MDL,'-s','linewidth',1)
hold on
plot(order,AIC,'k-*','linewidth',1)
hold on
plot(order,AICc,'k-o','linewidth',1)
hold on
plot(order,log(E),'r-d','linewidth',1)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthWest');
set(legend1,'FontSize',11,'Interpreter','latex');
xlabel('Model order','FontSize',12,'Interpreter','latex')
ylabel('Prediction error','FontSize',12,'Interpreter','latex')
title('\textbf{Optimal model order for x}','FontSize',12,'Interpreter','latex')

%%  LMS ALgorithm applied to voice recordings %%
close all; clear all; clc;
%% "a" sound %%
time = 1:1000;
load('sound_a.mat');
order = 5;
mu = 0.06;
clear figure;
figure(1) = figure('Color',[1 1 1]);

subplot(5,2,1); grid on; hold on;
[ lmsa_hat, lmsa_err, lmsa_arcoeff ] = ar_lms( sound_a, mu, order );
    
for i = 1:order
    plot(time,lmsa_arcoeff(i,2:end));
    hold on 
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{LMS for a}','FontSize',12,'Interpreter','latex');

subplot(5,2,2); grid on; hold on;
epsilon = 0.0001;
mu = 0.17;
[ nlmsa_hat, nlmsa_err, nlmsa_arcoeff ] = nlms( sound_a, mu, order,epsilon );

for i = 1:order
    plot(time,nlmsa_arcoeff(i,2:end));
    hold on
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{NLMS for a}','FontSize',12,'Interpreter','latex');

%% "e" sound %%
time = 1:1000;
load('sound_e.mat');
order = 3;
mu = 0.06;

subplot(5,2,3); grid on; hold on;
[ lmse_hat, lmse_err, lmse_arcoeff ] = ar_lms( sound_e, mu, order );
    
for i = 1:order
    plot(time,lmse_arcoeff(i,2:end));
    hold on 
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{LMS for e}','FontSize',12,'Interpreter','latex');

subplot(5,2,4); grid on; hold on;
epsilon = 0.0001;
mu = 0.17;
[ nlmse_hat, nlmse_err, nlmse_arcoeff ] = nlms( sound_e, mu, order,epsilon );

for i = 1:order
    plot(time,nlmse_arcoeff(i,2:end));
    hold on
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{NLMS for e}','FontSize',12,'Interpreter','latex');

%% "s" sound %%
time = 1:1000;
load('sound_s.mat');
order = 2;
% mu = 0.06;
mu = 2
sound_s = sound_s-mean(sound_s);
subplot(1,2,1); grid on; hold on;
[ lmss_hat, lmss_err, lmss_arcoeff ] = ar_lms( sound_s, mu, order );
    
for i = 1:order
    plot(time,lmss_arcoeff(i,2:end));
    hold on 
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{LMS for s}','FontSize',12,'Interpreter','latex');

subplot(1,2,2); grid on; hold on;
epsilon = 0.0001;
mu = 0.17;
[ nlmss_hat, nlmss_err, nlmss_arcoeff ] = nlms( sound_s, mu, order,epsilon );

for i = 1:order
    plot(time,nlmss_arcoeff(i,2:end));
    hold on
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{NLMS for s}','FontSize',12,'Interpreter','latex');

%% "t" sound %%
time = 1:1000;
load('sound_t.mat');
order = 3;
mu = 0.06;

subplot(5,2,7); grid on; hold on;
[ lmst_hat, lmst_err, lmst_arcoeff ] = ar_lms( sound_t, mu, order );
    
for i = 1:order
    plot(time,lmst_arcoeff(i,2:end));
    hold on 
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{LMS for t}','FontSize',12,'Interpreter','latex');

subplot(5,2,8); grid on; hold on;
epsilon = 0.0001;
mu = 0.17;
[ nlmst_hat, nlmst_err, nlmst_arcoeff ] = nlms( sound_t, mu, order,epsilon );

for i = 1:order
    plot(time,nlmst_arcoeff(i,2:end));
    hold on
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{NLMS for t}','FontSize',12,'Interpreter','latex');

%% "x" sound %%
time = 1:1000;
load('sound_x.mat');
order = 8;
mu = 0.06;

subplot(5,2,9); grid on; hold on;
[ lmsx_hat, lmsx_err, lmsx_arcoeff ] = ar_lms( sound_x, mu, order );
    
for i = 1:order
    plot(time,lmsx_arcoeff(i,2:end));
    hold on 
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{LMS for x}','FontSize',12,'Interpreter','latex');

subplot(5,2,10); grid on; hold on;
epsilon = 0.0001;
mu = 0.17;
[ nlmsx_hat, nlmsx_err, nlmsx_arcoeff ] = nlms( sound_x, mu, order,epsilon );

for i = 1:order
    plot(time,nlmsx_arcoeff(i,2:end));
    hold on
end

xlabel('Discrete time','FontSize',12,'Interpreter','latex')
ylabel('AR coefficients','FontSize',12,'Interpreter','latex')
title('\textbf{NLMS for x}','FontSize',12,'Interpreter','latex');