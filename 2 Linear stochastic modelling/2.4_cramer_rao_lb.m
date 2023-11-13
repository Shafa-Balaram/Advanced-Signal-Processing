% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%                          2.4 Cramer Rao Lower Bound                     %
%                                  March 2018                             %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% Part 1 (a)
clear all; close all; clc;

% Load the NASDAQ time series data
load('NASDAQ.mat')
prices = NASDAQ.Close;
dates = NASDAQ.Date;

clear figure;
figure(2) = figure('Color',[1 1 1]);
grid on; hold on;
plot(dates,prices,'linewidth', 1.5); 
xlabel('\bf{Dates}', 'FontSize',16,'Interpreter','latex'); 
ylabel('\bf{NASDAQ Value}', 'FontSize',16,'Interpreter','latex');
title('\bf{NASDAQ financial Index for June 2003-February 2007}', 'FontSize',18,'Interpreter','latex')

%%  Partial ACF
clear figure;
figure(1) = figure('Color',[1 1 1]);
grid on; hold on;
parcorr(prices,10);

title('\bf{PACF of the NASDAQ closing prices}','FontSize',18,'Interpreter','latex')
xlabel('\bf{Correlatio                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   n lag}','FontSize',16,'Interpreter','latex')
ylabel('\bf{Correlation}','FontSize',16,'Interpreter','latex')


%% WGN realisation for the predicted AR process
w = randn(length(prices),1);
cse = [];

norm_prices = (prices-mean(prices))./std(prices);

for p = 1:10
    [norm_a,e] = aryule(norm_prices,p);
    
    % The predicted AR process
    a = -norm_a(2:end);
    x = filter(1,a,w);
    
    % Standardise
    norm_x = (x-mean(x))./std(x);
    AR(p,:) = norm_x;
    
    % The unbiased ACF estimate for each model order
    acf_normx = xcorr(norm_x,'unbiased');
    
    % squared error between model and actual data
    se = (norm_prices-x).^2;
    
    % cumulative squared error
    E(p) = sum(se);
    
    % MDL
    N = length(norm_prices);
    MDL(p) = log(E(p)) + (p*log(N)/N);
    
    % AIC
    AIC(p) = log(E(p)) + (2*p/N);
    
    % AICc
    AICc(p) = AIC(p) + (2*p*(p+1)/(N-p-1));
    
end
    
clear figure;
figure(2) = figure('Color',[1 1 1]); grid on; hold on;
order = 1:10;
plot(order,MDL,'-s','linewidth',1.5)
hold on
plot(order,AIC,'k-*','linewidth',1.5)
hold on
plot(order,AICc,'k-o','linewidth',1.5)
hold on
plot(order,log(E),'r-d','linewidth',1.5)

legend1 = legend('MDL','AIC','AICc','CSE','Location','NorthWest');
set(legend1,'FontSize',14,'Interpreter','latex');
xlabel('\bf{Model order, p}','FontSize',16,'Interpreter','latex')
ylabel('\bf{Prediction error}','FontSize',16,'Interpreter','latex')
title('\bf{Model order selection for the standardised NASDAQ series}','FontSize',18,'Interpreter','latex')

%% Part 1 (b) %%
% Number of data points
N = [1:50:1001];

% True variance of the driving noise
var = [1:50:1001];

[Nval,sigsq] = meshgrid(N,var);

% The CRLB for thes estimated variance
crlb_var = 2.*(sigsq.^2)./Nval;

clear figure;
figure(1) = figure('Color',[1 1 1]);
h1 = heatmap(N,var,crlb_var);
h1.Title = 'Heatmap for the CRLB of the estimated variance';
h1.XLabel = 'N';
h1.YLabel = 'Variance';

%% The CRLB for the estimated a1 
% centre NASDAQ series
centre_nasdaq = prices-mean(prices);
[acf_nasdaq,lag] = xcorr(centre_nasdaq,'unbiased');
len = length(prices);
% ACF of x at 0 using NASDAQ series
rxx0 = max(acf_nasdaq);

% The CRLB for the estimated variance
crlb_var = sigsq./(Nval.*rxx0);

% heatmap against var
clear figure;
figure(1) = figure('Color',[1 1 1]);
h1 = heatmap(N,var,crlb_var);
h1.Title = 'Heatmap for the CRLB of the estimated variance';
h1.XLabel = 'N';
h1.YLabel = 'Variance';

