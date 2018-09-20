% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                         2 Linear Stochastic Modelling                   %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

%%           2.1 ACF of uncorrelated and correlated sequences            %%
close all; clear all; clc;

% Part 1
% Generate a white Gaussian noise with 1000 samples
x = randn(1000,1);

% Unbiased estimate of the ACF of x
[acf_x,tau] = xcorr(x,'unbiased');

% Display the ACF
figure(1) = figure('Color',[1 1 1]);
plot(tau, acf_x);
axis([-999 999 min(acf_x) max(acf_x)]);
xlabel('\bf{Correlation lag, $$\tau$$}','FontSize',16,'Interpreter','latex');
ylabel('\bf{ACF magnitude}','FontSize',16,'Interpreter','latex');
title('\bf{ACF of WGN process x}','FontSize',18,'Interpreter','latex');

% Part 2: Zoom in onto |tau|<50
zoom on

% To plot the zoomed in region of the ACF
clear figure
figure(2) = figure('Color',[1 1 1]);
plot(tau, acf_x);
axis([-49 49 min(acf_x(950:1050)) max(acf_x(950:1050))]);
xlabel('\bf{Correlation lag, $$\tau$$}','FontSize',16,'Interpreter','latex');
ylabel('\bf{ACF magnitude}','FontSize',16,'Interpreter','latex');
title('\bf{ACF of x for $$|\tau|<50$$}','FontSize',18,'Interpreter','latex');

%% Part 3 %%
close all; clear all; clc;

% Generate a white Gaussian noise realisation with 1000 samples
x = randn(1000,1);

% Filter by 9th order MA filter
y = filter(ones(9,1),[1],x);

% ACF estimate of y
[acf_y,tau] = xcorr(y,'unbiased');

% Plot of ACF for |time lag|<20
figure(3) = figure('Color',[1 1 1]);
stem(tau,acf_y,'filled')
xlim([-20 20])
xlabel('\bf{Correlation Lag}','FontSize',16,'Interpreter','latex')
ylabel('\bf{Correlation}','FontSize',16,'Interpreter','latex')
title('\bf{ACF of \textbf{y} obtained by MA(9) filter}','FontSize',18,'Interpreter','latex')

%%                      2.2 Cross-correlation function                   %%

% CCF of x and y from part 2.1 part 4
[ccf_xy,tau] = xcorr(x,y,'unbiased');

% Plot of ACF for |time lag|<20
clear figure
figure(3) = figure('Color',[1 1 1]); grid on; hold on;

stem(tau,ccf_xy,'filled')
xlim([-20 20])
xlabel('\bf{Correlation lag}, $$\tau$$','FontSize',16,'Interpreter','latex')
ylabel('\bf{Cross-correlation}','FontSize',16,'Interpreter','latex')
title('\bf{Unbiased CCF estimate of x and y for $$|\tau|<20$$}','FontSize',18,'Interpreter','latex')