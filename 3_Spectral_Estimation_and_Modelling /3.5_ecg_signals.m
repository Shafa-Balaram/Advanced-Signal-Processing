% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%  3.5 Real-world signals: respiratory sinus arrhythmia from RR-Intervals %
%                                  March 2018                             %                     
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;

load('rr1.mat');
load('rr2.mat');
load('rr3.mat');

% Standard periodogram of each trial
rr1 = detrend(rr1); rr2 = detrend(rr2); rr3 = detrend(rr3);

[psd_rr1,f1] = pgm(rr1);
[psd_rr2,f2] = pgm(rr2);
[psd_rr3,f3] = pgm(rr3);
 
clear figure;
figure(1) = figure('Color',[1 1 1]); 

subplot(1,3,1); grid on; hold on;
plot(f1,10.*log10(psd_rr1)); xlim([0 0.5]); ylim([-90 0])
xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{Standard PSD [dB/sample/rad]}','FontSize',18,'Interpreter','latex');
title('\bf{Trial 1}','FontSize',18,'Interpreter','latex')

subplot(1,3,2); grid on; hold on;
plot(f2,10.*log10(psd_rr2)); xlim([0 0.5]); ylim([-90 0])
title('\bf{Trial 2}','FontSize',18,'Interpreter','latex')


subplot(1,3,3); grid on; hold on;
plot(f3,10.*log10(psd_rr3)); xlim([0 0.5]); ylim([-90 0])
title('\bf{Trial 3}','FontSize',18,'Interpreter','latex')

%% Averaged periodogram
% I. Window length ~50s 
% new sampling frequency obtained from ECG_to_RRI
load('rr1.mat');
load('rr2.mat');
load('rr3.mat');

% Standard periodogram of each trial
rr1 = detrend(rr1);
rr2 = detrend(rr2);
rr3 = detrend(rr3);

fs = 4;

clear figure;
figure(2) = figure('Color',[1 1 1]); grid on; hold on; 

subplot(1,3,1)
[psd_rr1,f1] = pgm(rr1); 
l = length(rr1);
plot(f1(1:l/2),10*log10(psd_rr1(1:l/2)));
hold on;

winlen = [50 150];

for i = 1:length(winlen)
    [avPrr1] = avgpgm(rr1,winlen(i)); 
    f = [0:winlen(i)-1]./winlen(i);
    plot(f(1:winlen(i)/2),10*log10(avPrr1(1:winlen(i)/2)),'linewidth',1.5);
    hold on;
end
ylim([-90 0])
    
%end
legend1 = legend('Standard','Window=50 s','Window=150 s','Location','SouthOutside');
set(legend1,'FontSize',14,'Interpreter','latex');
title('\bf{Trial 1}','FontSize',18,'Interpreter','latex');

subplot(1,3,2)
[psd_rr2,f2] = pgm(rr2); 
l = length(rr2);
plot(f2(1:l/2),10*log10(psd_rr2(1:l/2)));
hold on;

winlen = [50 150];

for i = 1:length(winlen)
    [avPrr2] = avgpgm(rr2,winlen(i)); 
    f = [0:winlen(i)-1]./winlen(i);
    plot(f(1:winlen(i)/2),10*log10(avPrr2(1:winlen(i)/2)),'linewidth',1.5);
    hold on;
end
ylim([-90 0])
    

legend1 = legend('Standard','Window=50 s','Window=150 s','Location','SouthOutside');
set(legend1,'FontSize',14,'Interpreter','latex');
xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{PSD [dB/rad/sample]}','FontSize',18,'Interpreter','latex'); 
title('\bf{Trial 2}','FontSize',18,'Interpreter','latex');

subplot(1,3,3)
[psd_rr3,f3] = pgm(rr3); 
l = length(rr3); 
plot(f3(1:l/2),10*log10(psd_rr3(1:l/2)));
hold on;

winlen = [50 150];

for i = 1:length(winlen)
    [avPrr3] = avgpgm(rr3,winlen(i)); 
    f = [0:winlen(i)-1]./winlen(i);
    plot(f(1:winlen(i)/2),10*log10(avPrr3(1:winlen(i)/2)),'linewidth',1.5);
    hold on;
end
ylim([-90 0])
    
legend1 = legend('Standard','Window=50 s','Window=150 s','Location','SouthOutside');
set(legend1,'FontSize',14,'Interpreter','latex');
title('\bf{Trial 3}','FontSize',18,'Interpreter','latex');
