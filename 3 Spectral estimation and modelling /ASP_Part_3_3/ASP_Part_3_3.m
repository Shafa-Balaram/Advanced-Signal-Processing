% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%          3.3 The Least Square Estimation (LSE) of AR Coefficients       %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;

% Parts 3 and 4
% The sunspot time series
load('sunspot.dat');
ss = sunspot(:,2);

a = zeros(10,11);

% AR coefficients applying LSE approach 
N = length(ss);
norm_ss = (ss-mean(ss))/std(ss);

% WGN 
randn('state',1)
wgn = randn(N,1);
a = zeros(10,1);
coeff = zeros(10,10);

for p = 1:10

    % Biased ACF estimate
    xacf = xcorr(ss,'biased');
    rxx = xacf(N:end);

    % observation matrix H
    H = toeplitz(rxx(1:p));

    % AR coeff
    arcoeff = inv(H'*H)*H'*rxx(2:p+1);
    coeff(p,1:p) = arcoeff;
    disp(arcoeff');
    a(p) = arcoeff(end);
    
    % AR model
    AR = filter(1,[1 -arcoeff'],wgn);
    normAR =( AR-mean(AR))/std(AR);
    cse(p) = sum((normAR-norm_ss).^2);
    
end

clear figure;
figure(1) = figure('Color',[1 1 1]); grid on; hold on;
order = 1:10;

stem(order,a,'k','filled'); hold on;
upperbound(1:10) = 0.1181; lowerbound(1:10) = -0.1181;
plot(order,upperbound,'r--','linewidth',1); hold on;
plot(order,lowerbound,'r--','linewidth',1);

title('\bf{}','FontSize',18,'Interpreter','latex')
xlabel('Correlation lag','FontSize',16,'Interpreter','latex')
ylabel('Correlation','FontSize',16,'Interpreter','latex')

clear figure;
figure(2) = figure('Color',[1 1 1]); grid on; hold on;
plot(order,log10(cse),'k-*','linewidth',1.5);
xlabel('model order','FontSize',16,'Interpreter','latex');
ylabel('log (MSE)','FontSize',16,'Interpreter','latex');
title('\bf{Approximation error of AR models using LSE}','FontSize',18,'Interpreter','latex');

%% Part 5
randn('state',1);
clear figure;
figure(3) = figure('Color',[1 1 1]);
norm_ss = (ss-mean(ss))/std(ss);
ss_acf = xcorr(norm_ss,'unbiased');

for p = 1:10
    sigsq = ss_acf(N) - (coeff(p,1:p)*ss_acf(N-1:-1:N-p));
    [h,w] = freqz(sigsq,[1 -coeff(p,1:p)],512);
    
    subplot(2,5,p); grid on; hold on;
    plot(w./(2*pi),10*log10(abs(h).^2),'linewidth',1);
    hold on
    [pgmss,f] = pgm(norm_ss);
    plot(f,10*log10(pgmss))
    hold on
    xlim([0 0.5]); ylim([-50 50])
    
    xlabel('f','FontSize',16,'Interpreter','latex'); 
    ylabel('PSD','FontSize',16,'Interpreter','latex');
    title(['\bf{AR(' num2str(p) ')}'],'FontSize',18,'Interpreter','latex') 
%     
end

%% Part 6 
close all; clear all; clc; 
% The sunspot time series
load('sunspot.dat');
ss= sunspot(:,2);
norm_ss = (ss-mean(ss))./std(ss);

% optimal order
p = 2;

% counter 
c=1;

% WGN realisation for the predicted AR process
randn('state',13)
l = length(norm_ss);

% AR model
w = randn(l,1);

for N = 10:5:250

    % Biased ACF estimate
    acf_ss = xcorr(norm_ss(1:N),'biased');
    rxx = acf_ss(N:end);

    % observation matrix H
     H = toeplitz(rxx(1:p));
    
    % AR coeff
    arcoeff = inv(H'*H)*H'*rxx(2:p+1);
    coeff(p,1:p) = arcoeff;
    
    AR = filter(1,[1 -arcoeff'],w);
    
    normAR =( AR-mean(AR))/std(AR);
    cse(c) = sum((normAR-norm_ss).^2);
   
    c = c+1;
    
end

clear figure;
figure(4) = figure('Color',[1 1 1]); grid on; hold on;
plot(10:5:250,log10(cse),'linewidth',1.5);
xlabel('data length N','FontSize',16,'Interpreter','latex');
ylabel('log (MSE)','FontSize',16,'Interpreter','latex');
title('\bf{Approximation error for the optimal AR(2) model}','FontSize',18,'Interpreter','latex');
    