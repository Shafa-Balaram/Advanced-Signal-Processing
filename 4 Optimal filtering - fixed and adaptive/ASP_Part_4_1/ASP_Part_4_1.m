% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                              4.1  Wiener filter                         %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;
% seed
randn('state',1);

x = randn(1000,1);
a = [1];
b = [1 2 3 2 1];
y = filter(b,a,x);
norm_y = (y-mean(y))./std(y);

% Additive noise
eta = 0.1 .* randn(1000,1);
z = norm_y+eta;

% Signal-to-noise ratio
SNR = snr(norm_y,eta);

% Cross-correlation of x and z
len = length(x);
Nw = 4;
rzx = xcorr(z,x,'unbiased'); 
pzx = rzx(len:len+Nw);

% Autocorrelation of x 
rxx = xcorr(x,'unbiased');
Rxx = toeplitz(rxx(len:len+Nw));

% Optimal coefficients of Wiener filter
wopt = (inv(Rxx))*pzx;

% Scaling the optimal coefficients by the standard deviation of y
w_opt = std(y).*wopt;

%% Effect of noise power on SNR
clc; clear all;
randn('state',1);

x = randn(1000,1);
a = [1];
b = [1 2 3 2 1];
y = filter(b,a,x);
norm_y = (y-mean(y))./std(y);
sigsq = [0.1 0.5 1 2 5 10];
Nw = 4;

for i = 1:6
    
    % Additive noise
    eta = sigsq(i).*randn(1000,1);
    z = norm_y+eta;
    
    % Signal-to-noise ratio
    SNR(i) = snr(norm_y,eta);
    
    % Cross-correlation of x and z
    len = length(x);
    rzx = xcorr(z,x,'unbiased');
    pzx = rzx(len:len+Nw);
    
    % Autocorrelation of x
    rxx = xcorr(x,'unbiased');
    Rxx = toeplitz(rxx(len:len+Nw));
    
    % Optimal coefficients of Wiener filter
    wopt = (inv(Rxx))*pzx;
    
    % Scaling the optimal coefficients by the standard deviation of y
    w_opt(:,i) = std(y).*wopt;
    
    % error signal
    e = y - filter(w_opt(:,i),[1],x);
    J(i) = 0.5*mean(e.^2);
    % Mean squared error
    %mse(i) = immse(y, filter(w_opt(:,i),[1],x));
end

clear figure;
figure(1) = figure('Color',[1 1 1]);
plot(sigsq,SNR,'k-*','linewidth',1.5);
xlabel('\bf{Variance, $$\sigma^2$$}','FontSize',16,'Interpreter','latex')
ylabel('\bf{SNR / dB}','FontSize',16,'Interpreter','latex')
title('$$\bf{Effect \ of \ varying \ variance \ \sigma^2 \ on \ SNR}$$','FontSize',18,'Interpreter','latex')

clear figure;
figure(2) = figure('Color',[1 1 1]);
plot(sigsq,J,'k-*','linewidth',1.5)
xlabel('\bf{Variance, $$\sigma^2$$}','FontSize',16,'Interpreter','latex')
ylabel('\bf{J}','FontSize',16,'Interpreter','latex')
title('\bf{Effect of varying variance $$\sigma^2$$ on cost function J}','FontSize',18,'Interpreter','latex')

%% Effect of increasing Nw
clc; clear all; close all;

order = [5 7 9 11];
Nw = order-1;

randn('state',1);
x = randn(1000,1);
a = [1];
b = [1 2 3 2 1];
y = filter(b,a,x);
norm_y = (y-mean(y))./std(y);

% Additive noise
eta = 0.1.*randn(1000,1);
z = norm_y+eta;

% Signal-to-noise ratio
SNR = snr(norm_y,eta);

for i = 1:4
    
    % Cross-correlation of x and z
    len = length(x);
    rzx = xcorr(z,x,'unbiased');
    pzx = rzx(len:len+Nw(i));
    
    % Autocorrelation of x
    rxx = xcorr(x,'unbiased');
    Rxx = toeplitz(rxx(len:len+Nw(i)));
    
    % Optimal coefficients of Wiener filter
    wopt = (inv(Rxx))*pzx;
    
    % Scaling the optimal coefficients by the standard deviation of y
    w_opt = std(y).*wopt;
    
    % error signal
    e = y - filter(w_opt,[1],x);
    J(i) = 0.5*mean(e.^2);
    
end

clear figure;
figure(1) = figure('Color',[1 1 1]);
plot(order,J,'k-*','linewidth',1.5)
xlabel('\bf{Filter length, $$N_w$$}','FontSize',16,'Interpreter','latex')
ylabel('\bf{J}','FontSize',16,'Interpreter','latex')
title('\bf{Cost function J for different Wiener filter lengths}','FontSize',18,'Interpreter','latex')


    
    