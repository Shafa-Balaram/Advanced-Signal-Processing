% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%    Example code for generating the Partial Autocorrelation Function     %
%                                  March 2018                             %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;
% The sunspot time series
load('sunspot.dat');
ss = sunspot(:,2);

clear figure;
figure(1) = figure('Color',[1 1 1]);
grid on; hold on;
[pacf,lags,bounds] = parcorr(ss,10);
partialACF = -pacf(2:end);
order = 1:10;

stem(partialACF,'k','filled'); hold on;
upperbound(1:10) = bounds(1); lowerbound(1:10) = bounds(2);
plot(order,upperbound,'r--','linewidth',1); hold on;
plot(order,lowerbound,'r--','linewidth',1);


title('\bf{Partial ACF of the sunspot time series}','FontSize',18,'Interpreter','latex')
xlabel('Correlation lag','FontSize',16,'Interpreter','latex')
ylabel('Correlation','FontSize',16,'Interpreter','latex')

