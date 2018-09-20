% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                          2.3 Autoregressive Modelling                   %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% Part 1
clear all; close all; clc;

% Generate 100 samples of a1 between -2.5 and 2.5
a1 = -2.5 + 5.*rand(100,1);

% Generate 100 samples of a2 between -1.5 and 1.5
a2 = -1.5 + 3.*rand(100,1);

randn('state',1);

% 1 realisation of white gaussian noise
w = randn(1000,1);

% initialise a matrix of 'a' coefficients which make x converge
stable_a = [];

for i = 1:length(a1)
    % Coefficients of the AR(2) process
    a = [a1(i) a2(i)];
    a = [1 -a];
    x = filter(1,a,w);
  
    % Check for convergence 
    if abs(x(end)) < 10  
       % save the coefficients which stabilise x
       stable_a = [stable_a; a1(i) a2(i)];
    end
end

clear figure;
figure(1) = figure('Color',[1 1 1]);
subplot(1,2,1);

plot(stable_a(:,1),stable_a(:,2),'k*');
xlabel('\bf{$$a_1$$}','FontSize',16,'Interpreter','latex');  
ylabel('\bf{$$a_2$$}','FontSize',16,'Interpreter','latex');
title('\bf{AR(2) process with 100 coefficients}','FontSize',18,'Interpreter','latex')

hold on 
% Limits of the stability triangle
x1 = 0:0.01:2;
y1 = 1-x1;
plot(x1,y1,'r--','linewidth',1.5);
hold on
x2 = -2:0.01:0;
y2 = 1+x2;
plot(x2,y2,'r--','linewidth',1.5);
hold on
x3 = -2:0.02:2;
y3(1:length(x3)) = -1;
plot(x3,y3,'r--','linewidth',1.5);

% Repeat with more coefficients
% Generate 1000 samples of a1 between -2.5 and 2.5
a1 = -2.5 + 5.*rand(1000,1);

% Generate 1000 samples of a2 between -1.5 and 1.5
a2 = -1.5 + 3.*rand(1000,1);

randn('state',1);

% 1 realisation of white gaussian noise
w = randn(1000,1);

% initialise a matrix of 'a' coefficients which make x converge
stable_a = [];


for i = 1:length(a1)
    
    % Coefficients of the AR(2) process
    a = [a1(i) a2(i)];
    a = [1 -a];
    x = filter(1,a,w);
  
    % Check for convergence and plot only then
    if abs(x(end)) < 10
 
       % save the coefficients which stabilise x
       stable_a = [stable_a; a1(i) a2(i)];
    end
end

subplot(1,2,2);

plot(stable_a(:,1),stable_a(:,2),'k*');
xlabel('\bf{$$a_1$$}','FontSize',16,'Interpreter','latex');  
ylabel('\bf{$$a_2$$}','FontSize',16,'Interpreter','latex');
title('\bf{AR(2) process with 1000 coefficients}','FontSize',18,'Interpreter','latex')

hold on 
% Limits of the stability triangle
x1 = 0:0.01:2;
y1 = 1-x1;
plot(x1,y1,'r--','linewidth',1.5);
hold on
x2 = -2:0.01:0;
y2 = 1+x2;
plot(x2,y2,'r--','linewidth',1.5);
hold on
x3 = -2:0.02:2;
y3(1:length(x3)) = -1;
plot(x3,y3,'r--','linewidth',1.5);

%% Part 2: The sunspot time series
close all; clear all; clc;

% load the sunspot time series
load('sunspot.dat')
clear figure;
figure(2) = figure('Color',[1 1 1]);

centre_ss = sunspot(:,2);
time = 1700:1987;
plot(time, centre_ss)
xlabel('\bf{Time [years]}','FontSize',16,'Interpreter','latex')
ylabel('\bf{Amplitude}','FontSize',16,'Interpreter','latex')
title('\bf{Sunspot Time Series}','FontSize',18,'Interpreter','latex')

% Unbiased ACF estimate of the series
clear figure;
figure(3) = figure('Color',[1 1 1]);
i = 1; %counter

% Plot of ACF for different data lengths, N
for N = [5 20 250]
    subplot(3,1,i)
    [acf_ss,tau] = xcorr(centre_ss(1:N),'unbiased');
    stem(tau,acf_ss)
    title(['\bf{N=' num2str(N) '}'],'FontSize',18,'Interpreter','latex')
    i = i+1;
end
xlabel('\bf{Correlation Lag}','FontSize',18,'Interpreter','latex')
ylabel('\bf{ACF}','FontSize',18,'Interpreter','latex')


%% Centre the series
clear figure;
figure(4) = figure('Color',[1 1 1]);
j = 1; %counter

for N = [5 20 250]
    subplot(3,1,j)
    ctr_ss(1:N) = centre_ss(1:N)-mean(centre_ss(1:N));
    [acf_ctrss,tau] = xcorr(ctr_ss,'unbiased');
    
    stem(tau,acf_ctrss)
    title(['\bf{N=' num2str(N) '}'],'FontSize',18,'Interpreter','latex')
    j = j+1;
end

xlabel('\bf{Correlation Lag}','FontSize',18,'Interpreter','latex')
ylabel('\bf{ACF}','FontSize',18,'Interpreter','latex')

%% Part 3: Using the Yule-Walker to find the partial correlation functions
% Original sunspot series
clear figure;
figure(5) = figure('Color',[1 1 1]);

for p = 1:10
    [a,e] = aryule(centre_ss,p);
    display(a);
end
parcorr(centre_ss);

clear figure;
figure(6) = figure('Color',[1 1 1]);

% Normalised sunspot series
norm_ss=(centre_ss-mean(centre_ss))./std(centre_ss);
parcorr(norm_ss);
for p = 1:10
    [norm_a,e] = aryule(norm_ss,p);
    display(norm_a);
end

%% Part 4: Determining the correct model order for the standardised data
clear all; close all;

% Reload the sunspot time series data
load('sunspot.dat')
centre_ss = sunspot(:,2);

% Standardise the data
norm_ss=(centre_ss-mean(centre_ss))./std(centre_ss);

% Using the same WGN for every simulation 
randn('state',4);

% WGN realisation for the predicted AR process
w = randn(length(norm_ss)+19,1);
w = [norm_ss(1); w];


for p = 1:10
    [norm_a,e] = aryule(norm_ss,p);
    
    % The predicted AR process
    a = norm_a;
    x = filter(1,a,w); 
    x = x(21:end);
    x = (x-mean(x))./std(x);
    AR(p,:) = x;
    
    % The unbiased ACF estimate for each model order
    acf_normx = xcorr(x,'unbiased');
    
    % squared error between model and actual data
    se = (norm_ss-x).^2;
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_ss);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
    
clear figure;
figure(7) = figure('Color',[1 1 1]);

order = 1:10;
plot(order,MDL,'-s','linewidth',1.5)
hold on
plot(order,AIC,'k-*','linewidth',1.5)
hold on
plot(order,AICc,'k-o','linewidth',1.5)
hold on
plot(order,log(E),'r-d','linewidth',1.5)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthWest');
set(legend1,'FontSize',12,'Interpreter','latex');

xlabel('\bf{Model order p}','FontSize',16,'Interpreter','latex')
ylabel('\bf{Prediction error}','FontSize',16,'Interpreter','latex')
title('\bf{Model order selection for the sunspot time series}','FontSize',18,'Interpreter','latex')
