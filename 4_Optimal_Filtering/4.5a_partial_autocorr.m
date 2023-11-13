% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%                             4.5 Speech Recognition                      %
%                                  March 2018                             %                       
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%%          Partial Autocorrelation Function of the recordings           %%

% load the recordings
close all; clear all; close all;

load('sound_a.mat');
load('sound_e.mat');
load('sound_s.mat');
load('sound_t.mat');
load('sound_x.mat');

for p = 1:10
    
    a = aryule(sound_a,p);
    a_pacf(p) = -a(end);
    
    e = aryule(sound_e,p);
    e_pacf(p) = -e(end);
    
    s = aryule(sound_s,p);
    s_pacf(p) = -s(end);
    
    t = aryule(sound_t,p);
    t_pacf(p) = -t(end);
    
    x = aryule(sound_x,p);
    x_pacf(p) = -x(end);
    
end

upper_bound(1:10) = 0.1181;
lower_bound(1:10) = -0.1181;

clear figure;
figure(1) = figure('Color',[1 1 1]);

subplot(1,5,1); grid on; hold on; 
stem(a_pacf,'k','filled'); hold on;
plot(upper_bound,'r--','linewidth',1); hold on;
plot(lower_bound,'r--','linewidth',1);
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of a}','FontSize',12,'Interpreter','latex');

subplot(1,5,2); grid on; hold on; 
stem(e_pacf,'k','filled'); hold on;
plot(upper_bound,'r--','linewidth',1); hold on;
plot(lower_bound,'r--','linewidth',1);
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of e}','FontSize',12,'Interpreter','latex');

subplot(1,5,3); grid on; hold on; 
stem(s_pacf,'k','filled'); hold on;
plot(upper_bound,'r--','linewidth',1); hold on;
plot(lower_bound,'r--','linewidth',1);
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of s}','FontSize',12,'Interpreter','latex');

subplot(1,5,4); grid on; hold on; 
stem(t_pacf,'k','filled'); hold on;
plot(upper_bound,'r--','linewidth',1); hold on;
plot(lower_bound,'r--','linewidth',1);
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of t}','FontSize',12,'Interpreter','latex');

subplot(1,5,5); grid on; hold on; 
stem(x_pacf,'k','filled'); hold on;
plot(upper_bound,'r--','linewidth',1); hold on;
plot(lower_bound,'r--','linewidth',1);
xlabel('Correlation lag','FontSize',12,'Interpreter','latex');
ylabel('PACF','FontSize',12,'Interpreter','latex');
title('\textbf{PACF of x}','FontSize',12,'Interpreter','latex');